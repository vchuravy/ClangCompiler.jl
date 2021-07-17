"""
    abstract type AbstractCompiler <: Any
Supertype for Clang compilers.
"""
abstract type AbstractCompiler end

struct SimpleCompiler <: AbstractCompiler
    ctx::Context
    instance::CompilerInstance
end

function create_compiler(src::String, args::Vector{String}; diag_show_colors=true)
    ctx = Context()
    instance = CompilerInstance()
    # diagnostics
    set_opt_show_presumed_loc(instance, true)
    set_opt_show_colors(instance, diag_show_colors)
    create_diagnostics(instance)
    diag = get_diagnostics(instance)
    # invocation
    # do not emit `__dso_handle` etc.
    insert!(args, length(args), "-fno-use-cxa-atexit")
    invok = create_compiler_invocation_from_cmd(src, args, diag)
    set_invocation(instance, invok)
    set_target(instance)
    # source
    create_file_manager(instance)
    create_source_manager(instance)
    set_main_file(instance, src)
    # preprocessor & AST & sema
    create_preprocessor(instance)
    create_ast_context(instance)
    set_ast_consumer(instance, create_llvm_codegen(instance, ctx))
    create_sema(instance)
    # parser
    preprocessor = get_preprocessor(instance)
    sema = get_sema(instance)
    return SimpleCompiler(ctx, instance)
end

function destroy(x::SimpleCompiler)
    destroy(x.instance)
    dispose(x.ctx)
end

function compile(x::SimpleCompiler)
    parse(x.instance) || error("failed to parse the source code.")
    m = get_llvm_module(CodeGenerator(get_ast_consumer(x.instance).ptr))
    m == C_NULL && error("failed to generate IR.")
    return LLVM.Module(m)
end

struct IRGenerator <: AbstractCompiler
    ctx::Context
    instance::CompilerInstance
    act::LLVMOnlyAction
    mod::LLVM.Module
end

function generate_llvmir(src::String, args::Vector{String}; diag_show_colors=true)
    ctx = Context()
    instance = CompilerInstance()
    # diagnostics
    set_opt_show_presumed_loc(instance, true)
    set_opt_show_colors(instance, diag_show_colors)
    create_diagnostics(instance)
    diag = get_diagnostics(instance)
    # invocation
    # do not emit `__dso_handle` etc.
    insert!(args, length(args), "-fno-use-cxa-atexit")
    invok = create_compiler_invocation_from_cmd(src, args, diag)
    set_invocation(instance, invok)
    # codegen action
    act = LLVMOnlyAction(ctx)
    execute_action(instance, act)
    return IRGenerator(ctx, instance, act, take_module(act))
end

get_module(x::IRGenerator) = x.mod

function destroy(x::IRGenerator)
    destroy(x.instance)
    destroy(x.act)
    dispose(x.mod)
    dispose(x.ctx)
end
