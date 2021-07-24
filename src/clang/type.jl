"""
    abstract type AbstractClangType <: Any
Supertype for `clang::Type`s.
"""
abstract type AbstractClangType end

"""
    QualType <: Any
Represent a qualified type.
"""
struct QualType
    ptr::CXType_
end
QualType(x::T) where {T<:AbstractBuiltinType} = QualType(x.ptr)

get_type_ptr(x::QualType) = clang_QualType_getTypePtr(x.ptr)
get_type_ptr_or_null(x::QualType) = clang_QualType_getTypePtrOrNull(x.ptr)

is_canonical(x::QualType) = clang_QualType_isCanonical(x.ptr)

is_null(x::QualType) = clang_QualType_isNull(x.ptr)

is_const(x::QualType) = clang_QualType_isConstQualified(x.ptr)
is_restrict(x::QualType) = clang_QualType_isRestrictQualified(x.ptr)
is_volatile_qualified(x::QualType) = clang_QualType_isVolatileQualified(x.ptr)

add_const(x::QualType) = clang_QualType_addConst(x.ptr)
add_restrict(x::QualType) = clang_QualType_addRestrict(x.ptr)
add_volatile(x::QualType) = clang_QualType_addVolatile(x.ptr)

"""
    CanQualType <: Any
Represent a canonical, qualified type.
"""
struct CanQualType
    ty::QualType
end
CanQualType(x::CXType_) = CanQualType(QualType(x))

"""
    abstract type AbstractBuiltinType <: AbstractClangType
Supertype for `clang::BuiltinType`s.
"""
abstract type AbstractBuiltinType <: AbstractClangType end

struct VoidTy <: AbstractBuiltinType
    ptr::CXType_
end

struct BoolTy <: AbstractBuiltinType
    ptr::CXType_
end

struct CharTy <: AbstractBuiltinType
    ptr::CXType_
end

struct WCharTy <: AbstractBuiltinType
    ptr::CXType_
end

struct WideCharTy <: AbstractBuiltinType
    ptr::CXType_
end

struct WIntTy <: AbstractBuiltinType
    ptr::CXType_
end

struct Char8Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct Char16Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct Char32Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct SignedCharTy <: AbstractBuiltinType
    ptr::CXType_
end

struct ShortTy <: AbstractBuiltinType
    ptr::CXType_
end

struct IntTy <: AbstractBuiltinType
    ptr::CXType_
end

struct LongTy <: AbstractBuiltinType
    ptr::CXType_
end

struct LongLongTy <: AbstractBuiltinType
    ptr::CXType_
end

struct Int128Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct UnsignedCharTy <: AbstractBuiltinType
    ptr::CXType_
end

struct UnsignedShortTy <: AbstractBuiltinType
    ptr::CXType_
end

struct UnsignedIntTy <: AbstractBuiltinType
    ptr::CXType_
end

struct UnsignedLongTy <: AbstractBuiltinType
    ptr::CXType_
end

struct UnsignedLongLongTy <: AbstractBuiltinType
    ptr::CXType_
end

struct UnsignedInt128Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct FloatTy <: AbstractBuiltinType
    ptr::CXType_
end

struct DoubleTy <: AbstractBuiltinType
    ptr::CXType_
end

struct LongDoubleTy <: AbstractBuiltinType
    ptr::CXType_
end

struct Float128Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct HalfTy <: AbstractBuiltinType
    ptr::CXType_
end

struct BFloat16Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct Float16Ty <: AbstractBuiltinType
    ptr::CXType_
end

struct FloatComplexTy <: AbstractBuiltinType
    ptr::CXType_
end

struct DoubleComplexTy <: AbstractBuiltinType
    ptr::CXType_
end

struct LongDoubleComplexTy <: AbstractBuiltinType
    ptr::CXType_
end

struct Float128ComplexTy <: AbstractBuiltinType
    ptr::CXType_
end

struct VoidPtrTy <: AbstractBuiltinType
    ptr::CXType_
end

struct NullPtrTy <: AbstractBuiltinType
    ptr::CXType_
end

struct LongTy <: AbstractBuiltinType
    ptr::CXType_
end
