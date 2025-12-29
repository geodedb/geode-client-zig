pub const __builtin_bswap16 = @import("std").zig.c_builtins.__builtin_bswap16;
pub const __builtin_bswap32 = @import("std").zig.c_builtins.__builtin_bswap32;
pub const __builtin_bswap64 = @import("std").zig.c_builtins.__builtin_bswap64;
pub const __builtin_signbit = @import("std").zig.c_builtins.__builtin_signbit;
pub const __builtin_signbitf = @import("std").zig.c_builtins.__builtin_signbitf;
pub const __builtin_popcount = @import("std").zig.c_builtins.__builtin_popcount;
pub const __builtin_ctz = @import("std").zig.c_builtins.__builtin_ctz;
pub const __builtin_clz = @import("std").zig.c_builtins.__builtin_clz;
pub const __builtin_sqrt = @import("std").zig.c_builtins.__builtin_sqrt;
pub const __builtin_sqrtf = @import("std").zig.c_builtins.__builtin_sqrtf;
pub const __builtin_sin = @import("std").zig.c_builtins.__builtin_sin;
pub const __builtin_sinf = @import("std").zig.c_builtins.__builtin_sinf;
pub const __builtin_cos = @import("std").zig.c_builtins.__builtin_cos;
pub const __builtin_cosf = @import("std").zig.c_builtins.__builtin_cosf;
pub const __builtin_exp = @import("std").zig.c_builtins.__builtin_exp;
pub const __builtin_expf = @import("std").zig.c_builtins.__builtin_expf;
pub const __builtin_exp2 = @import("std").zig.c_builtins.__builtin_exp2;
pub const __builtin_exp2f = @import("std").zig.c_builtins.__builtin_exp2f;
pub const __builtin_log = @import("std").zig.c_builtins.__builtin_log;
pub const __builtin_logf = @import("std").zig.c_builtins.__builtin_logf;
pub const __builtin_log2 = @import("std").zig.c_builtins.__builtin_log2;
pub const __builtin_log2f = @import("std").zig.c_builtins.__builtin_log2f;
pub const __builtin_log10 = @import("std").zig.c_builtins.__builtin_log10;
pub const __builtin_log10f = @import("std").zig.c_builtins.__builtin_log10f;
pub const __builtin_abs = @import("std").zig.c_builtins.__builtin_abs;
pub const __builtin_labs = @import("std").zig.c_builtins.__builtin_labs;
pub const __builtin_llabs = @import("std").zig.c_builtins.__builtin_llabs;
pub const __builtin_fabs = @import("std").zig.c_builtins.__builtin_fabs;
pub const __builtin_fabsf = @import("std").zig.c_builtins.__builtin_fabsf;
pub const __builtin_floor = @import("std").zig.c_builtins.__builtin_floor;
pub const __builtin_floorf = @import("std").zig.c_builtins.__builtin_floorf;
pub const __builtin_ceil = @import("std").zig.c_builtins.__builtin_ceil;
pub const __builtin_ceilf = @import("std").zig.c_builtins.__builtin_ceilf;
pub const __builtin_trunc = @import("std").zig.c_builtins.__builtin_trunc;
pub const __builtin_truncf = @import("std").zig.c_builtins.__builtin_truncf;
pub const __builtin_round = @import("std").zig.c_builtins.__builtin_round;
pub const __builtin_roundf = @import("std").zig.c_builtins.__builtin_roundf;
pub const __builtin_strlen = @import("std").zig.c_builtins.__builtin_strlen;
pub const __builtin_strcmp = @import("std").zig.c_builtins.__builtin_strcmp;
pub const __builtin_object_size = @import("std").zig.c_builtins.__builtin_object_size;
pub const __builtin___memset_chk = @import("std").zig.c_builtins.__builtin___memset_chk;
pub const __builtin_memset = @import("std").zig.c_builtins.__builtin_memset;
pub const __builtin___memcpy_chk = @import("std").zig.c_builtins.__builtin___memcpy_chk;
pub const __builtin_memcpy = @import("std").zig.c_builtins.__builtin_memcpy;
pub const __builtin_expect = @import("std").zig.c_builtins.__builtin_expect;
pub const __builtin_nanf = @import("std").zig.c_builtins.__builtin_nanf;
pub const __builtin_huge_valf = @import("std").zig.c_builtins.__builtin_huge_valf;
pub const __builtin_inff = @import("std").zig.c_builtins.__builtin_inff;
pub const __builtin_isnan = @import("std").zig.c_builtins.__builtin_isnan;
pub const __builtin_isinf = @import("std").zig.c_builtins.__builtin_isinf;
pub const __builtin_isinf_sign = @import("std").zig.c_builtins.__builtin_isinf_sign;
pub const __has_builtin = @import("std").zig.c_builtins.__has_builtin;
pub const __builtin_assume = @import("std").zig.c_builtins.__builtin_assume;
pub const __builtin_unreachable = @import("std").zig.c_builtins.__builtin_unreachable;
pub const __builtin_constant_p = @import("std").zig.c_builtins.__builtin_constant_p;
pub const __builtin_mul_overflow = @import("std").zig.c_builtins.__builtin_mul_overflow;
pub const __u_char = u8;
pub const __u_short = c_ushort;
pub const __u_int = c_uint;
pub const __u_long = c_ulong;
pub const __int8_t = i8;
pub const __uint8_t = u8;
pub const __int16_t = c_short;
pub const __uint16_t = c_ushort;
pub const __int32_t = c_int;
pub const __uint32_t = c_uint;
pub const __int64_t = c_long;
pub const __uint64_t = c_ulong;
pub const __int_least8_t = __int8_t;
pub const __uint_least8_t = __uint8_t;
pub const __int_least16_t = __int16_t;
pub const __uint_least16_t = __uint16_t;
pub const __int_least32_t = __int32_t;
pub const __uint_least32_t = __uint32_t;
pub const __int_least64_t = __int64_t;
pub const __uint_least64_t = __uint64_t;
pub const __quad_t = c_long;
pub const __u_quad_t = c_ulong;
pub const __intmax_t = c_long;
pub const __uintmax_t = c_ulong;
pub const __dev_t = c_ulong;
pub const __uid_t = c_uint;
pub const __gid_t = c_uint;
pub const __ino_t = c_ulong;
pub const __ino64_t = c_ulong;
pub const __mode_t = c_uint;
pub const __nlink_t = c_ulong;
pub const __off_t = c_long;
pub const __off64_t = c_long;
pub const __pid_t = c_int;
pub const __fsid_t = extern struct {
    __val: [2]c_int = @import("std").mem.zeroes([2]c_int),
};
pub const __clock_t = c_long;
pub const __rlim_t = c_ulong;
pub const __rlim64_t = c_ulong;
pub const __id_t = c_uint;
pub const __time_t = c_long;
pub const __useconds_t = c_uint;
pub const __suseconds_t = c_long;
pub const __suseconds64_t = c_long;
pub const __daddr_t = c_int;
pub const __key_t = c_int;
pub const __clockid_t = c_int;
pub const __timer_t = ?*anyopaque;
pub const __blksize_t = c_long;
pub const __blkcnt_t = c_long;
pub const __blkcnt64_t = c_long;
pub const __fsblkcnt_t = c_ulong;
pub const __fsblkcnt64_t = c_ulong;
pub const __fsfilcnt_t = c_ulong;
pub const __fsfilcnt64_t = c_ulong;
pub const __fsword_t = c_long;
pub const __ssize_t = c_long;
pub const __syscall_slong_t = c_long;
pub const __syscall_ulong_t = c_ulong;
pub const __loff_t = __off64_t;
pub const __caddr_t = [*c]u8;
pub const __intptr_t = c_long;
pub const __socklen_t = c_uint;
pub const __sig_atomic_t = c_int;
pub const int_least8_t = __int_least8_t;
pub const int_least16_t = __int_least16_t;
pub const int_least32_t = __int_least32_t;
pub const int_least64_t = __int_least64_t;
pub const uint_least8_t = __uint_least8_t;
pub const uint_least16_t = __uint_least16_t;
pub const uint_least32_t = __uint_least32_t;
pub const uint_least64_t = __uint_least64_t;
pub const int_fast8_t = i8;
pub const int_fast16_t = c_long;
pub const int_fast32_t = c_long;
pub const int_fast64_t = c_long;
pub const uint_fast8_t = u8;
pub const uint_fast16_t = c_ulong;
pub const uint_fast32_t = c_ulong;
pub const uint_fast64_t = c_ulong;
pub const intmax_t = __intmax_t;
pub const uintmax_t = __uintmax_t;
pub const __gwchar_t = c_int;
pub const imaxdiv_t = extern struct {
    quot: c_long = @import("std").mem.zeroes(c_long),
    rem: c_long = @import("std").mem.zeroes(c_long),
};
pub extern fn imaxabs(__n: intmax_t) intmax_t;
pub extern fn imaxdiv(__numer: intmax_t, __denom: intmax_t) imaxdiv_t;
pub extern fn strtoimax(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) intmax_t;
pub extern fn strtoumax(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) uintmax_t;
pub extern fn wcstoimax(noalias __nptr: [*c]const __gwchar_t, noalias __endptr: [*c][*c]__gwchar_t, __base: c_int) intmax_t;
pub extern fn wcstoumax(noalias __nptr: [*c]const __gwchar_t, noalias __endptr: [*c][*c]__gwchar_t, __base: c_int) uintmax_t;
pub const ossl_intmax_t = intmax_t;
pub const ossl_uintmax_t = uintmax_t;
pub const ptrdiff_t = c_long;
pub const wchar_t = c_int;
pub const max_align_t = extern struct {
    __clang_max_align_nonce1: c_longlong align(8) = @import("std").mem.zeroes(c_longlong),
    __clang_max_align_nonce2: c_longdouble align(16) = @import("std").mem.zeroes(c_longdouble),
};
pub const struct_SHAstate_st = extern struct {
    h0: c_uint = @import("std").mem.zeroes(c_uint),
    h1: c_uint = @import("std").mem.zeroes(c_uint),
    h2: c_uint = @import("std").mem.zeroes(c_uint),
    h3: c_uint = @import("std").mem.zeroes(c_uint),
    h4: c_uint = @import("std").mem.zeroes(c_uint),
    Nl: c_uint = @import("std").mem.zeroes(c_uint),
    Nh: c_uint = @import("std").mem.zeroes(c_uint),
    data: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
    num: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const SHA_CTX = struct_SHAstate_st;
pub extern fn SHA1_Init(c: [*c]SHA_CTX) c_int;
pub extern fn SHA1_Update(c: [*c]SHA_CTX, data: ?*const anyopaque, len: usize) c_int;
pub extern fn SHA1_Final(md: [*c]u8, c: [*c]SHA_CTX) c_int;
pub extern fn SHA1_Transform(c: [*c]SHA_CTX, data: [*c]const u8) void;
pub extern fn SHA1(d: [*c]const u8, n: usize, md: [*c]u8) [*c]u8;
pub const struct_SHA256state_st = extern struct {
    h: [8]c_uint = @import("std").mem.zeroes([8]c_uint),
    Nl: c_uint = @import("std").mem.zeroes(c_uint),
    Nh: c_uint = @import("std").mem.zeroes(c_uint),
    data: [16]c_uint = @import("std").mem.zeroes([16]c_uint),
    num: c_uint = @import("std").mem.zeroes(c_uint),
    md_len: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const SHA256_CTX = struct_SHA256state_st;
pub extern fn SHA224_Init(c: [*c]SHA256_CTX) c_int;
pub extern fn SHA224_Update(c: [*c]SHA256_CTX, data: ?*const anyopaque, len: usize) c_int;
pub extern fn SHA224_Final(md: [*c]u8, c: [*c]SHA256_CTX) c_int;
pub extern fn SHA256_Init(c: [*c]SHA256_CTX) c_int;
pub extern fn SHA256_Update(c: [*c]SHA256_CTX, data: ?*const anyopaque, len: usize) c_int;
pub extern fn SHA256_Final(md: [*c]u8, c: [*c]SHA256_CTX) c_int;
pub extern fn SHA256_Transform(c: [*c]SHA256_CTX, data: [*c]const u8) void;
pub extern fn SHA224(d: [*c]const u8, n: usize, md: [*c]u8) [*c]u8;
pub extern fn SHA256(d: [*c]const u8, n: usize, md: [*c]u8) [*c]u8;
const union_unnamed_1 = extern union {
    d: [16]c_ulonglong,
    p: [128]u8,
};
pub const struct_SHA512state_st = extern struct {
    h: [8]c_ulonglong = @import("std").mem.zeroes([8]c_ulonglong),
    Nl: c_ulonglong = @import("std").mem.zeroes(c_ulonglong),
    Nh: c_ulonglong = @import("std").mem.zeroes(c_ulonglong),
    u: union_unnamed_1 = @import("std").mem.zeroes(union_unnamed_1),
    num: c_uint = @import("std").mem.zeroes(c_uint),
    md_len: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const SHA512_CTX = struct_SHA512state_st;
pub extern fn SHA384_Init(c: [*c]SHA512_CTX) c_int;
pub extern fn SHA384_Update(c: [*c]SHA512_CTX, data: ?*const anyopaque, len: usize) c_int;
pub extern fn SHA384_Final(md: [*c]u8, c: [*c]SHA512_CTX) c_int;
pub extern fn SHA512_Init(c: [*c]SHA512_CTX) c_int;
pub extern fn SHA512_Update(c: [*c]SHA512_CTX, data: ?*const anyopaque, len: usize) c_int;
pub extern fn SHA512_Final(md: [*c]u8, c: [*c]SHA512_CTX) c_int;
pub extern fn SHA512_Transform(c: [*c]SHA512_CTX, data: [*c]const u8) void;
pub extern fn SHA384(d: [*c]const u8, n: usize, md: [*c]u8) [*c]u8;
pub extern fn SHA512(d: [*c]const u8, n: usize, md: [*c]u8) [*c]u8;
pub const struct___va_list_tag_2 = extern struct {
    gp_offset: c_uint = @import("std").mem.zeroes(c_uint),
    fp_offset: c_uint = @import("std").mem.zeroes(c_uint),
    overflow_arg_area: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    reg_save_area: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const __builtin_va_list = [1]struct___va_list_tag_2;
pub const __gnuc_va_list = __builtin_va_list;
pub const va_list = __builtin_va_list;
const union_unnamed_3 = extern union {
    __wch: c_uint,
    __wchb: [4]u8,
};
pub const __mbstate_t = extern struct {
    __count: c_int = @import("std").mem.zeroes(c_int),
    __value: union_unnamed_3 = @import("std").mem.zeroes(union_unnamed_3),
};
pub const struct__G_fpos_t = extern struct {
    __pos: __off_t = @import("std").mem.zeroes(__off_t),
    __state: __mbstate_t = @import("std").mem.zeroes(__mbstate_t),
};
pub const __fpos_t = struct__G_fpos_t;
pub const struct__G_fpos64_t = extern struct {
    __pos: __off64_t = @import("std").mem.zeroes(__off64_t),
    __state: __mbstate_t = @import("std").mem.zeroes(__mbstate_t),
};
pub const __fpos64_t = struct__G_fpos64_t;
pub const struct__IO_marker = opaque {};
pub const _IO_lock_t = anyopaque;
pub const struct__IO_codecvt = opaque {};
pub const struct__IO_wide_data = opaque {};
pub const struct__IO_FILE = extern struct {
    _flags: c_int = @import("std").mem.zeroes(c_int),
    _IO_read_ptr: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_read_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_read_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_write_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_write_ptr: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_write_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_buf_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_buf_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_save_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_backup_base: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _IO_save_end: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    _markers: ?*struct__IO_marker = @import("std").mem.zeroes(?*struct__IO_marker),
    _chain: [*c]struct__IO_FILE = @import("std").mem.zeroes([*c]struct__IO_FILE),
    _fileno: c_int = @import("std").mem.zeroes(c_int),
    _flags2: c_int = @import("std").mem.zeroes(c_int),
    _old_offset: __off_t = @import("std").mem.zeroes(__off_t),
    _cur_column: c_ushort = @import("std").mem.zeroes(c_ushort),
    _vtable_offset: i8 = @import("std").mem.zeroes(i8),
    _shortbuf: [1]u8 = @import("std").mem.zeroes([1]u8),
    _lock: ?*_IO_lock_t = @import("std").mem.zeroes(?*_IO_lock_t),
    _offset: __off64_t = @import("std").mem.zeroes(__off64_t),
    _codecvt: ?*struct__IO_codecvt = @import("std").mem.zeroes(?*struct__IO_codecvt),
    _wide_data: ?*struct__IO_wide_data = @import("std").mem.zeroes(?*struct__IO_wide_data),
    _freeres_list: [*c]struct__IO_FILE = @import("std").mem.zeroes([*c]struct__IO_FILE),
    _freeres_buf: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    __pad5: usize = @import("std").mem.zeroes(usize),
    _mode: c_int = @import("std").mem.zeroes(c_int),
    _unused2: [20]u8 = @import("std").mem.zeroes([20]u8),
};
pub const __FILE = struct__IO_FILE;
pub const FILE = struct__IO_FILE;
pub const cookie_read_function_t = fn (?*anyopaque, [*c]u8, usize) callconv(.c) __ssize_t;
pub const cookie_write_function_t = fn (?*anyopaque, [*c]const u8, usize) callconv(.c) __ssize_t;
pub const cookie_seek_function_t = fn (?*anyopaque, [*c]__off64_t, c_int) callconv(.c) c_int;
pub const cookie_close_function_t = fn (?*anyopaque) callconv(.c) c_int;
pub const struct__IO_cookie_io_functions_t = extern struct {
    read: ?*const cookie_read_function_t = @import("std").mem.zeroes(?*const cookie_read_function_t),
    write: ?*const cookie_write_function_t = @import("std").mem.zeroes(?*const cookie_write_function_t),
    seek: ?*const cookie_seek_function_t = @import("std").mem.zeroes(?*const cookie_seek_function_t),
    close: ?*const cookie_close_function_t = @import("std").mem.zeroes(?*const cookie_close_function_t),
};
pub const cookie_io_functions_t = struct__IO_cookie_io_functions_t;
pub const off_t = __off_t;
pub const fpos_t = __fpos_t;
pub extern var stdin: [*c]FILE;
pub extern var stdout: [*c]FILE;
pub extern var stderr: [*c]FILE;
pub extern fn remove(__filename: [*c]const u8) c_int;
pub extern fn rename(__old: [*c]const u8, __new: [*c]const u8) c_int;
pub extern fn renameat(__oldfd: c_int, __old: [*c]const u8, __newfd: c_int, __new: [*c]const u8) c_int;
pub extern fn fclose(__stream: [*c]FILE) c_int;
pub extern fn tmpfile() [*c]FILE;
pub extern fn tmpnam([*c]u8) [*c]u8;
pub extern fn tmpnam_r(__s: [*c]u8) [*c]u8;
pub extern fn tempnam(__dir: [*c]const u8, __pfx: [*c]const u8) [*c]u8;
pub extern fn fflush(__stream: [*c]FILE) c_int;
pub extern fn fflush_unlocked(__stream: [*c]FILE) c_int;
pub extern fn fopen(__filename: [*c]const u8, __modes: [*c]const u8) [*c]FILE;
pub extern fn freopen(noalias __filename: [*c]const u8, noalias __modes: [*c]const u8, noalias __stream: [*c]FILE) [*c]FILE;
pub extern fn fdopen(__fd: c_int, __modes: [*c]const u8) [*c]FILE;
pub extern fn fopencookie(noalias __magic_cookie: ?*anyopaque, noalias __modes: [*c]const u8, __io_funcs: cookie_io_functions_t) [*c]FILE;
pub extern fn fmemopen(__s: ?*anyopaque, __len: usize, __modes: [*c]const u8) [*c]FILE;
pub extern fn open_memstream(__bufloc: [*c][*c]u8, __sizeloc: [*c]usize) [*c]FILE;
pub extern fn setbuf(noalias __stream: [*c]FILE, noalias __buf: [*c]u8) void;
pub extern fn setvbuf(noalias __stream: [*c]FILE, noalias __buf: [*c]u8, __modes: c_int, __n: usize) c_int;
pub extern fn setbuffer(noalias __stream: [*c]FILE, noalias __buf: [*c]u8, __size: usize) void;
pub extern fn setlinebuf(__stream: [*c]FILE) void;
pub extern fn fprintf(noalias __stream: [*c]FILE, noalias __format: [*c]const u8, ...) c_int;
pub extern fn printf(__format: [*c]const u8, ...) c_int;
pub extern fn sprintf(noalias __s: [*c]u8, noalias __format: [*c]const u8, ...) c_int;
pub extern fn vfprintf(noalias __s: [*c]FILE, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn vprintf(noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn vsprintf(noalias __s: [*c]u8, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn snprintf(noalias __s: [*c]u8, __maxlen: c_ulong, noalias __format: [*c]const u8, ...) c_int;
pub extern fn vsnprintf(noalias __s: [*c]u8, __maxlen: c_ulong, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn vasprintf(noalias __ptr: [*c][*c]u8, noalias __f: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn __asprintf(noalias __ptr: [*c][*c]u8, noalias __fmt: [*c]const u8, ...) c_int;
pub extern fn asprintf(noalias __ptr: [*c][*c]u8, noalias __fmt: [*c]const u8, ...) c_int;
pub extern fn vdprintf(__fd: c_int, noalias __fmt: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn dprintf(__fd: c_int, noalias __fmt: [*c]const u8, ...) c_int;
pub extern fn fscanf(noalias __stream: [*c]FILE, noalias __format: [*c]const u8, ...) c_int;
pub extern fn scanf(noalias __format: [*c]const u8, ...) c_int;
pub extern fn sscanf(noalias __s: [*c]const u8, noalias __format: [*c]const u8, ...) c_int;
pub const _Float32 = f32;
pub const _Float64 = f64;
pub const _Float32x = f64;
pub const _Float64x = c_longdouble;
pub extern fn vfscanf(noalias __s: [*c]FILE, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn vscanf(noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn vsscanf(noalias __s: [*c]const u8, noalias __format: [*c]const u8, __arg: [*c]struct___va_list_tag_2) c_int;
pub extern fn fgetc(__stream: [*c]FILE) c_int;
pub extern fn getc(__stream: [*c]FILE) c_int;
pub extern fn getchar() c_int;
pub extern fn getc_unlocked(__stream: [*c]FILE) c_int;
pub extern fn getchar_unlocked() c_int;
pub extern fn fgetc_unlocked(__stream: [*c]FILE) c_int;
pub extern fn fputc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putchar(__c: c_int) c_int;
pub extern fn fputc_unlocked(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putc_unlocked(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn putchar_unlocked(__c: c_int) c_int;
pub extern fn getw(__stream: [*c]FILE) c_int;
pub extern fn putw(__w: c_int, __stream: [*c]FILE) c_int;
pub extern fn fgets(noalias __s: [*c]u8, __n: c_int, noalias __stream: [*c]FILE) [*c]u8;
pub extern fn __getdelim(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, __delimiter: c_int, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn getdelim(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, __delimiter: c_int, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn getline(noalias __lineptr: [*c][*c]u8, noalias __n: [*c]usize, noalias __stream: [*c]FILE) __ssize_t;
pub extern fn fputs(noalias __s: [*c]const u8, noalias __stream: [*c]FILE) c_int;
pub extern fn puts(__s: [*c]const u8) c_int;
pub extern fn ungetc(__c: c_int, __stream: [*c]FILE) c_int;
pub extern fn fread(__ptr: ?*anyopaque, __size: c_ulong, __n: c_ulong, __stream: [*c]FILE) c_ulong;
pub extern fn fwrite(__ptr: ?*const anyopaque, __size: c_ulong, __n: c_ulong, __s: [*c]FILE) c_ulong;
pub extern fn fread_unlocked(noalias __ptr: ?*anyopaque, __size: usize, __n: usize, noalias __stream: [*c]FILE) usize;
pub extern fn fwrite_unlocked(noalias __ptr: ?*const anyopaque, __size: usize, __n: usize, noalias __stream: [*c]FILE) usize;
pub extern fn fseek(__stream: [*c]FILE, __off: c_long, __whence: c_int) c_int;
pub extern fn ftell(__stream: [*c]FILE) c_long;
pub extern fn rewind(__stream: [*c]FILE) void;
pub extern fn fseeko(__stream: [*c]FILE, __off: __off_t, __whence: c_int) c_int;
pub extern fn ftello(__stream: [*c]FILE) __off_t;
pub extern fn fgetpos(noalias __stream: [*c]FILE, noalias __pos: [*c]fpos_t) c_int;
pub extern fn fsetpos(__stream: [*c]FILE, __pos: [*c]const fpos_t) c_int;
pub extern fn clearerr(__stream: [*c]FILE) void;
pub extern fn feof(__stream: [*c]FILE) c_int;
pub extern fn ferror(__stream: [*c]FILE) c_int;
pub extern fn clearerr_unlocked(__stream: [*c]FILE) void;
pub extern fn feof_unlocked(__stream: [*c]FILE) c_int;
pub extern fn ferror_unlocked(__stream: [*c]FILE) c_int;
pub extern fn perror(__s: [*c]const u8) void;
pub extern fn fileno(__stream: [*c]FILE) c_int;
pub extern fn fileno_unlocked(__stream: [*c]FILE) c_int;
pub extern fn pclose(__stream: [*c]FILE) c_int;
pub extern fn popen(__command: [*c]const u8, __modes: [*c]const u8) [*c]FILE;
pub extern fn ctermid(__s: [*c]u8) [*c]u8;
pub extern fn flockfile(__stream: [*c]FILE) void;
pub extern fn ftrylockfile(__stream: [*c]FILE) c_int;
pub extern fn funlockfile(__stream: [*c]FILE) void;
pub extern fn __uflow([*c]FILE) c_int;
pub extern fn __overflow([*c]FILE, c_int) c_int;
pub const struct_stack_st = opaque {};
pub const OPENSSL_STACK = struct_stack_st;
pub const OPENSSL_sk_compfunc = ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int;
pub const OPENSSL_sk_freefunc = ?*const fn (?*anyopaque) callconv(.c) void;
pub const OPENSSL_sk_copyfunc = ?*const fn (?*const anyopaque) callconv(.c) ?*anyopaque;
pub extern fn OPENSSL_sk_num(?*const OPENSSL_STACK) c_int;
pub extern fn OPENSSL_sk_value(?*const OPENSSL_STACK, c_int) ?*anyopaque;
pub extern fn OPENSSL_sk_set(st: ?*OPENSSL_STACK, i: c_int, data: ?*const anyopaque) ?*anyopaque;
pub extern fn OPENSSL_sk_new(cmp: OPENSSL_sk_compfunc) ?*OPENSSL_STACK;
pub extern fn OPENSSL_sk_new_null() ?*OPENSSL_STACK;
pub extern fn OPENSSL_sk_new_reserve(c: OPENSSL_sk_compfunc, n: c_int) ?*OPENSSL_STACK;
pub extern fn OPENSSL_sk_reserve(st: ?*OPENSSL_STACK, n: c_int) c_int;
pub extern fn OPENSSL_sk_free(?*OPENSSL_STACK) void;
pub extern fn OPENSSL_sk_pop_free(st: ?*OPENSSL_STACK, func: ?*const fn (?*anyopaque) callconv(.c) void) void;
pub extern fn OPENSSL_sk_deep_copy(?*const OPENSSL_STACK, c: OPENSSL_sk_copyfunc, f: OPENSSL_sk_freefunc) ?*OPENSSL_STACK;
pub extern fn OPENSSL_sk_insert(sk: ?*OPENSSL_STACK, data: ?*const anyopaque, where: c_int) c_int;
pub extern fn OPENSSL_sk_delete(st: ?*OPENSSL_STACK, loc: c_int) ?*anyopaque;
pub extern fn OPENSSL_sk_delete_ptr(st: ?*OPENSSL_STACK, p: ?*const anyopaque) ?*anyopaque;
pub extern fn OPENSSL_sk_find(st: ?*OPENSSL_STACK, data: ?*const anyopaque) c_int;
pub extern fn OPENSSL_sk_find_ex(st: ?*OPENSSL_STACK, data: ?*const anyopaque) c_int;
pub extern fn OPENSSL_sk_find_all(st: ?*OPENSSL_STACK, data: ?*const anyopaque, pnum: [*c]c_int) c_int;
pub extern fn OPENSSL_sk_push(st: ?*OPENSSL_STACK, data: ?*const anyopaque) c_int;
pub extern fn OPENSSL_sk_unshift(st: ?*OPENSSL_STACK, data: ?*const anyopaque) c_int;
pub extern fn OPENSSL_sk_shift(st: ?*OPENSSL_STACK) ?*anyopaque;
pub extern fn OPENSSL_sk_pop(st: ?*OPENSSL_STACK) ?*anyopaque;
pub extern fn OPENSSL_sk_zero(st: ?*OPENSSL_STACK) void;
pub extern fn OPENSSL_sk_set_cmp_func(sk: ?*OPENSSL_STACK, cmp: OPENSSL_sk_compfunc) OPENSSL_sk_compfunc;
pub extern fn OPENSSL_sk_dup(st: ?*const OPENSSL_STACK) ?*OPENSSL_STACK;
pub extern fn OPENSSL_sk_sort(st: ?*OPENSSL_STACK) void;
pub extern fn OPENSSL_sk_is_sorted(st: ?*const OPENSSL_STACK) c_int;
pub const OPENSSL_STRING = [*c]u8;
pub const OPENSSL_CSTRING = [*c]const u8;
pub const struct_stack_st_OPENSSL_STRING = opaque {};
pub const sk_OPENSSL_STRING_compfunc = ?*const fn ([*c]const [*c]const u8, [*c]const [*c]const u8) callconv(.c) c_int;
pub const sk_OPENSSL_STRING_freefunc = ?*const fn ([*c]u8) callconv(.c) void;
pub const sk_OPENSSL_STRING_copyfunc = ?*const fn ([*c]const u8) callconv(.c) [*c]u8;
pub fn ossl_check_OPENSSL_STRING_type(arg_ptr: [*c]u8) callconv(.c) [*c]u8 {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_OPENSSL_STRING_sk_type(arg_sk: ?*const struct_stack_st_OPENSSL_STRING) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_OPENSSL_STRING_sk_type(arg_sk: ?*struct_stack_st_OPENSSL_STRING) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_OPENSSL_STRING_compfunc_type(arg_cmp: sk_OPENSSL_STRING_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_OPENSSL_STRING_copyfunc_type(arg_cpy: sk_OPENSSL_STRING_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_OPENSSL_STRING_freefunc_type(arg_fr: sk_OPENSSL_STRING_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const struct_stack_st_OPENSSL_CSTRING = opaque {};
pub const sk_OPENSSL_CSTRING_compfunc = ?*const fn ([*c]const [*c]const u8, [*c]const [*c]const u8) callconv(.c) c_int;
pub const sk_OPENSSL_CSTRING_freefunc = ?*const fn ([*c]u8) callconv(.c) void;
pub const sk_OPENSSL_CSTRING_copyfunc = ?*const fn ([*c]const u8) callconv(.c) [*c]u8;
pub fn ossl_check_OPENSSL_CSTRING_type(arg_ptr: [*c]const u8) callconv(.c) [*c]const u8 {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_OPENSSL_CSTRING_sk_type(arg_sk: ?*const struct_stack_st_OPENSSL_CSTRING) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_OPENSSL_CSTRING_sk_type(arg_sk: ?*struct_stack_st_OPENSSL_CSTRING) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_OPENSSL_CSTRING_compfunc_type(arg_cmp: sk_OPENSSL_CSTRING_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_OPENSSL_CSTRING_copyfunc_type(arg_cpy: sk_OPENSSL_CSTRING_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_OPENSSL_CSTRING_freefunc_type(arg_fr: sk_OPENSSL_CSTRING_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const OPENSSL_BLOCK = ?*anyopaque;
pub const struct_stack_st_OPENSSL_BLOCK = opaque {};
pub const sk_OPENSSL_BLOCK_compfunc = ?*const fn ([*c]const ?*const anyopaque, [*c]const ?*const anyopaque) callconv(.c) c_int;
pub const sk_OPENSSL_BLOCK_freefunc = ?*const fn (?*anyopaque) callconv(.c) void;
pub const sk_OPENSSL_BLOCK_copyfunc = ?*const fn (?*const anyopaque) callconv(.c) ?*anyopaque;
pub fn ossl_check_OPENSSL_BLOCK_type(arg_ptr: ?*anyopaque) callconv(.c) ?*anyopaque {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_OPENSSL_BLOCK_sk_type(arg_sk: ?*const struct_stack_st_OPENSSL_BLOCK) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_OPENSSL_BLOCK_sk_type(arg_sk: ?*struct_stack_st_OPENSSL_BLOCK) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_OPENSSL_BLOCK_compfunc_type(arg_cmp: sk_OPENSSL_BLOCK_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_OPENSSL_BLOCK_copyfunc_type(arg_cpy: sk_OPENSSL_BLOCK_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_OPENSSL_BLOCK_freefunc_type(arg_fr: sk_OPENSSL_BLOCK_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const struct_ossl_provider_st = opaque {};
pub const OSSL_PROVIDER = struct_ossl_provider_st;
pub const struct_asn1_string_st = extern struct {
    length: c_int = @import("std").mem.zeroes(c_int),
    type: c_int = @import("std").mem.zeroes(c_int),
    data: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    flags: c_long = @import("std").mem.zeroes(c_long),
};
pub const ASN1_INTEGER = struct_asn1_string_st;
pub const ASN1_ENUMERATED = struct_asn1_string_st;
pub const ASN1_BIT_STRING = struct_asn1_string_st;
pub const ASN1_OCTET_STRING = struct_asn1_string_st;
pub const ASN1_PRINTABLESTRING = struct_asn1_string_st;
pub const ASN1_T61STRING = struct_asn1_string_st;
pub const ASN1_IA5STRING = struct_asn1_string_st;
pub const ASN1_GENERALSTRING = struct_asn1_string_st;
pub const ASN1_UNIVERSALSTRING = struct_asn1_string_st;
pub const ASN1_BMPSTRING = struct_asn1_string_st;
pub const ASN1_UTCTIME = struct_asn1_string_st;
pub const ASN1_TIME = struct_asn1_string_st;
pub const ASN1_GENERALIZEDTIME = struct_asn1_string_st;
pub const ASN1_VISIBLESTRING = struct_asn1_string_st;
pub const ASN1_UTF8STRING = struct_asn1_string_st;
pub const ASN1_STRING = struct_asn1_string_st;
pub const ASN1_BOOLEAN = c_int;
pub const ASN1_NULL = c_int;
pub const struct_asn1_object_st = opaque {};
pub const ASN1_OBJECT = struct_asn1_object_st;
pub const struct_ASN1_VALUE_st = opaque {};
pub const ASN1_VALUE = struct_ASN1_VALUE_st;
const union_unnamed_4 = extern union {
    ptr: [*c]u8,
    boolean: ASN1_BOOLEAN,
    asn1_string: [*c]ASN1_STRING,
    object: ?*ASN1_OBJECT,
    integer: [*c]ASN1_INTEGER,
    enumerated: [*c]ASN1_ENUMERATED,
    bit_string: [*c]ASN1_BIT_STRING,
    octet_string: [*c]ASN1_OCTET_STRING,
    printablestring: [*c]ASN1_PRINTABLESTRING,
    t61string: [*c]ASN1_T61STRING,
    ia5string: [*c]ASN1_IA5STRING,
    generalstring: [*c]ASN1_GENERALSTRING,
    bmpstring: [*c]ASN1_BMPSTRING,
    universalstring: [*c]ASN1_UNIVERSALSTRING,
    utctime: [*c]ASN1_UTCTIME,
    generalizedtime: [*c]ASN1_GENERALIZEDTIME,
    visiblestring: [*c]ASN1_VISIBLESTRING,
    utf8string: [*c]ASN1_UTF8STRING,
    set: [*c]ASN1_STRING,
    sequence: [*c]ASN1_STRING,
    asn1_value: ?*ASN1_VALUE,
};
pub const struct_asn1_type_st = extern struct {
    type: c_int = @import("std").mem.zeroes(c_int),
    value: union_unnamed_4 = @import("std").mem.zeroes(union_unnamed_4),
};
pub const ASN1_TYPE = struct_asn1_type_st;
pub const struct_asn1_string_table_st = extern struct {
    nid: c_int = @import("std").mem.zeroes(c_int),
    minsize: c_long = @import("std").mem.zeroes(c_long),
    maxsize: c_long = @import("std").mem.zeroes(c_long),
    mask: c_ulong = @import("std").mem.zeroes(c_ulong),
    flags: c_ulong = @import("std").mem.zeroes(c_ulong),
};
pub const ASN1_STRING_TABLE = struct_asn1_string_table_st;
pub const struct_ASN1_ITEM_st = opaque {};
pub const ASN1_ITEM = struct_ASN1_ITEM_st;
pub const struct_asn1_pctx_st = opaque {};
pub const ASN1_PCTX = struct_asn1_pctx_st;
pub const struct_asn1_sctx_st = opaque {};
pub const ASN1_SCTX = struct_asn1_sctx_st;
pub const struct_bio_st = opaque {};
pub const BIO = struct_bio_st;
pub const struct_bignum_st = opaque {};
pub const BIGNUM = struct_bignum_st;
pub const struct_bignum_ctx = opaque {};
pub const BN_CTX = struct_bignum_ctx;
pub const struct_bn_blinding_st = opaque {};
pub const BN_BLINDING = struct_bn_blinding_st;
pub const struct_bn_mont_ctx_st = opaque {};
pub const BN_MONT_CTX = struct_bn_mont_ctx_st;
pub const struct_bn_recp_ctx_st = opaque {};
pub const BN_RECP_CTX = struct_bn_recp_ctx_st;
pub const struct_bn_gencb_st = opaque {};
pub const BN_GENCB = struct_bn_gencb_st;
pub const struct_buf_mem_st = opaque {};
pub const BUF_MEM = struct_buf_mem_st;
pub const struct_stack_st_BIGNUM = opaque {};
pub const struct_stack_st_BIGNUM_const = opaque {};
pub const struct_err_state_st = opaque {};
pub const ERR_STATE = struct_err_state_st;
pub const struct_evp_cipher_st = opaque {};
pub const EVP_CIPHER = struct_evp_cipher_st;
pub const struct_evp_cipher_ctx_st = opaque {};
pub const EVP_CIPHER_CTX = struct_evp_cipher_ctx_st;
pub const struct_evp_md_st = opaque {};
pub const EVP_MD = struct_evp_md_st;
pub const struct_evp_md_ctx_st = opaque {};
pub const EVP_MD_CTX = struct_evp_md_ctx_st;
pub const struct_evp_mac_st = opaque {};
pub const EVP_MAC = struct_evp_mac_st;
pub const struct_evp_mac_ctx_st = opaque {};
pub const EVP_MAC_CTX = struct_evp_mac_ctx_st;
pub const struct_evp_pkey_st = opaque {};
pub const EVP_PKEY = struct_evp_pkey_st;
pub const struct_evp_pkey_asn1_method_st = opaque {};
pub const EVP_PKEY_ASN1_METHOD = struct_evp_pkey_asn1_method_st;
pub const struct_evp_pkey_method_st = opaque {};
pub const EVP_PKEY_METHOD = struct_evp_pkey_method_st;
pub const struct_evp_pkey_ctx_st = opaque {};
pub const EVP_PKEY_CTX = struct_evp_pkey_ctx_st;
pub const struct_evp_keymgmt_st = opaque {};
pub const EVP_KEYMGMT = struct_evp_keymgmt_st;
pub const struct_evp_kdf_st = opaque {};
pub const EVP_KDF = struct_evp_kdf_st;
pub const struct_evp_kdf_ctx_st = opaque {};
pub const EVP_KDF_CTX = struct_evp_kdf_ctx_st;
pub const struct_evp_rand_st = opaque {};
pub const EVP_RAND = struct_evp_rand_st;
pub const struct_evp_rand_ctx_st = opaque {};
pub const EVP_RAND_CTX = struct_evp_rand_ctx_st;
pub const struct_evp_keyexch_st = opaque {};
pub const EVP_KEYEXCH = struct_evp_keyexch_st;
pub const struct_evp_signature_st = opaque {};
pub const EVP_SIGNATURE = struct_evp_signature_st;
pub const struct_evp_asym_cipher_st = opaque {};
pub const EVP_ASYM_CIPHER = struct_evp_asym_cipher_st;
pub const struct_evp_kem_st = opaque {};
pub const EVP_KEM = struct_evp_kem_st;
pub const struct_evp_Encode_Ctx_st = opaque {};
pub const EVP_ENCODE_CTX = struct_evp_Encode_Ctx_st;
pub const struct_hmac_ctx_st = opaque {};
pub const HMAC_CTX = struct_hmac_ctx_st;
pub const struct_dh_st = opaque {};
pub const DH = struct_dh_st;
pub const struct_dh_method = opaque {};
pub const DH_METHOD = struct_dh_method;
pub const struct_dsa_st = opaque {};
pub const DSA = struct_dsa_st;
pub const struct_dsa_method = opaque {};
pub const DSA_METHOD = struct_dsa_method;
pub const struct_rsa_st = opaque {};
pub const RSA = struct_rsa_st;
pub const struct_rsa_meth_st = opaque {};
pub const RSA_METHOD = struct_rsa_meth_st;
pub const struct_rsa_pss_params_st = opaque {};
pub const RSA_PSS_PARAMS = struct_rsa_pss_params_st;
pub const struct_ec_key_st = opaque {};
pub const EC_KEY = struct_ec_key_st;
pub const struct_ec_key_method_st = opaque {};
pub const EC_KEY_METHOD = struct_ec_key_method_st;
pub const struct_rand_meth_st = opaque {};
pub const RAND_METHOD = struct_rand_meth_st;
pub const struct_rand_drbg_st = opaque {};
pub const RAND_DRBG = struct_rand_drbg_st;
pub const struct_ssl_dane_st = opaque {};
pub const SSL_DANE = struct_ssl_dane_st;
pub const struct_x509_st = opaque {};
pub const X509 = struct_x509_st;
pub const struct_X509_algor_st = opaque {};
pub const X509_ALGOR = struct_X509_algor_st;
pub const struct_X509_crl_st = opaque {};
pub const X509_CRL = struct_X509_crl_st;
pub const struct_x509_crl_method_st = opaque {};
pub const X509_CRL_METHOD = struct_x509_crl_method_st;
pub const struct_x509_revoked_st = opaque {};
pub const X509_REVOKED = struct_x509_revoked_st;
pub const struct_X509_name_st = opaque {};
pub const X509_NAME = struct_X509_name_st;
pub const struct_X509_pubkey_st = opaque {};
pub const X509_PUBKEY = struct_X509_pubkey_st;
pub const struct_x509_store_st = opaque {};
pub const X509_STORE = struct_x509_store_st;
pub const struct_x509_store_ctx_st = opaque {};
pub const X509_STORE_CTX = struct_x509_store_ctx_st;
pub const struct_x509_object_st = opaque {};
pub const X509_OBJECT = struct_x509_object_st;
pub const struct_x509_lookup_st = opaque {};
pub const X509_LOOKUP = struct_x509_lookup_st;
pub const struct_x509_lookup_method_st = opaque {};
pub const X509_LOOKUP_METHOD = struct_x509_lookup_method_st;
pub const struct_X509_VERIFY_PARAM_st = opaque {};
pub const X509_VERIFY_PARAM = struct_X509_VERIFY_PARAM_st;
pub const struct_x509_sig_info_st = opaque {};
pub const X509_SIG_INFO = struct_x509_sig_info_st;
pub const struct_pkcs8_priv_key_info_st = opaque {};
pub const PKCS8_PRIV_KEY_INFO = struct_pkcs8_priv_key_info_st;
pub const struct_v3_ext_ctx = opaque {};
pub const X509V3_CTX = struct_v3_ext_ctx;
pub const struct_conf_st = opaque {};
pub const CONF = struct_conf_st;
pub const struct_ossl_init_settings_st = opaque {};
pub const OPENSSL_INIT_SETTINGS = struct_ossl_init_settings_st;
pub const struct_ui_st = opaque {};
pub const UI = struct_ui_st;
pub const struct_ui_method_st = opaque {};
pub const UI_METHOD = struct_ui_method_st;
pub const struct_engine_st = opaque {};
pub const ENGINE = struct_engine_st;
pub const struct_ssl_st = opaque {};
pub const SSL = struct_ssl_st;
pub const struct_ssl_ctx_st = opaque {};
pub const SSL_CTX = struct_ssl_ctx_st;
pub const struct_comp_ctx_st = opaque {};
pub const COMP_CTX = struct_comp_ctx_st;
pub const struct_comp_method_st = opaque {};
pub const COMP_METHOD = struct_comp_method_st;
pub const struct_X509_POLICY_NODE_st = opaque {};
pub const X509_POLICY_NODE = struct_X509_POLICY_NODE_st;
pub const struct_X509_POLICY_LEVEL_st = opaque {};
pub const X509_POLICY_LEVEL = struct_X509_POLICY_LEVEL_st;
pub const struct_X509_POLICY_TREE_st = opaque {};
pub const X509_POLICY_TREE = struct_X509_POLICY_TREE_st;
pub const struct_X509_POLICY_CACHE_st = opaque {};
pub const X509_POLICY_CACHE = struct_X509_POLICY_CACHE_st;
pub const struct_AUTHORITY_KEYID_st = opaque {};
pub const AUTHORITY_KEYID = struct_AUTHORITY_KEYID_st;
pub const struct_DIST_POINT_st = opaque {};
pub const DIST_POINT = struct_DIST_POINT_st;
pub const struct_ISSUING_DIST_POINT_st = opaque {};
pub const ISSUING_DIST_POINT = struct_ISSUING_DIST_POINT_st;
pub const struct_NAME_CONSTRAINTS_st = opaque {};
pub const NAME_CONSTRAINTS = struct_NAME_CONSTRAINTS_st;
pub const struct_ossl_lib_ctx_st = opaque {};
pub const OSSL_LIB_CTX = struct_ossl_lib_ctx_st;
pub const struct_stack_st_void = opaque {};
pub const struct_crypto_ex_data_st = extern struct {
    ctx: ?*OSSL_LIB_CTX = @import("std").mem.zeroes(?*OSSL_LIB_CTX),
    sk: ?*struct_stack_st_void = @import("std").mem.zeroes(?*struct_stack_st_void),
};
pub const CRYPTO_EX_DATA = struct_crypto_ex_data_st;
pub const struct_ossl_http_req_ctx_st = opaque {};
pub const OSSL_HTTP_REQ_CTX = struct_ossl_http_req_ctx_st;
pub const struct_ocsp_response_st = opaque {};
pub const OCSP_RESPONSE = struct_ocsp_response_st;
pub const struct_ocsp_responder_id_st = opaque {};
pub const OCSP_RESPID = struct_ocsp_responder_id_st;
pub const struct_sct_st = opaque {};
pub const SCT = struct_sct_st;
pub const struct_sct_ctx_st = opaque {};
pub const SCT_CTX = struct_sct_ctx_st;
pub const struct_ctlog_st = opaque {};
pub const CTLOG = struct_ctlog_st;
pub const struct_ctlog_store_st = opaque {};
pub const CTLOG_STORE = struct_ctlog_store_st;
pub const struct_ct_policy_eval_ctx_st = opaque {};
pub const CT_POLICY_EVAL_CTX = struct_ct_policy_eval_ctx_st;
pub const struct_ossl_store_info_st = opaque {};
pub const OSSL_STORE_INFO = struct_ossl_store_info_st;
pub const struct_ossl_store_search_st = opaque {};
pub const OSSL_STORE_SEARCH = struct_ossl_store_search_st;
pub const struct_ossl_dispatch_st = extern struct {
    function_id: c_int = @import("std").mem.zeroes(c_int),
    function: ?*const fn () callconv(.c) void = @import("std").mem.zeroes(?*const fn () callconv(.c) void),
};
pub const OSSL_DISPATCH = struct_ossl_dispatch_st;
pub const struct_ossl_item_st = extern struct {
    id: c_uint = @import("std").mem.zeroes(c_uint),
    ptr: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
};
pub const OSSL_ITEM = struct_ossl_item_st;
pub const struct_ossl_algorithm_st = extern struct {
    algorithm_names: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    property_definition: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    implementation: [*c]const OSSL_DISPATCH = @import("std").mem.zeroes([*c]const OSSL_DISPATCH),
    algorithm_description: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const OSSL_ALGORITHM = struct_ossl_algorithm_st;
pub const struct_ossl_param_st = extern struct {
    key: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    data_type: c_uint = @import("std").mem.zeroes(c_uint),
    data: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    data_size: usize = @import("std").mem.zeroes(usize),
    return_size: usize = @import("std").mem.zeroes(usize),
};
pub const OSSL_PARAM = struct_ossl_param_st;
pub const struct_ossl_param_bld_st = opaque {};
pub const OSSL_PARAM_BLD = struct_ossl_param_bld_st;
pub const pem_password_cb = fn ([*c]u8, c_int, c_int, ?*anyopaque) callconv(.c) c_int;
pub const struct_ossl_encoder_st = opaque {};
pub const OSSL_ENCODER = struct_ossl_encoder_st;
pub const struct_ossl_encoder_ctx_st = opaque {};
pub const OSSL_ENCODER_CTX = struct_ossl_encoder_ctx_st;
pub const struct_ossl_decoder_st = opaque {};
pub const OSSL_DECODER = struct_ossl_decoder_st;
pub const struct_ossl_decoder_ctx_st = opaque {};
pub const OSSL_DECODER_CTX = struct_ossl_decoder_ctx_st;
pub const struct_ossl_self_test_st = opaque {};
pub const OSSL_SELF_TEST = struct_ossl_self_test_st;
pub const struct_ossl_core_handle_st = opaque {};
pub const OSSL_CORE_HANDLE = struct_ossl_core_handle_st;
pub const struct_openssl_core_ctx_st = opaque {};
pub const OPENSSL_CORE_CTX = struct_openssl_core_ctx_st;
pub const struct_ossl_core_bio_st = opaque {};
pub const OSSL_CORE_BIO = struct_ossl_core_bio_st;
pub const OSSL_thread_stop_handler_fn = ?*const fn (?*anyopaque) callconv(.c) void;
pub const OSSL_provider_init_fn = fn (?*const OSSL_CORE_HANDLE, [*c]const OSSL_DISPATCH, [*c][*c]const OSSL_DISPATCH, [*c]?*anyopaque) callconv(.c) c_int;
pub const OSSL_provider_init = @compileError("unable to resolve function type .Elaborated");
// /usr/include/openssl/core.h:198:38
pub const OSSL_CALLBACK = fn ([*c]const OSSL_PARAM, ?*anyopaque) callconv(.c) c_int;
pub const OSSL_INOUT_CALLBACK = fn ([*c]const OSSL_PARAM, [*c]OSSL_PARAM, ?*anyopaque) callconv(.c) c_int;
pub const OSSL_PASSPHRASE_CALLBACK = fn ([*c]u8, usize, [*c]usize, [*c]const OSSL_PARAM, ?*anyopaque) callconv(.c) c_int;
pub const OSSL_FUNC_core_gettable_params_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_core_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_get_params_fn = fn (?*const OSSL_CORE_HANDLE, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_core_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_thread_start_fn = fn (?*const OSSL_CORE_HANDLE, OSSL_thread_stop_handler_fn, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_core_thread_start(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_thread_start_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_thread_start_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_get_libctx_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) ?*OPENSSL_CORE_CTX;
pub fn OSSL_FUNC_core_get_libctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_get_libctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_get_libctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_new_error_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) void;
pub fn OSSL_FUNC_core_new_error(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_new_error_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_new_error_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_set_error_debug_fn = fn (?*const OSSL_CORE_HANDLE, [*c]const u8, c_int, [*c]const u8) callconv(.c) void;
pub fn OSSL_FUNC_core_set_error_debug(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_set_error_debug_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_set_error_debug_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_vset_error_fn = fn (?*const OSSL_CORE_HANDLE, u32, [*c]const u8, [*c]struct___va_list_tag_2) callconv(.c) void;
pub fn OSSL_FUNC_core_vset_error(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_vset_error_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_vset_error_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_set_error_mark_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) c_int;
pub fn OSSL_FUNC_core_set_error_mark(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_set_error_mark_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_set_error_mark_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_clear_last_error_mark_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) c_int;
pub fn OSSL_FUNC_core_clear_last_error_mark(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_clear_last_error_mark_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_clear_last_error_mark_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_pop_error_to_mark_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) c_int;
pub fn OSSL_FUNC_core_pop_error_to_mark(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_pop_error_to_mark_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_pop_error_to_mark_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_obj_add_sigid_fn = fn (?*const OSSL_CORE_HANDLE, [*c]const u8, [*c]const u8, [*c]const u8) callconv(.c) c_int;
pub fn OSSL_FUNC_core_obj_add_sigid(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_obj_add_sigid_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_obj_add_sigid_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_core_obj_create_fn = fn (?*const OSSL_CORE_HANDLE, [*c]const u8, [*c]const u8, [*c]const u8) callconv(.c) c_int;
pub fn OSSL_FUNC_core_obj_create(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_core_obj_create_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_core_obj_create_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_malloc_fn = fn (usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_CRYPTO_malloc(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_malloc_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_malloc_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_zalloc_fn = fn (usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_CRYPTO_zalloc(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_zalloc_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_zalloc_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_free_fn = fn (?*anyopaque, [*c]const u8, c_int) callconv(.c) void;
pub fn OSSL_FUNC_CRYPTO_free(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_free_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_free_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_clear_free_fn = fn (?*anyopaque, usize, [*c]const u8, c_int) callconv(.c) void;
pub fn OSSL_FUNC_CRYPTO_clear_free(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_clear_free_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_clear_free_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_realloc_fn = fn (?*anyopaque, usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_CRYPTO_realloc(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_realloc_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_realloc_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_clear_realloc_fn = fn (?*anyopaque, usize, usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_CRYPTO_clear_realloc(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_clear_realloc_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_clear_realloc_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_secure_malloc_fn = fn (usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_CRYPTO_secure_malloc(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_secure_malloc_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_secure_malloc_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_secure_zalloc_fn = fn (usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_CRYPTO_secure_zalloc(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_secure_zalloc_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_secure_zalloc_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_secure_free_fn = fn (?*anyopaque, [*c]const u8, c_int) callconv(.c) void;
pub fn OSSL_FUNC_CRYPTO_secure_free(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_secure_free_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_secure_free_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_secure_clear_free_fn = fn (?*anyopaque, usize, [*c]const u8, c_int) callconv(.c) void;
pub fn OSSL_FUNC_CRYPTO_secure_clear_free(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_secure_clear_free_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_secure_clear_free_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_CRYPTO_secure_allocated_fn = fn (?*const anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_CRYPTO_secure_allocated(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_CRYPTO_secure_allocated_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_CRYPTO_secure_allocated_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_OPENSSL_cleanse_fn = fn (?*anyopaque, usize) callconv(.c) void;
pub fn OSSL_FUNC_OPENSSL_cleanse(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_OPENSSL_cleanse_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_OPENSSL_cleanse_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_new_file_fn = fn ([*c]const u8, [*c]const u8) callconv(.c) ?*OSSL_CORE_BIO;
pub fn OSSL_FUNC_BIO_new_file(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_new_file_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_new_file_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_new_membuf_fn = fn (?*const anyopaque, c_int) callconv(.c) ?*OSSL_CORE_BIO;
pub fn OSSL_FUNC_BIO_new_membuf(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_new_membuf_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_new_membuf_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_read_ex_fn = fn (?*OSSL_CORE_BIO, ?*anyopaque, usize, [*c]usize) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_read_ex(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_read_ex_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_read_ex_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_write_ex_fn = fn (?*OSSL_CORE_BIO, ?*const anyopaque, usize, [*c]usize) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_write_ex(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_write_ex_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_write_ex_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_gets_fn = fn (?*OSSL_CORE_BIO, [*c]u8, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_gets(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_gets_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_gets_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_puts_fn = fn (?*OSSL_CORE_BIO, [*c]const u8) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_puts(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_puts_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_puts_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_up_ref_fn = fn (?*OSSL_CORE_BIO) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_up_ref(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_up_ref_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_up_ref_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_free_fn = fn (?*OSSL_CORE_BIO) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_free(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_free_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_free_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_vprintf_fn = fn (?*OSSL_CORE_BIO, [*c]const u8, [*c]struct___va_list_tag_2) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_vprintf(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_vprintf_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_vprintf_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_vsnprintf_fn = fn ([*c]u8, usize, [*c]const u8, [*c]struct___va_list_tag_2) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_vsnprintf(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_vsnprintf_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_vsnprintf_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_BIO_ctrl_fn = fn (?*OSSL_CORE_BIO, c_int, c_long, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_BIO_ctrl(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_BIO_ctrl_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_BIO_ctrl_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_self_test_cb_fn = fn (?*OPENSSL_CORE_CTX, [*c]?*const OSSL_CALLBACK, [*c]?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_self_test_cb(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_self_test_cb_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_self_test_cb_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_get_entropy_fn = fn (?*const OSSL_CORE_HANDLE, [*c][*c]u8, c_int, usize, usize) callconv(.c) usize;
pub fn OSSL_FUNC_get_entropy(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_get_entropy_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_get_entropy_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cleanup_entropy_fn = fn (?*const OSSL_CORE_HANDLE, [*c]u8, usize) callconv(.c) void;
pub fn OSSL_FUNC_cleanup_entropy(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cleanup_entropy_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cleanup_entropy_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_get_nonce_fn = fn (?*const OSSL_CORE_HANDLE, [*c][*c]u8, usize, usize, ?*const anyopaque, usize) callconv(.c) usize;
pub fn OSSL_FUNC_get_nonce(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_get_nonce_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_get_nonce_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cleanup_nonce_fn = fn (?*const OSSL_CORE_HANDLE, [*c]u8, usize) callconv(.c) void;
pub fn OSSL_FUNC_cleanup_nonce(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cleanup_nonce_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cleanup_nonce_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_register_child_cb_fn = fn (?*const OSSL_CORE_HANDLE, ?*const fn (?*const OSSL_CORE_HANDLE, ?*anyopaque) callconv(.c) c_int, ?*const fn (?*const OSSL_CORE_HANDLE, ?*anyopaque) callconv(.c) c_int, ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) c_int, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_provider_register_child_cb(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_register_child_cb_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_register_child_cb_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_deregister_child_cb_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) void;
pub fn OSSL_FUNC_provider_deregister_child_cb(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_deregister_child_cb_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_deregister_child_cb_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_name_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) [*c]const u8;
pub fn OSSL_FUNC_provider_name(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_name_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_name_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_get0_provider_ctx_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_provider_get0_provider_ctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_get0_provider_ctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_get0_provider_ctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_get0_dispatch_fn = fn (?*const OSSL_CORE_HANDLE) callconv(.c) [*c]const OSSL_DISPATCH;
pub fn OSSL_FUNC_provider_get0_dispatch(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_get0_dispatch_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_get0_dispatch_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_up_ref_fn = fn (?*const OSSL_CORE_HANDLE, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_provider_up_ref(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_up_ref_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_up_ref_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_free_fn = fn (?*const OSSL_CORE_HANDLE, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_provider_free(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_free_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_free_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_teardown_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_provider_teardown(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_teardown_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_teardown_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_provider_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_get_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_provider_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_query_operation_fn = fn (?*anyopaque, c_int, [*c]c_int) callconv(.c) [*c]const OSSL_ALGORITHM;
pub fn OSSL_FUNC_provider_query_operation(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_query_operation_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_query_operation_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_unquery_operation_fn = fn (?*anyopaque, c_int, [*c]const OSSL_ALGORITHM) callconv(.c) void;
pub fn OSSL_FUNC_provider_unquery_operation(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_unquery_operation_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_unquery_operation_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_get_reason_strings_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_ITEM;
pub fn OSSL_FUNC_provider_get_reason_strings(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_get_reason_strings_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_get_reason_strings_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_get_capabilities_fn = fn (?*anyopaque, [*c]const u8, ?*const OSSL_CALLBACK, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_provider_get_capabilities(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_get_capabilities_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_get_capabilities_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_provider_self_test_fn = fn (?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_provider_self_test(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_provider_self_test_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_provider_self_test_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_digest_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_init_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_digest_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_update_fn = fn (?*anyopaque, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_digest_update(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_update_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_update_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_final_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_digest_final(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_final_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_final_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_digest_fn = fn (?*anyopaque, [*c]const u8, usize, [*c]u8, [*c]usize, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_digest_digest(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_digest_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_digest_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_digest_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_digest_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_get_params_fn = fn ([*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_digest_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_digest_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_digest_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_digest_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_digest_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_digest_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_digest_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_digest_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_digest_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_cipher_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_encrypt_init_fn = fn (?*anyopaque, [*c]const u8, usize, [*c]const u8, usize, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_encrypt_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_encrypt_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_encrypt_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_decrypt_init_fn = fn (?*anyopaque, [*c]const u8, usize, [*c]const u8, usize, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_decrypt_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_decrypt_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_decrypt_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_update_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_update(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_update_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_update_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_final_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_final(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_final_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_final_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_cipher_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_cipher(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_cipher_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_cipher_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_cipher_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_cipher_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_get_params_fn = fn ([*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_cipher_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_cipher_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_cipher_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_cipher_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_cipher_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_cipher_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_cipher_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_mac_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_mac_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_mac_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_init_fn = fn (?*anyopaque, [*c]const u8, usize, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_mac_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_update_fn = fn (?*anyopaque, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_mac_update(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_update_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_update_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_final_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_mac_final(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_final_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_final_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_mac_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_mac_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_mac_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_get_params_fn = fn ([*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_mac_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_mac_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_mac_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_mac_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_mac_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_mac_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_kdf_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_kdf_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_kdf_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_reset_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_kdf_reset(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_reset_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_reset_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_derive_fn = fn (?*anyopaque, [*c]u8, usize, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kdf_derive(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_derive_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_derive_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_kdf_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_kdf_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_kdf_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_get_params_fn = fn ([*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kdf_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kdf_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kdf_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kdf_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kdf_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kdf_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_newctx_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_DISPATCH) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_rand_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_rand_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_instantiate_fn = fn (?*anyopaque, c_uint, c_int, [*c]const u8, usize, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_instantiate(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_instantiate_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_instantiate_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_uninstantiate_fn = fn (?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_uninstantiate(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_uninstantiate_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_uninstantiate_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_generate_fn = fn (?*anyopaque, [*c]u8, usize, c_uint, c_int, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_generate(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_generate_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_generate_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_reseed_fn = fn (?*anyopaque, c_int, [*c]const u8, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_reseed(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_reseed_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_reseed_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_nonce_fn = fn (?*anyopaque, [*c]u8, c_uint, usize, usize) callconv(.c) usize;
pub fn OSSL_FUNC_rand_nonce(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_nonce_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_nonce_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_enable_locking_fn = fn (?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_enable_locking(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_enable_locking_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_enable_locking_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_lock_fn = fn (?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_lock(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_lock_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_lock_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_unlock_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_rand_unlock(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_unlock_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_unlock_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_rand_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_rand_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_rand_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_get_params_fn = fn ([*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_set_callbacks_fn = fn (?*anyopaque, ?*const OSSL_INOUT_CALLBACK, ?*const OSSL_CALLBACK, ?*const OSSL_INOUT_CALLBACK, ?*const OSSL_CALLBACK, ?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_rand_set_callbacks(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_set_callbacks_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_set_callbacks_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_verify_zeroization_fn = fn (?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_rand_verify_zeroization(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_verify_zeroization_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_verify_zeroization_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_get_seed_fn = fn (?*anyopaque, [*c][*c]u8, c_int, usize, usize, c_int, [*c]const u8, usize) callconv(.c) usize;
pub fn OSSL_FUNC_rand_get_seed(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_get_seed_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_get_seed_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_rand_clear_seed_fn = fn (?*anyopaque, [*c]u8, usize) callconv(.c) void;
pub fn OSSL_FUNC_rand_clear_seed(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_rand_clear_seed_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_rand_clear_seed_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_new_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_keymgmt_new(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_new_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_new_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_gen_init_fn = fn (?*anyopaque, c_int, [*c]const OSSL_PARAM) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_keymgmt_gen_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_gen_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_gen_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_gen_set_template_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_gen_set_template(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_gen_set_template_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_gen_set_template_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_gen_set_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_gen_set_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_gen_set_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_gen_set_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_gen_settable_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_keymgmt_gen_settable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_gen_settable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_gen_settable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_gen_fn = fn (?*anyopaque, ?*const OSSL_CALLBACK, ?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_keymgmt_gen(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_gen_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_gen_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_gen_cleanup_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_keymgmt_gen_cleanup(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_gen_cleanup_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_gen_cleanup_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_load_fn = fn (?*const anyopaque, usize) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_keymgmt_load(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_load_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_load_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_free_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_keymgmt_free(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_free_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_free_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_get_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_keymgmt_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_set_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_set_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_set_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_set_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_settable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_keymgmt_settable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_settable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_settable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_query_operation_name_fn = fn (c_int) callconv(.c) [*c]const u8;
pub fn OSSL_FUNC_keymgmt_query_operation_name(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_query_operation_name_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_query_operation_name_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_has_fn = fn (?*const anyopaque, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_has(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_has_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_has_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_validate_fn = fn (?*const anyopaque, c_int, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_validate(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_validate_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_validate_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_match_fn = fn (?*const anyopaque, ?*const anyopaque, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_match(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_match_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_match_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_import_fn = fn (?*anyopaque, c_int, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_import(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_import_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_import_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_import_types_fn = fn (c_int) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_keymgmt_import_types(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_import_types_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_import_types_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_export_fn = fn (?*anyopaque, c_int, ?*const OSSL_CALLBACK, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_keymgmt_export(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_export_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_export_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_export_types_fn = fn (c_int) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_keymgmt_export_types(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_export_types_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_export_types_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keymgmt_dup_fn = fn (?*const anyopaque, c_int) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_keymgmt_dup(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keymgmt_dup_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keymgmt_dup_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_keyexch_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_keyexch_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_derive_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_keyexch_derive(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_derive_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_derive_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_set_peer_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_keyexch_set_peer(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_set_peer_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_set_peer_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_keyexch_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_keyexch_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_keyexch_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_keyexch_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_keyexch_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_keyexch_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_keyexch_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_keyexch_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_keyexch_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_newctx_fn = fn (?*anyopaque, [*c]const u8) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_signature_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_sign_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_sign_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_sign_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_sign_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_sign_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_sign(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_sign_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_sign_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_verify_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_verify_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_verify_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_verify_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_verify_fn = fn (?*anyopaque, [*c]const u8, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_verify(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_verify_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_verify_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_verify_recover_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_verify_recover_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_verify_recover_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_verify_recover_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_verify_recover_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_verify_recover(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_verify_recover_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_verify_recover_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_sign_init_fn = fn (?*anyopaque, [*c]const u8, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_sign_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_sign_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_sign_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_sign_update_fn = fn (?*anyopaque, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_sign_update(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_sign_update_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_sign_update_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_sign_final_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_sign_final(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_sign_final_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_sign_final_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_sign_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_sign(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_sign_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_sign_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_verify_init_fn = fn (?*anyopaque, [*c]const u8, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_verify_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_verify_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_verify_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_verify_update_fn = fn (?*anyopaque, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_verify_update(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_verify_update_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_verify_update_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_verify_final_fn = fn (?*anyopaque, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_verify_final(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_verify_final_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_verify_final_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_digest_verify_fn = fn (?*anyopaque, [*c]const u8, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_digest_verify(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_digest_verify_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_digest_verify_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_signature_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_signature_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_signature_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_signature_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_get_ctx_md_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_get_ctx_md_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_get_ctx_md_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_get_ctx_md_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_gettable_ctx_md_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_signature_gettable_ctx_md_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_gettable_ctx_md_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_gettable_ctx_md_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_set_ctx_md_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_signature_set_ctx_md_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_set_ctx_md_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_set_ctx_md_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_signature_settable_ctx_md_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_signature_settable_ctx_md_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_signature_settable_ctx_md_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_signature_settable_ctx_md_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_asym_cipher_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_encrypt_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_asym_cipher_encrypt_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_encrypt_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_encrypt_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_encrypt_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_asym_cipher_encrypt(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_encrypt_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_encrypt_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_decrypt_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_asym_cipher_decrypt_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_decrypt_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_decrypt_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_decrypt_fn = fn (?*anyopaque, [*c]u8, [*c]usize, usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_asym_cipher_decrypt(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_decrypt_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_decrypt_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_asym_cipher_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_asym_cipher_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_asym_cipher_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_asym_cipher_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_asym_cipher_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_asym_cipher_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_asym_cipher_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_asym_cipher_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_asym_cipher_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_kem_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_encapsulate_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kem_encapsulate_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_encapsulate_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_encapsulate_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_encapsulate_fn = fn (?*anyopaque, [*c]u8, [*c]usize, [*c]u8, [*c]usize) callconv(.c) c_int;
pub fn OSSL_FUNC_kem_encapsulate(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_encapsulate_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_encapsulate_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_decapsulate_init_fn = fn (?*anyopaque, ?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kem_decapsulate_init(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_decapsulate_init_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_decapsulate_init_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_decapsulate_fn = fn (?*anyopaque, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int;
pub fn OSSL_FUNC_kem_decapsulate(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_decapsulate_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_decapsulate_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_kem_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_dupctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_kem_dupctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_dupctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_dupctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_get_ctx_params_fn = fn (?*anyopaque, [*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kem_get_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_get_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_get_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_gettable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_kem_gettable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_gettable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_gettable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_kem_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_kem_settable_ctx_params_fn = fn (?*anyopaque, ?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_kem_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_kem_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_kem_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_encoder_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_encoder_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_get_params_fn = fn ([*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_encoder_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_encoder_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_encoder_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_settable_ctx_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_encoder_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_does_selection_fn = fn (?*anyopaque, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_encoder_does_selection(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_does_selection_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_does_selection_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_encode_fn = fn (?*anyopaque, ?*OSSL_CORE_BIO, ?*const anyopaque, [*c]const OSSL_PARAM, c_int, ?*const OSSL_PASSPHRASE_CALLBACK, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_encoder_encode(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_encode_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_encode_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_import_object_fn = fn (?*anyopaque, c_int, [*c]const OSSL_PARAM) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_encoder_import_object(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_import_object_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_import_object_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_encoder_free_object_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_encoder_free_object(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_encoder_free_object_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_encoder_free_object_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_newctx_fn = fn (?*anyopaque) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_decoder_newctx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_newctx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_newctx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_freectx_fn = fn (?*anyopaque) callconv(.c) void;
pub fn OSSL_FUNC_decoder_freectx(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_freectx_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_freectx_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_get_params_fn = fn ([*c]OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_decoder_get_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_get_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_get_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_gettable_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_decoder_gettable_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_gettable_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_gettable_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_decoder_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_settable_ctx_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_decoder_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_does_selection_fn = fn (?*anyopaque, c_int) callconv(.c) c_int;
pub fn OSSL_FUNC_decoder_does_selection(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_does_selection_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_does_selection_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_decode_fn = fn (?*anyopaque, ?*OSSL_CORE_BIO, c_int, ?*const OSSL_CALLBACK, ?*anyopaque, ?*const OSSL_PASSPHRASE_CALLBACK, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_decoder_decode(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_decode_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_decode_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_decoder_export_object_fn = fn (?*anyopaque, ?*const anyopaque, usize, ?*const OSSL_CALLBACK, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_decoder_export_object(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_decoder_export_object_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_decoder_export_object_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_open_fn = fn (?*anyopaque, [*c]const u8) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_store_open(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_open_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_open_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_attach_fn = fn (?*anyopaque, ?*OSSL_CORE_BIO) callconv(.c) ?*anyopaque;
pub fn OSSL_FUNC_store_attach(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_attach_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_attach_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_settable_ctx_params_fn = fn (?*anyopaque) callconv(.c) [*c]const OSSL_PARAM;
pub fn OSSL_FUNC_store_settable_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_settable_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_settable_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_set_ctx_params_fn = fn (?*anyopaque, [*c]const OSSL_PARAM) callconv(.c) c_int;
pub fn OSSL_FUNC_store_set_ctx_params(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_set_ctx_params_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_set_ctx_params_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_load_fn = fn (?*anyopaque, ?*const OSSL_CALLBACK, ?*anyopaque, ?*const OSSL_PASSPHRASE_CALLBACK, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_store_load(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_load_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_load_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_eof_fn = fn (?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_store_eof(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_eof_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_eof_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_close_fn = fn (?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_store_close(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_close_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_close_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const OSSL_FUNC_store_export_object_fn = fn (?*anyopaque, ?*const anyopaque, usize, ?*const OSSL_CALLBACK, ?*anyopaque) callconv(.c) c_int;
pub fn OSSL_FUNC_store_export_object(arg_opf: [*c]const OSSL_DISPATCH) callconv(.c) ?*const OSSL_FUNC_store_export_object_fn {
    var opf = arg_opf;
    _ = &opf;
    return @as(?*const OSSL_FUNC_store_export_object_fn, @ptrCast(@alignCast(opf.*.function)));
}
pub const div_t = extern struct {
    quot: c_int = @import("std").mem.zeroes(c_int),
    rem: c_int = @import("std").mem.zeroes(c_int),
};
pub const ldiv_t = extern struct {
    quot: c_long = @import("std").mem.zeroes(c_long),
    rem: c_long = @import("std").mem.zeroes(c_long),
};
pub const lldiv_t = extern struct {
    quot: c_longlong = @import("std").mem.zeroes(c_longlong),
    rem: c_longlong = @import("std").mem.zeroes(c_longlong),
};
pub extern fn __ctype_get_mb_cur_max() usize;
pub extern fn atof(__nptr: [*c]const u8) f64;
pub extern fn atoi(__nptr: [*c]const u8) c_int;
pub extern fn atol(__nptr: [*c]const u8) c_long;
pub extern fn atoll(__nptr: [*c]const u8) c_longlong;
pub extern fn strtod(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f64;
pub extern fn strtof(__nptr: [*c]const u8, __endptr: [*c][*c]u8) f32;
pub extern fn strtold(__nptr: [*c]const u8, __endptr: [*c][*c]u8) c_longdouble;
pub extern fn strtol(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_long;
pub extern fn strtoul(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulong;
pub extern fn strtoq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtouq(noalias __nptr: [*c]const u8, noalias __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn strtoll(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_longlong;
pub extern fn strtoull(__nptr: [*c]const u8, __endptr: [*c][*c]u8, __base: c_int) c_ulonglong;
pub extern fn l64a(__n: c_long) [*c]u8;
pub extern fn a64l(__s: [*c]const u8) c_long;
pub const u_char = __u_char;
pub const u_short = __u_short;
pub const u_int = __u_int;
pub const u_long = __u_long;
pub const quad_t = __quad_t;
pub const u_quad_t = __u_quad_t;
pub const fsid_t = __fsid_t;
pub const loff_t = __loff_t;
pub const ino_t = __ino_t;
pub const dev_t = __dev_t;
pub const gid_t = __gid_t;
pub const mode_t = __mode_t;
pub const nlink_t = __nlink_t;
pub const uid_t = __uid_t;
pub const pid_t = __pid_t;
pub const id_t = __id_t;
pub const daddr_t = __daddr_t;
pub const caddr_t = __caddr_t;
pub const key_t = __key_t;
pub const clock_t = __clock_t;
pub const clockid_t = __clockid_t;
pub const time_t = __time_t;
pub const timer_t = __timer_t;
pub const ulong = c_ulong;
pub const ushort = c_ushort;
pub const uint = c_uint;
pub const u_int8_t = __uint8_t;
pub const u_int16_t = __uint16_t;
pub const u_int32_t = __uint32_t;
pub const u_int64_t = __uint64_t;
pub const register_t = c_long;
pub fn __bswap_16(arg___bsx: __uint16_t) callconv(.c) __uint16_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @as(__uint16_t, @bitCast(@as(c_short, @truncate(((@as(c_int, @bitCast(@as(c_uint, __bsx))) >> @intCast(8)) & @as(c_int, 255)) | ((@as(c_int, @bitCast(@as(c_uint, __bsx))) & @as(c_int, 255)) << @intCast(8))))));
}
pub fn __bswap_32(arg___bsx: __uint32_t) callconv(.c) __uint32_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return ((((__bsx & @as(c_uint, 4278190080)) >> @intCast(24)) | ((__bsx & @as(c_uint, 16711680)) >> @intCast(8))) | ((__bsx & @as(c_uint, 65280)) << @intCast(8))) | ((__bsx & @as(c_uint, 255)) << @intCast(24));
}
pub fn __bswap_64(arg___bsx: __uint64_t) callconv(.c) __uint64_t {
    var __bsx = arg___bsx;
    _ = &__bsx;
    return @as(__uint64_t, @bitCast(@as(c_ulong, @truncate(((((((((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 18374686479671623680)) >> @intCast(56)) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 71776119061217280)) >> @intCast(40))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 280375465082880)) >> @intCast(24))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 1095216660480)) >> @intCast(8))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 4278190080)) << @intCast(8))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 16711680)) << @intCast(24))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 65280)) << @intCast(40))) | ((@as(c_ulonglong, @bitCast(@as(c_ulonglong, __bsx))) & @as(c_ulonglong, 255)) << @intCast(56))))));
}
pub fn __uint16_identity(arg___x: __uint16_t) callconv(.c) __uint16_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint32_identity(arg___x: __uint32_t) callconv(.c) __uint32_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub fn __uint64_identity(arg___x: __uint64_t) callconv(.c) __uint64_t {
    var __x = arg___x;
    _ = &__x;
    return __x;
}
pub const __sigset_t = extern struct {
    __val: [16]c_ulong = @import("std").mem.zeroes([16]c_ulong),
};
pub const sigset_t = __sigset_t;
pub const struct_timeval = extern struct {
    tv_sec: __time_t = @import("std").mem.zeroes(__time_t),
    tv_usec: __suseconds_t = @import("std").mem.zeroes(__suseconds_t),
};
pub const struct_timespec = extern struct {
    tv_sec: __time_t = @import("std").mem.zeroes(__time_t),
    tv_nsec: __syscall_slong_t = @import("std").mem.zeroes(__syscall_slong_t),
};
pub const suseconds_t = __suseconds_t;
pub const __fd_mask = c_long;
pub const fd_set = extern struct {
    __fds_bits: [16]__fd_mask = @import("std").mem.zeroes([16]__fd_mask),
};
pub const fd_mask = __fd_mask;
pub extern fn select(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]struct_timeval) c_int;
pub extern fn pselect(__nfds: c_int, noalias __readfds: [*c]fd_set, noalias __writefds: [*c]fd_set, noalias __exceptfds: [*c]fd_set, noalias __timeout: [*c]const struct_timespec, noalias __sigmask: [*c]const __sigset_t) c_int;
pub const blksize_t = __blksize_t;
pub const blkcnt_t = __blkcnt_t;
pub const fsblkcnt_t = __fsblkcnt_t;
pub const fsfilcnt_t = __fsfilcnt_t;
const struct_unnamed_5 = extern struct {
    __low: c_uint = @import("std").mem.zeroes(c_uint),
    __high: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const __atomic_wide_counter = extern union {
    __value64: c_ulonglong,
    __value32: struct_unnamed_5,
};
pub const struct___pthread_internal_list = extern struct {
    __prev: [*c]struct___pthread_internal_list = @import("std").mem.zeroes([*c]struct___pthread_internal_list),
    __next: [*c]struct___pthread_internal_list = @import("std").mem.zeroes([*c]struct___pthread_internal_list),
};
pub const __pthread_list_t = struct___pthread_internal_list;
pub const struct___pthread_internal_slist = extern struct {
    __next: [*c]struct___pthread_internal_slist = @import("std").mem.zeroes([*c]struct___pthread_internal_slist),
};
pub const __pthread_slist_t = struct___pthread_internal_slist;
pub const struct___pthread_mutex_s = extern struct {
    __lock: c_int = @import("std").mem.zeroes(c_int),
    __count: c_uint = @import("std").mem.zeroes(c_uint),
    __owner: c_int = @import("std").mem.zeroes(c_int),
    __nusers: c_uint = @import("std").mem.zeroes(c_uint),
    __kind: c_int = @import("std").mem.zeroes(c_int),
    __spins: c_short = @import("std").mem.zeroes(c_short),
    __elision: c_short = @import("std").mem.zeroes(c_short),
    __list: __pthread_list_t = @import("std").mem.zeroes(__pthread_list_t),
};
pub const struct___pthread_rwlock_arch_t = extern struct {
    __readers: c_uint = @import("std").mem.zeroes(c_uint),
    __writers: c_uint = @import("std").mem.zeroes(c_uint),
    __wrphase_futex: c_uint = @import("std").mem.zeroes(c_uint),
    __writers_futex: c_uint = @import("std").mem.zeroes(c_uint),
    __pad3: c_uint = @import("std").mem.zeroes(c_uint),
    __pad4: c_uint = @import("std").mem.zeroes(c_uint),
    __cur_writer: c_int = @import("std").mem.zeroes(c_int),
    __shared: c_int = @import("std").mem.zeroes(c_int),
    __rwelision: i8 = @import("std").mem.zeroes(i8),
    __pad1: [7]u8 = @import("std").mem.zeroes([7]u8),
    __pad2: c_ulong = @import("std").mem.zeroes(c_ulong),
    __flags: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const struct___pthread_cond_s = extern struct {
    __wseq: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g1_start: __atomic_wide_counter = @import("std").mem.zeroes(__atomic_wide_counter),
    __g_refs: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g_size: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
    __g1_orig_size: c_uint = @import("std").mem.zeroes(c_uint),
    __wrefs: c_uint = @import("std").mem.zeroes(c_uint),
    __g_signals: [2]c_uint = @import("std").mem.zeroes([2]c_uint),
};
pub const __tss_t = c_uint;
pub const __thrd_t = c_ulong;
pub const __once_flag = extern struct {
    __data: c_int = @import("std").mem.zeroes(c_int),
};
pub const pthread_t = c_ulong;
pub const pthread_mutexattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_condattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub const pthread_key_t = c_uint;
pub const pthread_once_t = c_int;
pub const union_pthread_attr_t = extern union {
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_attr_t = union_pthread_attr_t;
pub const pthread_mutex_t = extern union {
    __data: struct___pthread_mutex_s,
    __size: [40]u8,
    __align: c_long,
};
pub const pthread_cond_t = extern union {
    __data: struct___pthread_cond_s,
    __size: [48]u8,
    __align: c_longlong,
};
pub const pthread_rwlock_t = extern union {
    __data: struct___pthread_rwlock_arch_t,
    __size: [56]u8,
    __align: c_long,
};
pub const pthread_rwlockattr_t = extern union {
    __size: [8]u8,
    __align: c_long,
};
pub const pthread_spinlock_t = c_int;
pub const pthread_barrier_t = extern union {
    __size: [32]u8,
    __align: c_long,
};
pub const pthread_barrierattr_t = extern union {
    __size: [4]u8,
    __align: c_int,
};
pub extern fn random() c_long;
pub extern fn srandom(__seed: c_uint) void;
pub extern fn initstate(__seed: c_uint, __statebuf: [*c]u8, __statelen: usize) [*c]u8;
pub extern fn setstate(__statebuf: [*c]u8) [*c]u8;
pub const struct_random_data = extern struct {
    fptr: [*c]i32 = @import("std").mem.zeroes([*c]i32),
    rptr: [*c]i32 = @import("std").mem.zeroes([*c]i32),
    state: [*c]i32 = @import("std").mem.zeroes([*c]i32),
    rand_type: c_int = @import("std").mem.zeroes(c_int),
    rand_deg: c_int = @import("std").mem.zeroes(c_int),
    rand_sep: c_int = @import("std").mem.zeroes(c_int),
    end_ptr: [*c]i32 = @import("std").mem.zeroes([*c]i32),
};
pub extern fn random_r(noalias __buf: [*c]struct_random_data, noalias __result: [*c]i32) c_int;
pub extern fn srandom_r(__seed: c_uint, __buf: [*c]struct_random_data) c_int;
pub extern fn initstate_r(__seed: c_uint, noalias __statebuf: [*c]u8, __statelen: usize, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn setstate_r(noalias __statebuf: [*c]u8, noalias __buf: [*c]struct_random_data) c_int;
pub extern fn rand() c_int;
pub extern fn srand(__seed: c_uint) void;
pub extern fn rand_r(__seed: [*c]c_uint) c_int;
pub extern fn drand48() f64;
pub extern fn erand48(__xsubi: [*c]c_ushort) f64;
pub extern fn lrand48() c_long;
pub extern fn nrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn mrand48() c_long;
pub extern fn jrand48(__xsubi: [*c]c_ushort) c_long;
pub extern fn srand48(__seedval: c_long) void;
pub extern fn seed48(__seed16v: [*c]c_ushort) [*c]c_ushort;
pub extern fn lcong48(__param: [*c]c_ushort) void;
pub const struct_drand48_data = extern struct {
    __x: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
    __old_x: [3]c_ushort = @import("std").mem.zeroes([3]c_ushort),
    __c: c_ushort = @import("std").mem.zeroes(c_ushort),
    __init: c_ushort = @import("std").mem.zeroes(c_ushort),
    __a: c_ulonglong = @import("std").mem.zeroes(c_ulonglong),
};
pub extern fn drand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn erand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]f64) c_int;
pub extern fn lrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn nrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn mrand48_r(noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn jrand48_r(__xsubi: [*c]c_ushort, noalias __buffer: [*c]struct_drand48_data, noalias __result: [*c]c_long) c_int;
pub extern fn srand48_r(__seedval: c_long, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn seed48_r(__seed16v: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn lcong48_r(__param: [*c]c_ushort, __buffer: [*c]struct_drand48_data) c_int;
pub extern fn arc4random() __uint32_t;
pub extern fn arc4random_buf(__buf: ?*anyopaque, __size: usize) void;
pub extern fn arc4random_uniform(__upper_bound: __uint32_t) __uint32_t;
pub extern fn malloc(__size: c_ulong) ?*anyopaque;
pub extern fn calloc(__nmemb: c_ulong, __size: c_ulong) ?*anyopaque;
pub extern fn realloc(__ptr: ?*anyopaque, __size: c_ulong) ?*anyopaque;
pub extern fn free(__ptr: ?*anyopaque) void;
pub extern fn reallocarray(__ptr: ?*anyopaque, __nmemb: usize, __size: usize) ?*anyopaque;
pub extern fn alloca(__size: c_ulong) ?*anyopaque;
pub extern fn valloc(__size: usize) ?*anyopaque;
pub extern fn posix_memalign(__memptr: [*c]?*anyopaque, __alignment: usize, __size: usize) c_int;
pub extern fn aligned_alloc(__alignment: c_ulong, __size: c_ulong) ?*anyopaque;
pub extern fn abort() noreturn;
pub extern fn atexit(__func: ?*const fn () callconv(.c) void) c_int;
pub extern fn at_quick_exit(__func: ?*const fn () callconv(.c) void) c_int;
pub extern fn on_exit(__func: ?*const fn (c_int, ?*anyopaque) callconv(.c) void, __arg: ?*anyopaque) c_int;
pub extern fn exit(__status: c_int) noreturn;
pub extern fn quick_exit(__status: c_int) noreturn;
pub extern fn _Exit(__status: c_int) noreturn;
pub extern fn getenv(__name: [*c]const u8) [*c]u8;
pub extern fn putenv(__string: [*c]u8) c_int;
pub extern fn setenv(__name: [*c]const u8, __value: [*c]const u8, __replace: c_int) c_int;
pub extern fn unsetenv(__name: [*c]const u8) c_int;
pub extern fn clearenv() c_int;
pub extern fn mktemp(__template: [*c]u8) [*c]u8;
pub extern fn mkstemp(__template: [*c]u8) c_int;
pub extern fn mkstemps(__template: [*c]u8, __suffixlen: c_int) c_int;
pub extern fn mkdtemp(__template: [*c]u8) [*c]u8;
pub extern fn system(__command: [*c]const u8) c_int;
pub extern fn realpath(noalias __name: [*c]const u8, noalias __resolved: [*c]u8) [*c]u8;
pub const __compar_fn_t = ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int;
pub extern fn bsearch(__key: ?*const anyopaque, __base: ?*const anyopaque, __nmemb: usize, __size: usize, __compar: __compar_fn_t) ?*anyopaque;
pub extern fn qsort(__base: ?*anyopaque, __nmemb: usize, __size: usize, __compar: __compar_fn_t) void;
pub extern fn abs(__x: c_int) c_int;
pub extern fn labs(__x: c_long) c_long;
pub extern fn llabs(__x: c_longlong) c_longlong;
pub extern fn div(__numer: c_int, __denom: c_int) div_t;
pub extern fn ldiv(__numer: c_long, __denom: c_long) ldiv_t;
pub extern fn lldiv(__numer: c_longlong, __denom: c_longlong) lldiv_t;
pub extern fn ecvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn fcvt(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn gcvt(__value: f64, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn qecvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qfcvt(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int) [*c]u8;
pub extern fn qgcvt(__value: c_longdouble, __ndigit: c_int, __buf: [*c]u8) [*c]u8;
pub extern fn ecvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn fcvt_r(__value: f64, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qecvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn qfcvt_r(__value: c_longdouble, __ndigit: c_int, noalias __decpt: [*c]c_int, noalias __sign: [*c]c_int, noalias __buf: [*c]u8, __len: usize) c_int;
pub extern fn mblen(__s: [*c]const u8, __n: usize) c_int;
pub extern fn mbtowc(noalias __pwc: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) c_int;
pub extern fn wctomb(__s: [*c]u8, __wchar: wchar_t) c_int;
pub extern fn mbstowcs(noalias __pwcs: [*c]wchar_t, noalias __s: [*c]const u8, __n: usize) usize;
pub extern fn wcstombs(noalias __s: [*c]u8, noalias __pwcs: [*c]const wchar_t, __n: usize) usize;
pub extern fn rpmatch(__response: [*c]const u8) c_int;
pub extern fn getsubopt(noalias __optionp: [*c][*c]u8, noalias __tokens: [*c]const [*c]u8, noalias __valuep: [*c][*c]u8) c_int;
pub extern fn getloadavg(__loadavg: [*c]f64, __nelem: c_int) c_int;
pub const struct_tm = extern struct {
    tm_sec: c_int = @import("std").mem.zeroes(c_int),
    tm_min: c_int = @import("std").mem.zeroes(c_int),
    tm_hour: c_int = @import("std").mem.zeroes(c_int),
    tm_mday: c_int = @import("std").mem.zeroes(c_int),
    tm_mon: c_int = @import("std").mem.zeroes(c_int),
    tm_year: c_int = @import("std").mem.zeroes(c_int),
    tm_wday: c_int = @import("std").mem.zeroes(c_int),
    tm_yday: c_int = @import("std").mem.zeroes(c_int),
    tm_isdst: c_int = @import("std").mem.zeroes(c_int),
    tm_gmtoff: c_long = @import("std").mem.zeroes(c_long),
    tm_zone: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const struct_itimerspec = extern struct {
    it_interval: struct_timespec = @import("std").mem.zeroes(struct_timespec),
    it_value: struct_timespec = @import("std").mem.zeroes(struct_timespec),
};
pub const struct_sigevent = opaque {};
pub const struct___locale_data_6 = opaque {};
pub const struct___locale_struct = extern struct {
    __locales: [13]?*struct___locale_data_6 = @import("std").mem.zeroes([13]?*struct___locale_data_6),
    __ctype_b: [*c]const c_ushort = @import("std").mem.zeroes([*c]const c_ushort),
    __ctype_tolower: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    __ctype_toupper: [*c]const c_int = @import("std").mem.zeroes([*c]const c_int),
    __names: [13][*c]const u8 = @import("std").mem.zeroes([13][*c]const u8),
};
pub const __locale_t = [*c]struct___locale_struct;
pub const locale_t = __locale_t;
pub extern fn clock() clock_t;
pub extern fn time(__timer: [*c]time_t) time_t;
pub extern fn difftime(__time1: time_t, __time0: time_t) f64;
pub extern fn mktime(__tp: [*c]struct_tm) time_t;
pub extern fn strftime(noalias __s: [*c]u8, __maxsize: usize, noalias __format: [*c]const u8, noalias __tp: [*c]const struct_tm) usize;
pub extern fn strftime_l(noalias __s: [*c]u8, __maxsize: usize, noalias __format: [*c]const u8, noalias __tp: [*c]const struct_tm, __loc: locale_t) usize;
pub extern fn gmtime(__timer: [*c]const time_t) [*c]struct_tm;
pub extern fn localtime(__timer: [*c]const time_t) [*c]struct_tm;
pub extern fn gmtime_r(noalias __timer: [*c]const time_t, noalias __tp: [*c]struct_tm) [*c]struct_tm;
pub extern fn localtime_r(noalias __timer: [*c]const time_t, noalias __tp: [*c]struct_tm) [*c]struct_tm;
pub extern fn asctime(__tp: [*c]const struct_tm) [*c]u8;
pub extern fn ctime(__timer: [*c]const time_t) [*c]u8;
pub extern fn asctime_r(noalias __tp: [*c]const struct_tm, noalias __buf: [*c]u8) [*c]u8;
pub extern fn ctime_r(noalias __timer: [*c]const time_t, noalias __buf: [*c]u8) [*c]u8;
pub extern var __tzname: [2][*c]u8;
pub extern var __daylight: c_int;
pub extern var __timezone: c_long;
pub extern var tzname: [2][*c]u8;
pub extern fn tzset() void;
pub extern var daylight: c_int;
pub extern var timezone: c_long;
pub extern fn timegm(__tp: [*c]struct_tm) time_t;
pub extern fn timelocal(__tp: [*c]struct_tm) time_t;
pub extern fn dysize(__year: c_int) c_int;
pub extern fn nanosleep(__requested_time: [*c]const struct_timespec, __remaining: [*c]struct_timespec) c_int;
pub extern fn clock_getres(__clock_id: clockid_t, __res: [*c]struct_timespec) c_int;
pub extern fn clock_gettime(__clock_id: clockid_t, __tp: [*c]struct_timespec) c_int;
pub extern fn clock_settime(__clock_id: clockid_t, __tp: [*c]const struct_timespec) c_int;
pub extern fn clock_nanosleep(__clock_id: clockid_t, __flags: c_int, __req: [*c]const struct_timespec, __rem: [*c]struct_timespec) c_int;
pub extern fn clock_getcpuclockid(__pid: pid_t, __clock_id: [*c]clockid_t) c_int;
pub extern fn timer_create(__clock_id: clockid_t, noalias __evp: ?*struct_sigevent, noalias __timerid: [*c]timer_t) c_int;
pub extern fn timer_delete(__timerid: timer_t) c_int;
pub extern fn timer_settime(__timerid: timer_t, __flags: c_int, noalias __value: [*c]const struct_itimerspec, noalias __ovalue: [*c]struct_itimerspec) c_int;
pub extern fn timer_gettime(__timerid: timer_t, __value: [*c]struct_itimerspec) c_int;
pub extern fn timer_getoverrun(__timerid: timer_t) c_int;
pub extern fn timespec_get(__ts: [*c]struct_timespec, __base: c_int) c_int;
pub extern fn ERR_load_ASN1_strings() c_int;
pub extern fn ERR_load_ASYNC_strings() c_int;
pub extern fn ERR_load_BIO_strings() c_int;
pub extern fn ERR_load_BN_strings() c_int;
pub extern fn ERR_load_BUF_strings() c_int;
pub extern fn ERR_load_CMS_strings() c_int;
pub extern fn ERR_load_COMP_strings() c_int;
pub extern fn ERR_load_CONF_strings() c_int;
pub extern fn ERR_load_CRYPTO_strings() c_int;
pub extern fn ERR_load_CT_strings() c_int;
pub extern fn ERR_load_DH_strings() c_int;
pub extern fn ERR_load_DSA_strings() c_int;
pub extern fn ERR_load_EC_strings() c_int;
pub extern fn ERR_load_ENGINE_strings() c_int;
pub extern fn ERR_load_ERR_strings() c_int;
pub extern fn ERR_load_EVP_strings() c_int;
pub extern fn ERR_load_KDF_strings() c_int;
pub extern fn ERR_load_OBJ_strings() c_int;
pub extern fn ERR_load_OCSP_strings() c_int;
pub extern fn ERR_load_PEM_strings() c_int;
pub extern fn ERR_load_PKCS12_strings() c_int;
pub extern fn ERR_load_PKCS7_strings() c_int;
pub extern fn ERR_load_RAND_strings() c_int;
pub extern fn ERR_load_RSA_strings() c_int;
pub extern fn ERR_load_OSSL_STORE_strings() c_int;
pub extern fn ERR_load_TS_strings() c_int;
pub extern fn ERR_load_UI_strings() c_int;
pub extern fn ERR_load_X509_strings() c_int;
pub extern fn ERR_load_X509V3_strings() c_int;
pub const CRYPTO_dynlock = extern struct {
    dummy: c_int = @import("std").mem.zeroes(c_int),
};
pub const CRYPTO_RWLOCK = anyopaque;
pub extern fn CRYPTO_THREAD_lock_new() ?*CRYPTO_RWLOCK;
pub extern fn CRYPTO_THREAD_read_lock(lock: ?*CRYPTO_RWLOCK) c_int;
pub extern fn CRYPTO_THREAD_write_lock(lock: ?*CRYPTO_RWLOCK) c_int;
pub extern fn CRYPTO_THREAD_unlock(lock: ?*CRYPTO_RWLOCK) c_int;
pub extern fn CRYPTO_THREAD_lock_free(lock: ?*CRYPTO_RWLOCK) void;
pub extern fn CRYPTO_atomic_add(val: [*c]c_int, amount: c_int, ret: [*c]c_int, lock: ?*CRYPTO_RWLOCK) c_int;
pub extern fn CRYPTO_atomic_or(val: [*c]u64, op: u64, ret: [*c]u64, lock: ?*CRYPTO_RWLOCK) c_int;
pub extern fn CRYPTO_atomic_load(val: [*c]u64, ret: [*c]u64, lock: ?*CRYPTO_RWLOCK) c_int;
pub extern fn OPENSSL_strlcpy(dst: [*c]u8, src: [*c]const u8, siz: usize) usize;
pub extern fn OPENSSL_strlcat(dst: [*c]u8, src: [*c]const u8, siz: usize) usize;
pub extern fn OPENSSL_strnlen(str: [*c]const u8, maxlen: usize) usize;
pub extern fn OPENSSL_buf2hexstr_ex(str: [*c]u8, str_n: usize, strlength: [*c]usize, buf: [*c]const u8, buflen: usize, sep: u8) c_int;
pub extern fn OPENSSL_buf2hexstr(buf: [*c]const u8, buflen: c_long) [*c]u8;
pub extern fn OPENSSL_hexstr2buf_ex(buf: [*c]u8, buf_n: usize, buflen: [*c]usize, str: [*c]const u8, sep: u8) c_int;
pub extern fn OPENSSL_hexstr2buf(str: [*c]const u8, buflen: [*c]c_long) [*c]u8;
pub extern fn OPENSSL_hexchar2int(c: u8) c_int;
pub extern fn OPENSSL_strcasecmp(s1: [*c]const u8, s2: [*c]const u8) c_int;
pub extern fn OPENSSL_strncasecmp(s1: [*c]const u8, s2: [*c]const u8, n: usize) c_int;
pub extern fn OPENSSL_version_major() c_uint;
pub extern fn OPENSSL_version_minor() c_uint;
pub extern fn OPENSSL_version_patch() c_uint;
pub extern fn OPENSSL_version_pre_release() [*c]const u8;
pub extern fn OPENSSL_version_build_metadata() [*c]const u8;
pub extern fn OpenSSL_version_num() c_ulong;
pub extern fn OpenSSL_version(@"type": c_int) [*c]const u8;
pub extern fn OPENSSL_info(@"type": c_int) [*c]const u8;
pub extern fn OPENSSL_issetugid() c_int;
pub const sk_void_compfunc = ?*const fn ([*c]const ?*const anyopaque, [*c]const ?*const anyopaque) callconv(.c) c_int;
pub const sk_void_freefunc = ?*const fn (?*anyopaque) callconv(.c) void;
pub const sk_void_copyfunc = ?*const fn (?*const anyopaque) callconv(.c) ?*anyopaque;
pub fn ossl_check_void_type(arg_ptr: ?*anyopaque) callconv(.c) ?*anyopaque {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_void_sk_type(arg_sk: ?*const struct_stack_st_void) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_void_sk_type(arg_sk: ?*struct_stack_st_void) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_void_compfunc_type(arg_cmp: sk_void_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_void_copyfunc_type(arg_cpy: sk_void_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_void_freefunc_type(arg_fr: sk_void_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const CRYPTO_EX_new = fn (?*anyopaque, ?*anyopaque, [*c]CRYPTO_EX_DATA, c_int, c_long, ?*anyopaque) callconv(.c) void;
pub const CRYPTO_EX_free = fn (?*anyopaque, ?*anyopaque, [*c]CRYPTO_EX_DATA, c_int, c_long, ?*anyopaque) callconv(.c) void;
pub const CRYPTO_EX_dup = fn ([*c]CRYPTO_EX_DATA, [*c]const CRYPTO_EX_DATA, [*c]?*anyopaque, c_int, c_long, ?*anyopaque) callconv(.c) c_int;
pub extern fn CRYPTO_get_ex_new_index(class_index: c_int, argl: c_long, argp: ?*anyopaque, new_func: ?*const CRYPTO_EX_new, dup_func: ?*const CRYPTO_EX_dup, free_func: ?*const CRYPTO_EX_free) c_int;
pub extern fn CRYPTO_free_ex_index(class_index: c_int, idx: c_int) c_int;
pub extern fn CRYPTO_new_ex_data(class_index: c_int, obj: ?*anyopaque, ad: [*c]CRYPTO_EX_DATA) c_int;
pub extern fn CRYPTO_dup_ex_data(class_index: c_int, to: [*c]CRYPTO_EX_DATA, from: [*c]const CRYPTO_EX_DATA) c_int;
pub extern fn CRYPTO_free_ex_data(class_index: c_int, obj: ?*anyopaque, ad: [*c]CRYPTO_EX_DATA) void;
pub extern fn CRYPTO_alloc_ex_data(class_index: c_int, obj: ?*anyopaque, ad: [*c]CRYPTO_EX_DATA, idx: c_int) c_int;
pub extern fn CRYPTO_set_ex_data(ad: [*c]CRYPTO_EX_DATA, idx: c_int, val: ?*anyopaque) c_int;
pub extern fn CRYPTO_get_ex_data(ad: [*c]const CRYPTO_EX_DATA, idx: c_int) ?*anyopaque;
pub const struct_crypto_threadid_st = extern struct {
    dummy: c_int = @import("std").mem.zeroes(c_int),
};
pub const CRYPTO_THREADID = struct_crypto_threadid_st;
pub const CRYPTO_malloc_fn = ?*const fn (usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub const CRYPTO_realloc_fn = ?*const fn (?*anyopaque, usize, [*c]const u8, c_int) callconv(.c) ?*anyopaque;
pub const CRYPTO_free_fn = ?*const fn (?*anyopaque, [*c]const u8, c_int) callconv(.c) void;
pub extern fn CRYPTO_set_mem_functions(malloc_fn: CRYPTO_malloc_fn, realloc_fn: CRYPTO_realloc_fn, free_fn: CRYPTO_free_fn) c_int;
pub extern fn CRYPTO_get_mem_functions(malloc_fn: [*c]CRYPTO_malloc_fn, realloc_fn: [*c]CRYPTO_realloc_fn, free_fn: [*c]CRYPTO_free_fn) void;
pub extern fn CRYPTO_malloc(num: usize, file: [*c]const u8, line: c_int) ?*anyopaque;
pub extern fn CRYPTO_zalloc(num: usize, file: [*c]const u8, line: c_int) ?*anyopaque;
pub extern fn CRYPTO_memdup(str: ?*const anyopaque, siz: usize, file: [*c]const u8, line: c_int) ?*anyopaque;
pub extern fn CRYPTO_strdup(str: [*c]const u8, file: [*c]const u8, line: c_int) [*c]u8;
pub extern fn CRYPTO_strndup(str: [*c]const u8, s: usize, file: [*c]const u8, line: c_int) [*c]u8;
pub extern fn CRYPTO_free(ptr: ?*anyopaque, file: [*c]const u8, line: c_int) void;
pub extern fn CRYPTO_clear_free(ptr: ?*anyopaque, num: usize, file: [*c]const u8, line: c_int) void;
pub extern fn CRYPTO_realloc(addr: ?*anyopaque, num: usize, file: [*c]const u8, line: c_int) ?*anyopaque;
pub extern fn CRYPTO_clear_realloc(addr: ?*anyopaque, old_num: usize, num: usize, file: [*c]const u8, line: c_int) ?*anyopaque;
pub extern fn CRYPTO_secure_malloc_init(sz: usize, minsize: usize) c_int;
pub extern fn CRYPTO_secure_malloc_done() c_int;
pub extern fn CRYPTO_secure_malloc(num: usize, file: [*c]const u8, line: c_int) ?*anyopaque;
pub extern fn CRYPTO_secure_zalloc(num: usize, file: [*c]const u8, line: c_int) ?*anyopaque;
pub extern fn CRYPTO_secure_free(ptr: ?*anyopaque, file: [*c]const u8, line: c_int) void;
pub extern fn CRYPTO_secure_clear_free(ptr: ?*anyopaque, num: usize, file: [*c]const u8, line: c_int) void;
pub extern fn CRYPTO_secure_allocated(ptr: ?*const anyopaque) c_int;
pub extern fn CRYPTO_secure_malloc_initialized() c_int;
pub extern fn CRYPTO_secure_actual_size(ptr: ?*anyopaque) usize;
pub extern fn CRYPTO_secure_used() usize;
pub extern fn OPENSSL_cleanse(ptr: ?*anyopaque, len: usize) void;
pub extern fn OPENSSL_die(assertion: [*c]const u8, file: [*c]const u8, line: c_int) void;
pub extern fn OPENSSL_isservice() c_int;
pub extern fn OPENSSL_init() void;
pub extern fn OPENSSL_fork_prepare() void;
pub extern fn OPENSSL_fork_parent() void;
pub extern fn OPENSSL_fork_child() void;
pub extern fn OPENSSL_gmtime(timer: [*c]const time_t, result: [*c]struct_tm) [*c]struct_tm;
pub extern fn OPENSSL_gmtime_adj(tm: [*c]struct_tm, offset_day: c_int, offset_sec: c_long) c_int;
pub extern fn OPENSSL_gmtime_diff(pday: [*c]c_int, psec: [*c]c_int, from: [*c]const struct_tm, to: [*c]const struct_tm) c_int;
pub extern fn CRYPTO_memcmp(in_a: ?*const anyopaque, in_b: ?*const anyopaque, len: usize) c_int;
pub extern fn OPENSSL_cleanup() void;
pub extern fn OPENSSL_init_crypto(opts: u64, settings: ?*const OPENSSL_INIT_SETTINGS) c_int;
pub extern fn OPENSSL_atexit(handler: ?*const fn () callconv(.c) void) c_int;
pub extern fn OPENSSL_thread_stop() void;
pub extern fn OPENSSL_thread_stop_ex(ctx: ?*OSSL_LIB_CTX) void;
pub extern fn OPENSSL_INIT_new() ?*OPENSSL_INIT_SETTINGS;
pub extern fn OPENSSL_INIT_set_config_filename(settings: ?*OPENSSL_INIT_SETTINGS, config_filename: [*c]const u8) c_int;
pub extern fn OPENSSL_INIT_set_config_file_flags(settings: ?*OPENSSL_INIT_SETTINGS, flags: c_ulong) void;
pub extern fn OPENSSL_INIT_set_config_appname(settings: ?*OPENSSL_INIT_SETTINGS, config_appname: [*c]const u8) c_int;
pub extern fn OPENSSL_INIT_free(settings: ?*OPENSSL_INIT_SETTINGS) void;
pub const struct_sched_param = extern struct {
    sched_priority: c_int = @import("std").mem.zeroes(c_int),
};
pub const __cpu_mask = c_ulong;
pub const cpu_set_t = extern struct {
    __bits: [16]__cpu_mask = @import("std").mem.zeroes([16]__cpu_mask),
};
pub extern fn __sched_cpucount(__setsize: usize, __setp: [*c]const cpu_set_t) c_int;
pub extern fn __sched_cpualloc(__count: usize) [*c]cpu_set_t;
pub extern fn __sched_cpufree(__set: [*c]cpu_set_t) void;
pub extern fn sched_setparam(__pid: __pid_t, __param: [*c]const struct_sched_param) c_int;
pub extern fn sched_getparam(__pid: __pid_t, __param: [*c]struct_sched_param) c_int;
pub extern fn sched_setscheduler(__pid: __pid_t, __policy: c_int, __param: [*c]const struct_sched_param) c_int;
pub extern fn sched_getscheduler(__pid: __pid_t) c_int;
pub extern fn sched_yield() c_int;
pub extern fn sched_get_priority_max(__algorithm: c_int) c_int;
pub extern fn sched_get_priority_min(__algorithm: c_int) c_int;
pub extern fn sched_rr_get_interval(__pid: __pid_t, __t: [*c]struct_timespec) c_int;
pub const __jmp_buf = [8]c_long;
pub const struct___jmp_buf_tag = extern struct {
    __jmpbuf: __jmp_buf = @import("std").mem.zeroes(__jmp_buf),
    __mask_was_saved: c_int = @import("std").mem.zeroes(c_int),
    __saved_mask: __sigset_t = @import("std").mem.zeroes(__sigset_t),
};
pub const PTHREAD_CREATE_JOINABLE: c_int = 0;
pub const PTHREAD_CREATE_DETACHED: c_int = 1;
const enum_unnamed_7 = c_uint;
pub const PTHREAD_MUTEX_TIMED_NP: c_int = 0;
pub const PTHREAD_MUTEX_RECURSIVE_NP: c_int = 1;
pub const PTHREAD_MUTEX_ERRORCHECK_NP: c_int = 2;
pub const PTHREAD_MUTEX_ADAPTIVE_NP: c_int = 3;
pub const PTHREAD_MUTEX_NORMAL: c_int = 0;
pub const PTHREAD_MUTEX_RECURSIVE: c_int = 1;
pub const PTHREAD_MUTEX_ERRORCHECK: c_int = 2;
pub const PTHREAD_MUTEX_DEFAULT: c_int = 0;
const enum_unnamed_8 = c_uint;
pub const PTHREAD_MUTEX_STALLED: c_int = 0;
pub const PTHREAD_MUTEX_STALLED_NP: c_int = 0;
pub const PTHREAD_MUTEX_ROBUST: c_int = 1;
pub const PTHREAD_MUTEX_ROBUST_NP: c_int = 1;
const enum_unnamed_9 = c_uint;
pub const PTHREAD_PRIO_NONE: c_int = 0;
pub const PTHREAD_PRIO_INHERIT: c_int = 1;
pub const PTHREAD_PRIO_PROTECT: c_int = 2;
const enum_unnamed_10 = c_uint;
pub const PTHREAD_RWLOCK_PREFER_READER_NP: c_int = 0;
pub const PTHREAD_RWLOCK_PREFER_WRITER_NP: c_int = 1;
pub const PTHREAD_RWLOCK_PREFER_WRITER_NONRECURSIVE_NP: c_int = 2;
pub const PTHREAD_RWLOCK_DEFAULT_NP: c_int = 0;
const enum_unnamed_11 = c_uint;
pub const PTHREAD_INHERIT_SCHED: c_int = 0;
pub const PTHREAD_EXPLICIT_SCHED: c_int = 1;
const enum_unnamed_12 = c_uint;
pub const PTHREAD_SCOPE_SYSTEM: c_int = 0;
pub const PTHREAD_SCOPE_PROCESS: c_int = 1;
const enum_unnamed_13 = c_uint;
pub const PTHREAD_PROCESS_PRIVATE: c_int = 0;
pub const PTHREAD_PROCESS_SHARED: c_int = 1;
const enum_unnamed_14 = c_uint;
pub const struct__pthread_cleanup_buffer = extern struct {
    __routine: ?*const fn (?*anyopaque) callconv(.c) void = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.c) void),
    __arg: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    __canceltype: c_int = @import("std").mem.zeroes(c_int),
    __prev: [*c]struct__pthread_cleanup_buffer = @import("std").mem.zeroes([*c]struct__pthread_cleanup_buffer),
};
pub const PTHREAD_CANCEL_ENABLE: c_int = 0;
pub const PTHREAD_CANCEL_DISABLE: c_int = 1;
const enum_unnamed_15 = c_uint;
pub const PTHREAD_CANCEL_DEFERRED: c_int = 0;
pub const PTHREAD_CANCEL_ASYNCHRONOUS: c_int = 1;
const enum_unnamed_16 = c_uint;
pub extern fn pthread_create(noalias __newthread: [*c]pthread_t, noalias __attr: [*c]const pthread_attr_t, __start_routine: ?*const fn (?*anyopaque) callconv(.c) ?*anyopaque, noalias __arg: ?*anyopaque) c_int;
pub extern fn pthread_exit(__retval: ?*anyopaque) noreturn;
pub extern fn pthread_join(__th: pthread_t, __thread_return: [*c]?*anyopaque) c_int;
pub extern fn pthread_detach(__th: pthread_t) c_int;
pub extern fn pthread_self() pthread_t;
pub extern fn pthread_equal(__thread1: pthread_t, __thread2: pthread_t) c_int;
pub extern fn pthread_attr_init(__attr: [*c]pthread_attr_t) c_int;
pub extern fn pthread_attr_destroy(__attr: [*c]pthread_attr_t) c_int;
pub extern fn pthread_attr_getdetachstate(__attr: [*c]const pthread_attr_t, __detachstate: [*c]c_int) c_int;
pub extern fn pthread_attr_setdetachstate(__attr: [*c]pthread_attr_t, __detachstate: c_int) c_int;
pub extern fn pthread_attr_getguardsize(__attr: [*c]const pthread_attr_t, __guardsize: [*c]usize) c_int;
pub extern fn pthread_attr_setguardsize(__attr: [*c]pthread_attr_t, __guardsize: usize) c_int;
pub extern fn pthread_attr_getschedparam(noalias __attr: [*c]const pthread_attr_t, noalias __param: [*c]struct_sched_param) c_int;
pub extern fn pthread_attr_setschedparam(noalias __attr: [*c]pthread_attr_t, noalias __param: [*c]const struct_sched_param) c_int;
pub extern fn pthread_attr_getschedpolicy(noalias __attr: [*c]const pthread_attr_t, noalias __policy: [*c]c_int) c_int;
pub extern fn pthread_attr_setschedpolicy(__attr: [*c]pthread_attr_t, __policy: c_int) c_int;
pub extern fn pthread_attr_getinheritsched(noalias __attr: [*c]const pthread_attr_t, noalias __inherit: [*c]c_int) c_int;
pub extern fn pthread_attr_setinheritsched(__attr: [*c]pthread_attr_t, __inherit: c_int) c_int;
pub extern fn pthread_attr_getscope(noalias __attr: [*c]const pthread_attr_t, noalias __scope: [*c]c_int) c_int;
pub extern fn pthread_attr_setscope(__attr: [*c]pthread_attr_t, __scope: c_int) c_int;
pub extern fn pthread_attr_getstackaddr(noalias __attr: [*c]const pthread_attr_t, noalias __stackaddr: [*c]?*anyopaque) c_int;
pub extern fn pthread_attr_setstackaddr(__attr: [*c]pthread_attr_t, __stackaddr: ?*anyopaque) c_int;
pub extern fn pthread_attr_getstacksize(noalias __attr: [*c]const pthread_attr_t, noalias __stacksize: [*c]usize) c_int;
pub extern fn pthread_attr_setstacksize(__attr: [*c]pthread_attr_t, __stacksize: usize) c_int;
pub extern fn pthread_attr_getstack(noalias __attr: [*c]const pthread_attr_t, noalias __stackaddr: [*c]?*anyopaque, noalias __stacksize: [*c]usize) c_int;
pub extern fn pthread_attr_setstack(__attr: [*c]pthread_attr_t, __stackaddr: ?*anyopaque, __stacksize: usize) c_int;
pub extern fn pthread_setschedparam(__target_thread: pthread_t, __policy: c_int, __param: [*c]const struct_sched_param) c_int;
pub extern fn pthread_getschedparam(__target_thread: pthread_t, noalias __policy: [*c]c_int, noalias __param: [*c]struct_sched_param) c_int;
pub extern fn pthread_setschedprio(__target_thread: pthread_t, __prio: c_int) c_int;
pub extern fn pthread_once(__once_control: [*c]pthread_once_t, __init_routine: ?*const fn () callconv(.c) void) c_int;
pub extern fn pthread_setcancelstate(__state: c_int, __oldstate: [*c]c_int) c_int;
pub extern fn pthread_setcanceltype(__type: c_int, __oldtype: [*c]c_int) c_int;
pub extern fn pthread_cancel(__th: pthread_t) c_int;
pub extern fn pthread_testcancel() void;
pub const struct___cancel_jmp_buf_tag = extern struct {
    __cancel_jmp_buf: __jmp_buf = @import("std").mem.zeroes(__jmp_buf),
    __mask_was_saved: c_int = @import("std").mem.zeroes(c_int),
};
pub const __pthread_unwind_buf_t = extern struct {
    __cancel_jmp_buf: [1]struct___cancel_jmp_buf_tag = @import("std").mem.zeroes([1]struct___cancel_jmp_buf_tag),
    __pad: [4]?*anyopaque = @import("std").mem.zeroes([4]?*anyopaque),
};
pub const struct___pthread_cleanup_frame = extern struct {
    __cancel_routine: ?*const fn (?*anyopaque) callconv(.c) void = @import("std").mem.zeroes(?*const fn (?*anyopaque) callconv(.c) void),
    __cancel_arg: ?*anyopaque = @import("std").mem.zeroes(?*anyopaque),
    __do_it: c_int = @import("std").mem.zeroes(c_int),
    __cancel_type: c_int = @import("std").mem.zeroes(c_int),
};
pub extern fn __pthread_register_cancel(__buf: [*c]__pthread_unwind_buf_t) void;
pub extern fn __pthread_unregister_cancel(__buf: [*c]__pthread_unwind_buf_t) void;
pub extern fn __pthread_unwind_next(__buf: [*c]__pthread_unwind_buf_t) noreturn;
pub extern fn __sigsetjmp(__env: [*c]struct___jmp_buf_tag, __savemask: c_int) c_int;
pub extern fn pthread_mutex_init(__mutex: [*c]pthread_mutex_t, __mutexattr: [*c]const pthread_mutexattr_t) c_int;
pub extern fn pthread_mutex_destroy(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_trylock(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_lock(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_timedlock(noalias __mutex: [*c]pthread_mutex_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_mutex_unlock(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutex_getprioceiling(noalias __mutex: [*c]const pthread_mutex_t, noalias __prioceiling: [*c]c_int) c_int;
pub extern fn pthread_mutex_setprioceiling(noalias __mutex: [*c]pthread_mutex_t, __prioceiling: c_int, noalias __old_ceiling: [*c]c_int) c_int;
pub extern fn pthread_mutex_consistent(__mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_mutexattr_init(__attr: [*c]pthread_mutexattr_t) c_int;
pub extern fn pthread_mutexattr_destroy(__attr: [*c]pthread_mutexattr_t) c_int;
pub extern fn pthread_mutexattr_getpshared(noalias __attr: [*c]const pthread_mutexattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setpshared(__attr: [*c]pthread_mutexattr_t, __pshared: c_int) c_int;
pub extern fn pthread_mutexattr_gettype(noalias __attr: [*c]const pthread_mutexattr_t, noalias __kind: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_settype(__attr: [*c]pthread_mutexattr_t, __kind: c_int) c_int;
pub extern fn pthread_mutexattr_getprotocol(noalias __attr: [*c]const pthread_mutexattr_t, noalias __protocol: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setprotocol(__attr: [*c]pthread_mutexattr_t, __protocol: c_int) c_int;
pub extern fn pthread_mutexattr_getprioceiling(noalias __attr: [*c]const pthread_mutexattr_t, noalias __prioceiling: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setprioceiling(__attr: [*c]pthread_mutexattr_t, __prioceiling: c_int) c_int;
pub extern fn pthread_mutexattr_getrobust(__attr: [*c]const pthread_mutexattr_t, __robustness: [*c]c_int) c_int;
pub extern fn pthread_mutexattr_setrobust(__attr: [*c]pthread_mutexattr_t, __robustness: c_int) c_int;
pub extern fn pthread_rwlock_init(noalias __rwlock: [*c]pthread_rwlock_t, noalias __attr: [*c]const pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlock_destroy(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_rdlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_tryrdlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_timedrdlock(noalias __rwlock: [*c]pthread_rwlock_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_rwlock_wrlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_trywrlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlock_timedwrlock(noalias __rwlock: [*c]pthread_rwlock_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_rwlock_unlock(__rwlock: [*c]pthread_rwlock_t) c_int;
pub extern fn pthread_rwlockattr_init(__attr: [*c]pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlockattr_destroy(__attr: [*c]pthread_rwlockattr_t) c_int;
pub extern fn pthread_rwlockattr_getpshared(noalias __attr: [*c]const pthread_rwlockattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_rwlockattr_setpshared(__attr: [*c]pthread_rwlockattr_t, __pshared: c_int) c_int;
pub extern fn pthread_rwlockattr_getkind_np(noalias __attr: [*c]const pthread_rwlockattr_t, noalias __pref: [*c]c_int) c_int;
pub extern fn pthread_rwlockattr_setkind_np(__attr: [*c]pthread_rwlockattr_t, __pref: c_int) c_int;
pub extern fn pthread_cond_init(noalias __cond: [*c]pthread_cond_t, noalias __cond_attr: [*c]const pthread_condattr_t) c_int;
pub extern fn pthread_cond_destroy(__cond: [*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_signal(__cond: [*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_broadcast(__cond: [*c]pthread_cond_t) c_int;
pub extern fn pthread_cond_wait(noalias __cond: [*c]pthread_cond_t, noalias __mutex: [*c]pthread_mutex_t) c_int;
pub extern fn pthread_cond_timedwait(noalias __cond: [*c]pthread_cond_t, noalias __mutex: [*c]pthread_mutex_t, noalias __abstime: [*c]const struct_timespec) c_int;
pub extern fn pthread_condattr_init(__attr: [*c]pthread_condattr_t) c_int;
pub extern fn pthread_condattr_destroy(__attr: [*c]pthread_condattr_t) c_int;
pub extern fn pthread_condattr_getpshared(noalias __attr: [*c]const pthread_condattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_condattr_setpshared(__attr: [*c]pthread_condattr_t, __pshared: c_int) c_int;
pub extern fn pthread_condattr_getclock(noalias __attr: [*c]const pthread_condattr_t, noalias __clock_id: [*c]__clockid_t) c_int;
pub extern fn pthread_condattr_setclock(__attr: [*c]pthread_condattr_t, __clock_id: __clockid_t) c_int;
pub extern fn pthread_spin_init(__lock: [*c]volatile pthread_spinlock_t, __pshared: c_int) c_int;
pub extern fn pthread_spin_destroy(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_spin_lock(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_spin_trylock(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_spin_unlock(__lock: [*c]volatile pthread_spinlock_t) c_int;
pub extern fn pthread_barrier_init(noalias __barrier: [*c]pthread_barrier_t, noalias __attr: [*c]const pthread_barrierattr_t, __count: c_uint) c_int;
pub extern fn pthread_barrier_destroy(__barrier: [*c]pthread_barrier_t) c_int;
pub extern fn pthread_barrier_wait(__barrier: [*c]pthread_barrier_t) c_int;
pub extern fn pthread_barrierattr_init(__attr: [*c]pthread_barrierattr_t) c_int;
pub extern fn pthread_barrierattr_destroy(__attr: [*c]pthread_barrierattr_t) c_int;
pub extern fn pthread_barrierattr_getpshared(noalias __attr: [*c]const pthread_barrierattr_t, noalias __pshared: [*c]c_int) c_int;
pub extern fn pthread_barrierattr_setpshared(__attr: [*c]pthread_barrierattr_t, __pshared: c_int) c_int;
pub extern fn pthread_key_create(__key: [*c]pthread_key_t, __destr_function: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn pthread_key_delete(__key: pthread_key_t) c_int;
pub extern fn pthread_getspecific(__key: pthread_key_t) ?*anyopaque;
pub extern fn pthread_setspecific(__key: pthread_key_t, __pointer: ?*const anyopaque) c_int;
pub extern fn pthread_getcpuclockid(__thread_id: pthread_t, __clock_id: [*c]__clockid_t) c_int;
pub extern fn pthread_atfork(__prepare: ?*const fn () callconv(.c) void, __parent: ?*const fn () callconv(.c) void, __child: ?*const fn () callconv(.c) void) c_int;
pub const CRYPTO_ONCE = pthread_once_t;
pub const CRYPTO_THREAD_LOCAL = pthread_key_t;
pub const CRYPTO_THREAD_ID = pthread_t;
pub extern fn CRYPTO_THREAD_run_once(once: [*c]CRYPTO_ONCE, init: ?*const fn () callconv(.c) void) c_int;
pub extern fn CRYPTO_THREAD_init_local(key: [*c]CRYPTO_THREAD_LOCAL, cleanup: ?*const fn (?*anyopaque) callconv(.c) void) c_int;
pub extern fn CRYPTO_THREAD_get_local(key: [*c]CRYPTO_THREAD_LOCAL) ?*anyopaque;
pub extern fn CRYPTO_THREAD_set_local(key: [*c]CRYPTO_THREAD_LOCAL, val: ?*anyopaque) c_int;
pub extern fn CRYPTO_THREAD_cleanup_local(key: [*c]CRYPTO_THREAD_LOCAL) c_int;
pub extern fn CRYPTO_THREAD_get_current_id() CRYPTO_THREAD_ID;
pub extern fn CRYPTO_THREAD_compare_id(a: CRYPTO_THREAD_ID, b: CRYPTO_THREAD_ID) c_int;
pub extern fn OSSL_LIB_CTX_new() ?*OSSL_LIB_CTX;
pub extern fn OSSL_LIB_CTX_new_from_dispatch(handle: ?*const OSSL_CORE_HANDLE, in: [*c]const OSSL_DISPATCH) ?*OSSL_LIB_CTX;
pub extern fn OSSL_LIB_CTX_new_child(handle: ?*const OSSL_CORE_HANDLE, in: [*c]const OSSL_DISPATCH) ?*OSSL_LIB_CTX;
pub extern fn OSSL_LIB_CTX_load_config(ctx: ?*OSSL_LIB_CTX, config_file: [*c]const u8) c_int;
pub extern fn OSSL_LIB_CTX_free(?*OSSL_LIB_CTX) void;
pub extern fn OSSL_LIB_CTX_get0_global_default() ?*OSSL_LIB_CTX;
pub extern fn OSSL_LIB_CTX_set0_default(libctx: ?*OSSL_LIB_CTX) ?*OSSL_LIB_CTX;
pub const union_bio_addr_st = opaque {};
pub const BIO_ADDR = union_bio_addr_st;
pub const struct_bio_addrinfo_st = opaque {};
pub const BIO_ADDRINFO = struct_bio_addrinfo_st;
pub extern fn BIO_get_new_index() c_int;
pub extern fn BIO_set_flags(b: ?*BIO, flags: c_int) void;
pub extern fn BIO_test_flags(b: ?*const BIO, flags: c_int) c_int;
pub extern fn BIO_clear_flags(b: ?*BIO, flags: c_int) void;
pub const BIO_callback_fn = ?*const fn (?*BIO, c_int, [*c]const u8, c_int, c_long, c_long) callconv(.c) c_long;
pub extern fn BIO_get_callback(b: ?*const BIO) BIO_callback_fn;
pub extern fn BIO_set_callback(b: ?*BIO, callback: BIO_callback_fn) void;
pub extern fn BIO_debug_callback(bio: ?*BIO, cmd: c_int, argp: [*c]const u8, argi: c_int, argl: c_long, ret: c_long) c_long;
pub const BIO_callback_fn_ex = ?*const fn (?*BIO, c_int, [*c]const u8, usize, c_int, c_long, c_int, [*c]usize) callconv(.c) c_long;
pub extern fn BIO_get_callback_ex(b: ?*const BIO) BIO_callback_fn_ex;
pub extern fn BIO_set_callback_ex(b: ?*BIO, callback: BIO_callback_fn_ex) void;
pub extern fn BIO_debug_callback_ex(bio: ?*BIO, oper: c_int, argp: [*c]const u8, len: usize, argi: c_int, argl: c_long, ret: c_int, processed: [*c]usize) c_long;
pub extern fn BIO_get_callback_arg(b: ?*const BIO) [*c]u8;
pub extern fn BIO_set_callback_arg(b: ?*BIO, arg: [*c]u8) void;
pub const struct_bio_method_st = opaque {};
pub const BIO_METHOD = struct_bio_method_st;
pub extern fn BIO_method_name(b: ?*const BIO) [*c]const u8;
pub extern fn BIO_method_type(b: ?*const BIO) c_int;
pub const BIO_info_cb = fn (?*BIO, c_int, c_int) callconv(.c) c_int;
pub const bio_info_cb = BIO_info_cb;
pub const struct_stack_st_BIO = opaque {};
pub const sk_BIO_compfunc = ?*const fn ([*c]const ?*const BIO, [*c]const ?*const BIO) callconv(.c) c_int;
pub const sk_BIO_freefunc = ?*const fn (?*BIO) callconv(.c) void;
pub const sk_BIO_copyfunc = ?*const fn (?*const BIO) callconv(.c) ?*BIO;
pub fn ossl_check_BIO_type(arg_ptr: ?*BIO) callconv(.c) ?*BIO {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_BIO_sk_type(arg_sk: ?*const struct_stack_st_BIO) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_BIO_sk_type(arg_sk: ?*struct_stack_st_BIO) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_BIO_compfunc_type(arg_cmp: sk_BIO_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_BIO_copyfunc_type(arg_cpy: sk_BIO_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_BIO_freefunc_type(arg_fr: sk_BIO_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const asn1_ps_func = fn (?*BIO, [*c][*c]u8, [*c]c_int, ?*anyopaque) callconv(.c) c_int;
pub const BIO_dgram_sctp_notification_handler_fn = ?*const fn (?*BIO, ?*anyopaque, ?*anyopaque) callconv(.c) void;
pub extern fn BIO_ctrl_pending(b: ?*BIO) usize;
pub extern fn BIO_ctrl_wpending(b: ?*BIO) usize;
pub extern fn BIO_ctrl_get_write_guarantee(b: ?*BIO) usize;
pub extern fn BIO_ctrl_get_read_request(b: ?*BIO) usize;
pub extern fn BIO_ctrl_reset_read_request(b: ?*BIO) c_int;
pub extern fn BIO_set_ex_data(bio: ?*BIO, idx: c_int, data: ?*anyopaque) c_int;
pub extern fn BIO_get_ex_data(bio: ?*const BIO, idx: c_int) ?*anyopaque;
pub extern fn BIO_number_read(bio: ?*BIO) u64;
pub extern fn BIO_number_written(bio: ?*BIO) u64;
pub extern fn BIO_asn1_set_prefix(b: ?*BIO, prefix: ?*const asn1_ps_func, prefix_free: ?*const asn1_ps_func) c_int;
pub extern fn BIO_asn1_get_prefix(b: ?*BIO, pprefix: [*c]?*const asn1_ps_func, pprefix_free: [*c]?*const asn1_ps_func) c_int;
pub extern fn BIO_asn1_set_suffix(b: ?*BIO, suffix: ?*const asn1_ps_func, suffix_free: ?*const asn1_ps_func) c_int;
pub extern fn BIO_asn1_get_suffix(b: ?*BIO, psuffix: [*c]?*const asn1_ps_func, psuffix_free: [*c]?*const asn1_ps_func) c_int;
pub extern fn BIO_s_file() ?*const BIO_METHOD;
pub extern fn BIO_new_file(filename: [*c]const u8, mode: [*c]const u8) ?*BIO;
pub extern fn BIO_new_from_core_bio(libctx: ?*OSSL_LIB_CTX, corebio: ?*OSSL_CORE_BIO) ?*BIO;
pub extern fn BIO_new_fp(stream: [*c]FILE, close_flag: c_int) ?*BIO;
pub extern fn BIO_new_ex(libctx: ?*OSSL_LIB_CTX, method: ?*const BIO_METHOD) ?*BIO;
pub extern fn BIO_new(@"type": ?*const BIO_METHOD) ?*BIO;
pub extern fn BIO_free(a: ?*BIO) c_int;
pub extern fn BIO_set_data(a: ?*BIO, ptr: ?*anyopaque) void;
pub extern fn BIO_get_data(a: ?*BIO) ?*anyopaque;
pub extern fn BIO_set_init(a: ?*BIO, init: c_int) void;
pub extern fn BIO_get_init(a: ?*BIO) c_int;
pub extern fn BIO_set_shutdown(a: ?*BIO, shut: c_int) void;
pub extern fn BIO_get_shutdown(a: ?*BIO) c_int;
pub extern fn BIO_vfree(a: ?*BIO) void;
pub extern fn BIO_up_ref(a: ?*BIO) c_int;
pub extern fn BIO_read(b: ?*BIO, data: ?*anyopaque, dlen: c_int) c_int;
pub extern fn BIO_read_ex(b: ?*BIO, data: ?*anyopaque, dlen: usize, readbytes: [*c]usize) c_int;
pub extern fn BIO_gets(bp: ?*BIO, buf: [*c]u8, size: c_int) c_int;
pub extern fn BIO_get_line(bio: ?*BIO, buf: [*c]u8, size: c_int) c_int;
pub extern fn BIO_write(b: ?*BIO, data: ?*const anyopaque, dlen: c_int) c_int;
pub extern fn BIO_write_ex(b: ?*BIO, data: ?*const anyopaque, dlen: usize, written: [*c]usize) c_int;
pub extern fn BIO_puts(bp: ?*BIO, buf: [*c]const u8) c_int;
pub extern fn BIO_indent(b: ?*BIO, indent: c_int, max: c_int) c_int;
pub extern fn BIO_ctrl(bp: ?*BIO, cmd: c_int, larg: c_long, parg: ?*anyopaque) c_long;
pub extern fn BIO_callback_ctrl(b: ?*BIO, cmd: c_int, fp: ?*const BIO_info_cb) c_long;
pub extern fn BIO_ptr_ctrl(bp: ?*BIO, cmd: c_int, larg: c_long) ?*anyopaque;
pub extern fn BIO_int_ctrl(bp: ?*BIO, cmd: c_int, larg: c_long, iarg: c_int) c_long;
pub extern fn BIO_push(b: ?*BIO, append: ?*BIO) ?*BIO;
pub extern fn BIO_pop(b: ?*BIO) ?*BIO;
pub extern fn BIO_free_all(a: ?*BIO) void;
pub extern fn BIO_find_type(b: ?*BIO, bio_type: c_int) ?*BIO;
pub extern fn BIO_next(b: ?*BIO) ?*BIO;
pub extern fn BIO_set_next(b: ?*BIO, next: ?*BIO) void;
pub extern fn BIO_get_retry_BIO(bio: ?*BIO, reason: [*c]c_int) ?*BIO;
pub extern fn BIO_get_retry_reason(bio: ?*BIO) c_int;
pub extern fn BIO_set_retry_reason(bio: ?*BIO, reason: c_int) void;
pub extern fn BIO_dup_chain(in: ?*BIO) ?*BIO;
pub extern fn BIO_nread0(bio: ?*BIO, buf: [*c][*c]u8) c_int;
pub extern fn BIO_nread(bio: ?*BIO, buf: [*c][*c]u8, num: c_int) c_int;
pub extern fn BIO_nwrite0(bio: ?*BIO, buf: [*c][*c]u8) c_int;
pub extern fn BIO_nwrite(bio: ?*BIO, buf: [*c][*c]u8, num: c_int) c_int;
pub extern fn BIO_s_mem() ?*const BIO_METHOD;
pub extern fn BIO_s_secmem() ?*const BIO_METHOD;
pub extern fn BIO_new_mem_buf(buf: ?*const anyopaque, len: c_int) ?*BIO;
pub extern fn BIO_s_socket() ?*const BIO_METHOD;
pub extern fn BIO_s_connect() ?*const BIO_METHOD;
pub extern fn BIO_s_accept() ?*const BIO_METHOD;
pub extern fn BIO_s_fd() ?*const BIO_METHOD;
pub extern fn BIO_s_log() ?*const BIO_METHOD;
pub extern fn BIO_s_bio() ?*const BIO_METHOD;
pub extern fn BIO_s_null() ?*const BIO_METHOD;
pub extern fn BIO_f_null() ?*const BIO_METHOD;
pub extern fn BIO_f_buffer() ?*const BIO_METHOD;
pub extern fn BIO_f_readbuffer() ?*const BIO_METHOD;
pub extern fn BIO_f_linebuffer() ?*const BIO_METHOD;
pub extern fn BIO_f_nbio_test() ?*const BIO_METHOD;
pub extern fn BIO_f_prefix() ?*const BIO_METHOD;
pub extern fn BIO_s_core() ?*const BIO_METHOD;
pub extern fn BIO_s_datagram() ?*const BIO_METHOD;
pub extern fn BIO_dgram_non_fatal_error(@"error": c_int) c_int;
pub extern fn BIO_new_dgram(fd: c_int, close_flag: c_int) ?*BIO;
pub extern fn BIO_sock_should_retry(i: c_int) c_int;
pub extern fn BIO_sock_non_fatal_error(@"error": c_int) c_int;
pub extern fn BIO_socket_wait(fd: c_int, for_read: c_int, max_time: time_t) c_int;
pub extern fn BIO_wait(bio: ?*BIO, max_time: time_t, nap_milliseconds: c_uint) c_int;
pub extern fn BIO_do_connect_retry(bio: ?*BIO, timeout: c_int, nap_milliseconds: c_int) c_int;
pub extern fn BIO_fd_should_retry(i: c_int) c_int;
pub extern fn BIO_fd_non_fatal_error(@"error": c_int) c_int;
pub extern fn BIO_dump_cb(cb: ?*const fn (?*const anyopaque, usize, ?*anyopaque) callconv(.c) c_int, u: ?*anyopaque, s: ?*const anyopaque, len: c_int) c_int;
pub extern fn BIO_dump_indent_cb(cb: ?*const fn (?*const anyopaque, usize, ?*anyopaque) callconv(.c) c_int, u: ?*anyopaque, s: ?*const anyopaque, len: c_int, indent: c_int) c_int;
pub extern fn BIO_dump(b: ?*BIO, bytes: ?*const anyopaque, len: c_int) c_int;
pub extern fn BIO_dump_indent(b: ?*BIO, bytes: ?*const anyopaque, len: c_int, indent: c_int) c_int;
pub extern fn BIO_dump_fp(fp: [*c]FILE, s: ?*const anyopaque, len: c_int) c_int;
pub extern fn BIO_dump_indent_fp(fp: [*c]FILE, s: ?*const anyopaque, len: c_int, indent: c_int) c_int;
pub extern fn BIO_hex_string(out: ?*BIO, indent: c_int, width: c_int, data: ?*const anyopaque, datalen: c_int) c_int;
pub extern fn BIO_ADDR_new() ?*BIO_ADDR;
pub extern fn BIO_ADDR_rawmake(ap: ?*BIO_ADDR, family: c_int, where: ?*const anyopaque, wherelen: usize, port: c_ushort) c_int;
pub extern fn BIO_ADDR_free(?*BIO_ADDR) void;
pub extern fn BIO_ADDR_clear(ap: ?*BIO_ADDR) void;
pub extern fn BIO_ADDR_family(ap: ?*const BIO_ADDR) c_int;
pub extern fn BIO_ADDR_rawaddress(ap: ?*const BIO_ADDR, p: ?*anyopaque, l: [*c]usize) c_int;
pub extern fn BIO_ADDR_rawport(ap: ?*const BIO_ADDR) c_ushort;
pub extern fn BIO_ADDR_hostname_string(ap: ?*const BIO_ADDR, numeric: c_int) [*c]u8;
pub extern fn BIO_ADDR_service_string(ap: ?*const BIO_ADDR, numeric: c_int) [*c]u8;
pub extern fn BIO_ADDR_path_string(ap: ?*const BIO_ADDR) [*c]u8;
pub extern fn BIO_ADDRINFO_next(bai: ?*const BIO_ADDRINFO) ?*const BIO_ADDRINFO;
pub extern fn BIO_ADDRINFO_family(bai: ?*const BIO_ADDRINFO) c_int;
pub extern fn BIO_ADDRINFO_socktype(bai: ?*const BIO_ADDRINFO) c_int;
pub extern fn BIO_ADDRINFO_protocol(bai: ?*const BIO_ADDRINFO) c_int;
pub extern fn BIO_ADDRINFO_address(bai: ?*const BIO_ADDRINFO) ?*const BIO_ADDR;
pub extern fn BIO_ADDRINFO_free(bai: ?*BIO_ADDRINFO) void;
pub const BIO_PARSE_PRIO_HOST: c_int = 0;
pub const BIO_PARSE_PRIO_SERV: c_int = 1;
pub const enum_BIO_hostserv_priorities = c_uint;
pub extern fn BIO_parse_hostserv(hostserv: [*c]const u8, host: [*c][*c]u8, service: [*c][*c]u8, hostserv_prio: enum_BIO_hostserv_priorities) c_int;
pub const BIO_LOOKUP_CLIENT: c_int = 0;
pub const BIO_LOOKUP_SERVER: c_int = 1;
pub const enum_BIO_lookup_type = c_uint;
pub extern fn BIO_lookup(host: [*c]const u8, service: [*c]const u8, lookup_type: enum_BIO_lookup_type, family: c_int, socktype: c_int, res: [*c]?*BIO_ADDRINFO) c_int;
pub extern fn BIO_lookup_ex(host: [*c]const u8, service: [*c]const u8, lookup_type: c_int, family: c_int, socktype: c_int, protocol: c_int, res: [*c]?*BIO_ADDRINFO) c_int;
pub extern fn BIO_sock_error(sock: c_int) c_int;
pub extern fn BIO_socket_ioctl(fd: c_int, @"type": c_long, arg: ?*anyopaque) c_int;
pub extern fn BIO_socket_nbio(fd: c_int, mode: c_int) c_int;
pub extern fn BIO_sock_init() c_int;
pub extern fn BIO_set_tcp_ndelay(sock: c_int, turn_on: c_int) c_int;
pub const struct_hostent = opaque {};
pub extern fn BIO_gethostbyname(name: [*c]const u8) ?*struct_hostent;
pub extern fn BIO_get_port(str: [*c]const u8, port_ptr: [*c]c_ushort) c_int;
pub extern fn BIO_get_host_ip(str: [*c]const u8, ip: [*c]u8) c_int;
pub extern fn BIO_get_accept_socket(host_port: [*c]u8, mode: c_int) c_int;
pub extern fn BIO_accept(sock: c_int, ip_port: [*c][*c]u8) c_int;
pub const union_BIO_sock_info_u = extern union {
    addr: ?*BIO_ADDR,
};
pub const BIO_SOCK_INFO_ADDRESS: c_int = 0;
pub const enum_BIO_sock_info_type = c_uint;
pub extern fn BIO_sock_info(sock: c_int, @"type": enum_BIO_sock_info_type, info: [*c]union_BIO_sock_info_u) c_int;
pub extern fn BIO_socket(domain: c_int, socktype: c_int, protocol: c_int, options: c_int) c_int;
pub extern fn BIO_connect(sock: c_int, addr: ?*const BIO_ADDR, options: c_int) c_int;
pub extern fn BIO_bind(sock: c_int, addr: ?*const BIO_ADDR, options: c_int) c_int;
pub extern fn BIO_listen(sock: c_int, addr: ?*const BIO_ADDR, options: c_int) c_int;
pub extern fn BIO_accept_ex(accept_sock: c_int, addr: ?*BIO_ADDR, options: c_int) c_int;
pub extern fn BIO_closesocket(sock: c_int) c_int;
pub extern fn BIO_new_socket(sock: c_int, close_flag: c_int) ?*BIO;
pub extern fn BIO_new_connect(host_port: [*c]const u8) ?*BIO;
pub extern fn BIO_new_accept(host_port: [*c]const u8) ?*BIO;
pub extern fn BIO_new_fd(fd: c_int, close_flag: c_int) ?*BIO;
pub extern fn BIO_new_bio_pair(bio1: [*c]?*BIO, writebuf1: usize, bio2: [*c]?*BIO, writebuf2: usize) c_int;
pub extern fn BIO_copy_next_retry(b: ?*BIO) void;
pub extern fn BIO_printf(bio: ?*BIO, format: [*c]const u8, ...) c_int;
pub extern fn BIO_vprintf(bio: ?*BIO, format: [*c]const u8, args: [*c]struct___va_list_tag_2) c_int;
pub extern fn BIO_snprintf(buf: [*c]u8, n: usize, format: [*c]const u8, ...) c_int;
pub extern fn BIO_vsnprintf(buf: [*c]u8, n: usize, format: [*c]const u8, args: [*c]struct___va_list_tag_2) c_int;
pub extern fn BIO_meth_new(@"type": c_int, name: [*c]const u8) ?*BIO_METHOD;
pub extern fn BIO_meth_free(biom: ?*BIO_METHOD) void;
pub extern fn BIO_meth_get_write(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, [*c]const u8, c_int) callconv(.c) c_int;
pub extern fn BIO_meth_get_write_ex(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, [*c]const u8, usize, [*c]usize) callconv(.c) c_int;
pub extern fn BIO_meth_set_write(biom: ?*BIO_METHOD, write: ?*const fn (?*BIO, [*c]const u8, c_int) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_set_write_ex(biom: ?*BIO_METHOD, bwrite: ?*const fn (?*BIO, [*c]const u8, usize, [*c]usize) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_get_read(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, [*c]u8, c_int) callconv(.c) c_int;
pub extern fn BIO_meth_get_read_ex(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, [*c]u8, usize, [*c]usize) callconv(.c) c_int;
pub extern fn BIO_meth_set_read(biom: ?*BIO_METHOD, read: ?*const fn (?*BIO, [*c]u8, c_int) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_set_read_ex(biom: ?*BIO_METHOD, bread: ?*const fn (?*BIO, [*c]u8, usize, [*c]usize) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_get_puts(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, [*c]const u8) callconv(.c) c_int;
pub extern fn BIO_meth_set_puts(biom: ?*BIO_METHOD, puts: ?*const fn (?*BIO, [*c]const u8) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_get_gets(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, [*c]u8, c_int) callconv(.c) c_int;
pub extern fn BIO_meth_set_gets(biom: ?*BIO_METHOD, ossl_gets: ?*const fn (?*BIO, [*c]u8, c_int) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_get_ctrl(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, c_int, c_long, ?*anyopaque) callconv(.c) c_long;
pub extern fn BIO_meth_set_ctrl(biom: ?*BIO_METHOD, ctrl: ?*const fn (?*BIO, c_int, c_long, ?*anyopaque) callconv(.c) c_long) c_int;
pub extern fn BIO_meth_get_create(bion: ?*const BIO_METHOD) ?*const fn (?*BIO) callconv(.c) c_int;
pub extern fn BIO_meth_set_create(biom: ?*BIO_METHOD, create: ?*const fn (?*BIO) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_get_destroy(biom: ?*const BIO_METHOD) ?*const fn (?*BIO) callconv(.c) c_int;
pub extern fn BIO_meth_set_destroy(biom: ?*BIO_METHOD, destroy: ?*const fn (?*BIO) callconv(.c) c_int) c_int;
pub extern fn BIO_meth_get_callback_ctrl(biom: ?*const BIO_METHOD) ?*const fn (?*BIO, c_int, ?*const BIO_info_cb) callconv(.c) c_long;
pub extern fn BIO_meth_set_callback_ctrl(biom: ?*BIO_METHOD, callback_ctrl: ?*const fn (?*BIO, c_int, ?*const BIO_info_cb) callconv(.c) c_long) c_int;
pub extern fn BN_set_flags(b: ?*BIGNUM, n: c_int) void;
pub extern fn BN_get_flags(b: ?*const BIGNUM, n: c_int) c_int;
pub extern fn BN_with_flags(dest: ?*BIGNUM, b: ?*const BIGNUM, flags: c_int) void;
pub extern fn BN_GENCB_call(cb: ?*BN_GENCB, a: c_int, b: c_int) c_int;
pub extern fn BN_GENCB_new() ?*BN_GENCB;
pub extern fn BN_GENCB_free(cb: ?*BN_GENCB) void;
pub extern fn BN_GENCB_set_old(gencb: ?*BN_GENCB, callback: ?*const fn (c_int, c_int, ?*anyopaque) callconv(.c) void, cb_arg: ?*anyopaque) void;
pub extern fn BN_GENCB_set(gencb: ?*BN_GENCB, callback: ?*const fn (c_int, c_int, ?*BN_GENCB) callconv(.c) c_int, cb_arg: ?*anyopaque) void;
pub extern fn BN_GENCB_get_arg(cb: ?*BN_GENCB) ?*anyopaque;
pub extern fn BN_abs_is_word(a: ?*const BIGNUM, w: c_ulong) c_int;
pub extern fn BN_is_zero(a: ?*const BIGNUM) c_int;
pub extern fn BN_is_one(a: ?*const BIGNUM) c_int;
pub extern fn BN_is_word(a: ?*const BIGNUM, w: c_ulong) c_int;
pub extern fn BN_is_odd(a: ?*const BIGNUM) c_int;
pub extern fn BN_zero_ex(a: ?*BIGNUM) void;
pub extern fn BN_value_one() ?*const BIGNUM;
pub extern fn BN_options() [*c]u8;
pub extern fn BN_CTX_new_ex(ctx: ?*OSSL_LIB_CTX) ?*BN_CTX;
pub extern fn BN_CTX_new() ?*BN_CTX;
pub extern fn BN_CTX_secure_new_ex(ctx: ?*OSSL_LIB_CTX) ?*BN_CTX;
pub extern fn BN_CTX_secure_new() ?*BN_CTX;
pub extern fn BN_CTX_free(c: ?*BN_CTX) void;
pub extern fn BN_CTX_start(ctx: ?*BN_CTX) void;
pub extern fn BN_CTX_get(ctx: ?*BN_CTX) ?*BIGNUM;
pub extern fn BN_CTX_end(ctx: ?*BN_CTX) void;
pub extern fn BN_rand_ex(rnd: ?*BIGNUM, bits: c_int, top: c_int, bottom: c_int, strength: c_uint, ctx: ?*BN_CTX) c_int;
pub extern fn BN_rand(rnd: ?*BIGNUM, bits: c_int, top: c_int, bottom: c_int) c_int;
pub extern fn BN_priv_rand_ex(rnd: ?*BIGNUM, bits: c_int, top: c_int, bottom: c_int, strength: c_uint, ctx: ?*BN_CTX) c_int;
pub extern fn BN_priv_rand(rnd: ?*BIGNUM, bits: c_int, top: c_int, bottom: c_int) c_int;
pub extern fn BN_rand_range_ex(r: ?*BIGNUM, range: ?*const BIGNUM, strength: c_uint, ctx: ?*BN_CTX) c_int;
pub extern fn BN_rand_range(rnd: ?*BIGNUM, range: ?*const BIGNUM) c_int;
pub extern fn BN_priv_rand_range_ex(r: ?*BIGNUM, range: ?*const BIGNUM, strength: c_uint, ctx: ?*BN_CTX) c_int;
pub extern fn BN_priv_rand_range(rnd: ?*BIGNUM, range: ?*const BIGNUM) c_int;
pub extern fn BN_pseudo_rand(rnd: ?*BIGNUM, bits: c_int, top: c_int, bottom: c_int) c_int;
pub extern fn BN_pseudo_rand_range(rnd: ?*BIGNUM, range: ?*const BIGNUM) c_int;
pub extern fn BN_num_bits(a: ?*const BIGNUM) c_int;
pub extern fn BN_num_bits_word(l: c_ulong) c_int;
pub extern fn BN_security_bits(L: c_int, N: c_int) c_int;
pub extern fn BN_new() ?*BIGNUM;
pub extern fn BN_secure_new() ?*BIGNUM;
pub extern fn BN_clear_free(a: ?*BIGNUM) void;
pub extern fn BN_copy(a: ?*BIGNUM, b: ?*const BIGNUM) ?*BIGNUM;
pub extern fn BN_swap(a: ?*BIGNUM, b: ?*BIGNUM) void;
pub extern fn BN_bin2bn(s: [*c]const u8, len: c_int, ret: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_bn2bin(a: ?*const BIGNUM, to: [*c]u8) c_int;
pub extern fn BN_bn2binpad(a: ?*const BIGNUM, to: [*c]u8, tolen: c_int) c_int;
pub extern fn BN_lebin2bn(s: [*c]const u8, len: c_int, ret: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_bn2lebinpad(a: ?*const BIGNUM, to: [*c]u8, tolen: c_int) c_int;
pub extern fn BN_native2bn(s: [*c]const u8, len: c_int, ret: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_bn2nativepad(a: ?*const BIGNUM, to: [*c]u8, tolen: c_int) c_int;
pub extern fn BN_mpi2bn(s: [*c]const u8, len: c_int, ret: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_bn2mpi(a: ?*const BIGNUM, to: [*c]u8) c_int;
pub extern fn BN_sub(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM) c_int;
pub extern fn BN_usub(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM) c_int;
pub extern fn BN_uadd(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM) c_int;
pub extern fn BN_add(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM) c_int;
pub extern fn BN_mul(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_sqr(r: ?*BIGNUM, a: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_set_negative(b: ?*BIGNUM, n: c_int) void;
pub extern fn BN_is_negative(b: ?*const BIGNUM) c_int;
pub extern fn BN_div(dv: ?*BIGNUM, rem: ?*BIGNUM, m: ?*const BIGNUM, d: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_nnmod(r: ?*BIGNUM, m: ?*const BIGNUM, d: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_add(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_add_quick(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, m: ?*const BIGNUM) c_int;
pub extern fn BN_mod_sub(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_sub_quick(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, m: ?*const BIGNUM) c_int;
pub extern fn BN_mod_mul(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_sqr(r: ?*BIGNUM, a: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_lshift1(r: ?*BIGNUM, a: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_lshift1_quick(r: ?*BIGNUM, a: ?*const BIGNUM, m: ?*const BIGNUM) c_int;
pub extern fn BN_mod_lshift(r: ?*BIGNUM, a: ?*const BIGNUM, n: c_int, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_lshift_quick(r: ?*BIGNUM, a: ?*const BIGNUM, n: c_int, m: ?*const BIGNUM) c_int;
pub extern fn BN_mod_word(a: ?*const BIGNUM, w: c_ulong) c_ulong;
pub extern fn BN_div_word(a: ?*BIGNUM, w: c_ulong) c_ulong;
pub extern fn BN_mul_word(a: ?*BIGNUM, w: c_ulong) c_int;
pub extern fn BN_add_word(a: ?*BIGNUM, w: c_ulong) c_int;
pub extern fn BN_sub_word(a: ?*BIGNUM, w: c_ulong) c_int;
pub extern fn BN_set_word(a: ?*BIGNUM, w: c_ulong) c_int;
pub extern fn BN_get_word(a: ?*const BIGNUM) c_ulong;
pub extern fn BN_cmp(a: ?*const BIGNUM, b: ?*const BIGNUM) c_int;
pub extern fn BN_free(a: ?*BIGNUM) void;
pub extern fn BN_is_bit_set(a: ?*const BIGNUM, n: c_int) c_int;
pub extern fn BN_lshift(r: ?*BIGNUM, a: ?*const BIGNUM, n: c_int) c_int;
pub extern fn BN_lshift1(r: ?*BIGNUM, a: ?*const BIGNUM) c_int;
pub extern fn BN_exp(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_exp(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_exp_mont(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX, m_ctx: ?*BN_MONT_CTX) c_int;
pub extern fn BN_mod_exp_mont_consttime(rr: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX, in_mont: ?*BN_MONT_CTX) c_int;
pub extern fn BN_mod_exp_mont_word(r: ?*BIGNUM, a: c_ulong, p: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX, m_ctx: ?*BN_MONT_CTX) c_int;
pub extern fn BN_mod_exp2_mont(r: ?*BIGNUM, a1: ?*const BIGNUM, p1: ?*const BIGNUM, a2: ?*const BIGNUM, p2: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX, m_ctx: ?*BN_MONT_CTX) c_int;
pub extern fn BN_mod_exp_simple(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_exp_mont_consttime_x2(rr1: ?*BIGNUM, a1: ?*const BIGNUM, p1: ?*const BIGNUM, m1: ?*const BIGNUM, in_mont1: ?*BN_MONT_CTX, rr2: ?*BIGNUM, a2: ?*const BIGNUM, p2: ?*const BIGNUM, m2: ?*const BIGNUM, in_mont2: ?*BN_MONT_CTX, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mask_bits(a: ?*BIGNUM, n: c_int) c_int;
pub extern fn BN_print_fp(fp: [*c]FILE, a: ?*const BIGNUM) c_int;
pub extern fn BN_print(bio: ?*BIO, a: ?*const BIGNUM) c_int;
pub extern fn BN_reciprocal(r: ?*BIGNUM, m: ?*const BIGNUM, len: c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_rshift(r: ?*BIGNUM, a: ?*const BIGNUM, n: c_int) c_int;
pub extern fn BN_rshift1(r: ?*BIGNUM, a: ?*const BIGNUM) c_int;
pub extern fn BN_clear(a: ?*BIGNUM) void;
pub extern fn BN_dup(a: ?*const BIGNUM) ?*BIGNUM;
pub extern fn BN_ucmp(a: ?*const BIGNUM, b: ?*const BIGNUM) c_int;
pub extern fn BN_set_bit(a: ?*BIGNUM, n: c_int) c_int;
pub extern fn BN_clear_bit(a: ?*BIGNUM, n: c_int) c_int;
pub extern fn BN_bn2hex(a: ?*const BIGNUM) [*c]u8;
pub extern fn BN_bn2dec(a: ?*const BIGNUM) [*c]u8;
pub extern fn BN_hex2bn(a: [*c]?*BIGNUM, str: [*c]const u8) c_int;
pub extern fn BN_dec2bn(a: [*c]?*BIGNUM, str: [*c]const u8) c_int;
pub extern fn BN_asc2bn(a: [*c]?*BIGNUM, str: [*c]const u8) c_int;
pub extern fn BN_gcd(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_kronecker(a: ?*const BIGNUM, b: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_inverse(ret: ?*BIGNUM, a: ?*const BIGNUM, n: ?*const BIGNUM, ctx: ?*BN_CTX) ?*BIGNUM;
pub extern fn BN_mod_sqrt(ret: ?*BIGNUM, a: ?*const BIGNUM, n: ?*const BIGNUM, ctx: ?*BN_CTX) ?*BIGNUM;
pub extern fn BN_consttime_swap(swap: c_ulong, a: ?*BIGNUM, b: ?*BIGNUM, nwords: c_int) void;
pub extern fn BN_generate_prime(ret: ?*BIGNUM, bits: c_int, safe: c_int, add: ?*const BIGNUM, rem: ?*const BIGNUM, callback: ?*const fn (c_int, c_int, ?*anyopaque) callconv(.c) void, cb_arg: ?*anyopaque) ?*BIGNUM;
pub extern fn BN_is_prime(p: ?*const BIGNUM, nchecks: c_int, callback: ?*const fn (c_int, c_int, ?*anyopaque) callconv(.c) void, ctx: ?*BN_CTX, cb_arg: ?*anyopaque) c_int;
pub extern fn BN_is_prime_fasttest(p: ?*const BIGNUM, nchecks: c_int, callback: ?*const fn (c_int, c_int, ?*anyopaque) callconv(.c) void, ctx: ?*BN_CTX, cb_arg: ?*anyopaque, do_trial_division: c_int) c_int;
pub extern fn BN_is_prime_ex(p: ?*const BIGNUM, nchecks: c_int, ctx: ?*BN_CTX, cb: ?*BN_GENCB) c_int;
pub extern fn BN_is_prime_fasttest_ex(p: ?*const BIGNUM, nchecks: c_int, ctx: ?*BN_CTX, do_trial_division: c_int, cb: ?*BN_GENCB) c_int;
pub extern fn BN_generate_prime_ex2(ret: ?*BIGNUM, bits: c_int, safe: c_int, add: ?*const BIGNUM, rem: ?*const BIGNUM, cb: ?*BN_GENCB, ctx: ?*BN_CTX) c_int;
pub extern fn BN_generate_prime_ex(ret: ?*BIGNUM, bits: c_int, safe: c_int, add: ?*const BIGNUM, rem: ?*const BIGNUM, cb: ?*BN_GENCB) c_int;
pub extern fn BN_check_prime(p: ?*const BIGNUM, ctx: ?*BN_CTX, cb: ?*BN_GENCB) c_int;
pub extern fn BN_X931_generate_Xpq(Xp: ?*BIGNUM, Xq: ?*BIGNUM, nbits: c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_X931_derive_prime_ex(p: ?*BIGNUM, p1: ?*BIGNUM, p2: ?*BIGNUM, Xp: ?*const BIGNUM, Xp1: ?*const BIGNUM, Xp2: ?*const BIGNUM, e: ?*const BIGNUM, ctx: ?*BN_CTX, cb: ?*BN_GENCB) c_int;
pub extern fn BN_X931_generate_prime_ex(p: ?*BIGNUM, p1: ?*BIGNUM, p2: ?*BIGNUM, Xp1: ?*BIGNUM, Xp2: ?*BIGNUM, Xp: ?*const BIGNUM, e: ?*const BIGNUM, ctx: ?*BN_CTX, cb: ?*BN_GENCB) c_int;
pub extern fn BN_MONT_CTX_new() ?*BN_MONT_CTX;
pub extern fn BN_mod_mul_montgomery(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, mont: ?*BN_MONT_CTX, ctx: ?*BN_CTX) c_int;
pub extern fn BN_to_montgomery(r: ?*BIGNUM, a: ?*const BIGNUM, mont: ?*BN_MONT_CTX, ctx: ?*BN_CTX) c_int;
pub extern fn BN_from_montgomery(r: ?*BIGNUM, a: ?*const BIGNUM, mont: ?*BN_MONT_CTX, ctx: ?*BN_CTX) c_int;
pub extern fn BN_MONT_CTX_free(mont: ?*BN_MONT_CTX) void;
pub extern fn BN_MONT_CTX_set(mont: ?*BN_MONT_CTX, mod: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_MONT_CTX_copy(to: ?*BN_MONT_CTX, from: ?*BN_MONT_CTX) ?*BN_MONT_CTX;
pub extern fn BN_MONT_CTX_set_locked(pmont: [*c]?*BN_MONT_CTX, lock: ?*CRYPTO_RWLOCK, mod: ?*const BIGNUM, ctx: ?*BN_CTX) ?*BN_MONT_CTX;
pub extern fn BN_BLINDING_new(A: ?*const BIGNUM, Ai: ?*const BIGNUM, mod: ?*BIGNUM) ?*BN_BLINDING;
pub extern fn BN_BLINDING_free(b: ?*BN_BLINDING) void;
pub extern fn BN_BLINDING_update(b: ?*BN_BLINDING, ctx: ?*BN_CTX) c_int;
pub extern fn BN_BLINDING_convert(n: ?*BIGNUM, b: ?*BN_BLINDING, ctx: ?*BN_CTX) c_int;
pub extern fn BN_BLINDING_invert(n: ?*BIGNUM, b: ?*BN_BLINDING, ctx: ?*BN_CTX) c_int;
pub extern fn BN_BLINDING_convert_ex(n: ?*BIGNUM, r: ?*BIGNUM, b: ?*BN_BLINDING, ?*BN_CTX) c_int;
pub extern fn BN_BLINDING_invert_ex(n: ?*BIGNUM, r: ?*const BIGNUM, b: ?*BN_BLINDING, ?*BN_CTX) c_int;
pub extern fn BN_BLINDING_is_current_thread(b: ?*BN_BLINDING) c_int;
pub extern fn BN_BLINDING_set_current_thread(b: ?*BN_BLINDING) void;
pub extern fn BN_BLINDING_lock(b: ?*BN_BLINDING) c_int;
pub extern fn BN_BLINDING_unlock(b: ?*BN_BLINDING) c_int;
pub extern fn BN_BLINDING_get_flags(?*const BN_BLINDING) c_ulong;
pub extern fn BN_BLINDING_set_flags(?*BN_BLINDING, c_ulong) void;
pub extern fn BN_BLINDING_create_param(b: ?*BN_BLINDING, e: ?*const BIGNUM, m: ?*BIGNUM, ctx: ?*BN_CTX, bn_mod_exp: ?*const fn (?*BIGNUM, ?*const BIGNUM, ?*const BIGNUM, ?*const BIGNUM, ?*BN_CTX, ?*BN_MONT_CTX) callconv(.c) c_int, m_ctx: ?*BN_MONT_CTX) ?*BN_BLINDING;
pub extern fn BN_set_params(mul: c_int, high: c_int, low: c_int, mont: c_int) void;
pub extern fn BN_get_params(which: c_int) c_int;
pub extern fn BN_RECP_CTX_new() ?*BN_RECP_CTX;
pub extern fn BN_RECP_CTX_free(recp: ?*BN_RECP_CTX) void;
pub extern fn BN_RECP_CTX_set(recp: ?*BN_RECP_CTX, rdiv: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_mul_reciprocal(r: ?*BIGNUM, x: ?*const BIGNUM, y: ?*const BIGNUM, recp: ?*BN_RECP_CTX, ctx: ?*BN_CTX) c_int;
pub extern fn BN_mod_exp_recp(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, m: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_div_recp(dv: ?*BIGNUM, rem: ?*BIGNUM, m: ?*const BIGNUM, recp: ?*BN_RECP_CTX, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_add(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM) c_int;
pub extern fn BN_GF2m_mod(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM) c_int;
pub extern fn BN_GF2m_mod_mul(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_sqr(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_inv(r: ?*BIGNUM, b: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_div(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_exp(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_sqrt(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_solve_quad(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_arr(r: ?*BIGNUM, a: ?*const BIGNUM, p: [*c]const c_int) c_int;
pub extern fn BN_GF2m_mod_mul_arr(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, p: [*c]const c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_sqr_arr(r: ?*BIGNUM, a: ?*const BIGNUM, p: [*c]const c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_inv_arr(r: ?*BIGNUM, b: ?*const BIGNUM, p: [*c]const c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_div_arr(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, p: [*c]const c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_exp_arr(r: ?*BIGNUM, a: ?*const BIGNUM, b: ?*const BIGNUM, p: [*c]const c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_sqrt_arr(r: ?*BIGNUM, a: ?*const BIGNUM, p: [*c]const c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_mod_solve_quad_arr(r: ?*BIGNUM, a: ?*const BIGNUM, p: [*c]const c_int, ctx: ?*BN_CTX) c_int;
pub extern fn BN_GF2m_poly2arr(a: ?*const BIGNUM, p: [*c]c_int, max: c_int) c_int;
pub extern fn BN_GF2m_arr2poly(p: [*c]const c_int, a: ?*BIGNUM) c_int;
pub extern fn BN_nist_mod_192(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_nist_mod_224(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_nist_mod_256(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_nist_mod_384(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_nist_mod_521(r: ?*BIGNUM, a: ?*const BIGNUM, p: ?*const BIGNUM, ctx: ?*BN_CTX) c_int;
pub extern fn BN_get0_nist_prime_192() ?*const BIGNUM;
pub extern fn BN_get0_nist_prime_224() ?*const BIGNUM;
pub extern fn BN_get0_nist_prime_256() ?*const BIGNUM;
pub extern fn BN_get0_nist_prime_384() ?*const BIGNUM;
pub extern fn BN_get0_nist_prime_521() ?*const BIGNUM;
pub extern fn BN_nist_mod_func(p: ?*const BIGNUM) ?*const fn (?*BIGNUM, ?*const BIGNUM, ?*const BIGNUM, ?*BN_CTX) callconv(.c) c_int;
pub extern fn BN_generate_dsa_nonce(out: ?*BIGNUM, range: ?*const BIGNUM, priv: ?*const BIGNUM, message: [*c]const u8, message_len: usize, ctx: ?*BN_CTX) c_int;
pub extern fn BN_get_rfc2409_prime_768(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_get_rfc2409_prime_1024(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_get_rfc3526_prime_1536(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_get_rfc3526_prime_2048(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_get_rfc3526_prime_3072(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_get_rfc3526_prime_4096(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_get_rfc3526_prime_6144(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_get_rfc3526_prime_8192(bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn BN_bntest_rand(rnd: ?*BIGNUM, bits: c_int, top: c_int, bottom: c_int) c_int;
pub extern fn OSSL_PARAM_locate(p: [*c]OSSL_PARAM, key: [*c]const u8) [*c]OSSL_PARAM;
pub extern fn OSSL_PARAM_locate_const(p: [*c]const OSSL_PARAM, key: [*c]const u8) [*c]const OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_int(key: [*c]const u8, buf: [*c]c_int) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_uint(key: [*c]const u8, buf: [*c]c_uint) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_long(key: [*c]const u8, buf: [*c]c_long) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_ulong(key: [*c]const u8, buf: [*c]c_ulong) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_int32(key: [*c]const u8, buf: [*c]i32) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_uint32(key: [*c]const u8, buf: [*c]u32) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_int64(key: [*c]const u8, buf: [*c]i64) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_uint64(key: [*c]const u8, buf: [*c]u64) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_size_t(key: [*c]const u8, buf: [*c]usize) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_time_t(key: [*c]const u8, buf: [*c]time_t) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_BN(key: [*c]const u8, buf: [*c]u8, bsize: usize) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_double(key: [*c]const u8, buf: [*c]f64) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_utf8_string(key: [*c]const u8, buf: [*c]u8, bsize: usize) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_utf8_ptr(key: [*c]const u8, buf: [*c][*c]u8, bsize: usize) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_octet_string(key: [*c]const u8, buf: ?*anyopaque, bsize: usize) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_octet_ptr(key: [*c]const u8, buf: [*c]?*anyopaque, bsize: usize) OSSL_PARAM;
pub extern fn OSSL_PARAM_construct_end() OSSL_PARAM;
pub extern fn OSSL_PARAM_allocate_from_text(to: [*c]OSSL_PARAM, paramdefs: [*c]const OSSL_PARAM, key: [*c]const u8, value: [*c]const u8, value_n: usize, found: [*c]c_int) c_int;
pub extern fn OSSL_PARAM_get_int(p: [*c]const OSSL_PARAM, val: [*c]c_int) c_int;
pub extern fn OSSL_PARAM_get_uint(p: [*c]const OSSL_PARAM, val: [*c]c_uint) c_int;
pub extern fn OSSL_PARAM_get_long(p: [*c]const OSSL_PARAM, val: [*c]c_long) c_int;
pub extern fn OSSL_PARAM_get_ulong(p: [*c]const OSSL_PARAM, val: [*c]c_ulong) c_int;
pub extern fn OSSL_PARAM_get_int32(p: [*c]const OSSL_PARAM, val: [*c]i32) c_int;
pub extern fn OSSL_PARAM_get_uint32(p: [*c]const OSSL_PARAM, val: [*c]u32) c_int;
pub extern fn OSSL_PARAM_get_int64(p: [*c]const OSSL_PARAM, val: [*c]i64) c_int;
pub extern fn OSSL_PARAM_get_uint64(p: [*c]const OSSL_PARAM, val: [*c]u64) c_int;
pub extern fn OSSL_PARAM_get_size_t(p: [*c]const OSSL_PARAM, val: [*c]usize) c_int;
pub extern fn OSSL_PARAM_get_time_t(p: [*c]const OSSL_PARAM, val: [*c]time_t) c_int;
pub extern fn OSSL_PARAM_set_int(p: [*c]OSSL_PARAM, val: c_int) c_int;
pub extern fn OSSL_PARAM_set_uint(p: [*c]OSSL_PARAM, val: c_uint) c_int;
pub extern fn OSSL_PARAM_set_long(p: [*c]OSSL_PARAM, val: c_long) c_int;
pub extern fn OSSL_PARAM_set_ulong(p: [*c]OSSL_PARAM, val: c_ulong) c_int;
pub extern fn OSSL_PARAM_set_int32(p: [*c]OSSL_PARAM, val: i32) c_int;
pub extern fn OSSL_PARAM_set_uint32(p: [*c]OSSL_PARAM, val: u32) c_int;
pub extern fn OSSL_PARAM_set_int64(p: [*c]OSSL_PARAM, val: i64) c_int;
pub extern fn OSSL_PARAM_set_uint64(p: [*c]OSSL_PARAM, val: u64) c_int;
pub extern fn OSSL_PARAM_set_size_t(p: [*c]OSSL_PARAM, val: usize) c_int;
pub extern fn OSSL_PARAM_set_time_t(p: [*c]OSSL_PARAM, val: time_t) c_int;
pub extern fn OSSL_PARAM_get_double(p: [*c]const OSSL_PARAM, val: [*c]f64) c_int;
pub extern fn OSSL_PARAM_set_double(p: [*c]OSSL_PARAM, val: f64) c_int;
pub extern fn OSSL_PARAM_get_BN(p: [*c]const OSSL_PARAM, val: [*c]?*BIGNUM) c_int;
pub extern fn OSSL_PARAM_set_BN(p: [*c]OSSL_PARAM, val: ?*const BIGNUM) c_int;
pub extern fn OSSL_PARAM_get_utf8_string(p: [*c]const OSSL_PARAM, val: [*c][*c]u8, max_len: usize) c_int;
pub extern fn OSSL_PARAM_set_utf8_string(p: [*c]OSSL_PARAM, val: [*c]const u8) c_int;
pub extern fn OSSL_PARAM_get_octet_string(p: [*c]const OSSL_PARAM, val: [*c]?*anyopaque, max_len: usize, used_len: [*c]usize) c_int;
pub extern fn OSSL_PARAM_set_octet_string(p: [*c]OSSL_PARAM, val: ?*const anyopaque, len: usize) c_int;
pub extern fn OSSL_PARAM_get_utf8_ptr(p: [*c]const OSSL_PARAM, val: [*c][*c]const u8) c_int;
pub extern fn OSSL_PARAM_set_utf8_ptr(p: [*c]OSSL_PARAM, val: [*c]const u8) c_int;
pub extern fn OSSL_PARAM_get_octet_ptr(p: [*c]const OSSL_PARAM, val: [*c]?*const anyopaque, used_len: [*c]usize) c_int;
pub extern fn OSSL_PARAM_set_octet_ptr(p: [*c]OSSL_PARAM, val: ?*const anyopaque, used_len: usize) c_int;
pub extern fn OSSL_PARAM_get_utf8_string_ptr(p: [*c]const OSSL_PARAM, val: [*c][*c]const u8) c_int;
pub extern fn OSSL_PARAM_get_octet_string_ptr(p: [*c]const OSSL_PARAM, val: [*c]?*const anyopaque, used_len: [*c]usize) c_int;
pub extern fn OSSL_PARAM_modified(p: [*c]const OSSL_PARAM) c_int;
pub extern fn OSSL_PARAM_set_all_unmodified(p: [*c]OSSL_PARAM) void;
pub extern fn OSSL_PARAM_dup(p: [*c]const OSSL_PARAM) [*c]OSSL_PARAM;
pub extern fn OSSL_PARAM_merge(p1: [*c]const OSSL_PARAM, p2: [*c]const OSSL_PARAM) [*c]OSSL_PARAM;
pub extern fn OSSL_PARAM_free(p: [*c]OSSL_PARAM) void;
pub const struct_stack_st_X509_ALGOR = opaque {};
pub const sk_X509_ALGOR_compfunc = ?*const fn ([*c]const ?*const X509_ALGOR, [*c]const ?*const X509_ALGOR) callconv(.c) c_int;
pub const sk_X509_ALGOR_freefunc = ?*const fn (?*X509_ALGOR) callconv(.c) void;
pub const sk_X509_ALGOR_copyfunc = ?*const fn (?*const X509_ALGOR) callconv(.c) ?*X509_ALGOR;
pub fn ossl_check_X509_ALGOR_type(arg_ptr: ?*X509_ALGOR) callconv(.c) ?*X509_ALGOR {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_X509_ALGOR_sk_type(arg_sk: ?*const struct_stack_st_X509_ALGOR) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_X509_ALGOR_sk_type(arg_sk: ?*struct_stack_st_X509_ALGOR) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_X509_ALGOR_compfunc_type(arg_cmp: sk_X509_ALGOR_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_X509_ALGOR_copyfunc_type(arg_cpy: sk_X509_ALGOR_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_X509_ALGOR_freefunc_type(arg_fr: sk_X509_ALGOR_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const struct_ASN1_ENCODING_st = extern struct {
    enc: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    len: c_long = @import("std").mem.zeroes(c_long),
    modified: c_int = @import("std").mem.zeroes(c_int),
};
pub const ASN1_ENCODING = struct_ASN1_ENCODING_st;
pub const struct_stack_st_ASN1_STRING_TABLE = opaque {};
pub const sk_ASN1_STRING_TABLE_compfunc = ?*const fn ([*c]const [*c]const ASN1_STRING_TABLE, [*c]const [*c]const ASN1_STRING_TABLE) callconv(.c) c_int;
pub const sk_ASN1_STRING_TABLE_freefunc = ?*const fn ([*c]ASN1_STRING_TABLE) callconv(.c) void;
pub const sk_ASN1_STRING_TABLE_copyfunc = ?*const fn ([*c]const ASN1_STRING_TABLE) callconv(.c) [*c]ASN1_STRING_TABLE;
pub fn ossl_check_ASN1_STRING_TABLE_type(arg_ptr: [*c]ASN1_STRING_TABLE) callconv(.c) [*c]ASN1_STRING_TABLE {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_ASN1_STRING_TABLE_sk_type(arg_sk: ?*const struct_stack_st_ASN1_STRING_TABLE) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_STRING_TABLE_sk_type(arg_sk: ?*struct_stack_st_ASN1_STRING_TABLE) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_STRING_TABLE_compfunc_type(arg_cmp: sk_ASN1_STRING_TABLE_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_ASN1_STRING_TABLE_copyfunc_type(arg_cpy: sk_ASN1_STRING_TABLE_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_ASN1_STRING_TABLE_freefunc_type(arg_fr: sk_ASN1_STRING_TABLE_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const struct_ASN1_TEMPLATE_st = opaque {};
pub const ASN1_TEMPLATE = struct_ASN1_TEMPLATE_st;
pub const struct_ASN1_TLC_st = opaque {};
pub const ASN1_TLC = struct_ASN1_TLC_st;
pub const d2i_of_void = fn ([*c]?*anyopaque, [*c][*c]const u8, c_long) callconv(.c) ?*anyopaque;
pub const i2d_of_void = fn (?*const anyopaque, [*c][*c]u8) callconv(.c) c_int;
pub const ASN1_ITEM_EXP = fn () callconv(.c) ?*const ASN1_ITEM;
pub const struct_stack_st_ASN1_TYPE = opaque {};
pub const sk_ASN1_TYPE_compfunc = ?*const fn ([*c]const [*c]const ASN1_TYPE, [*c]const [*c]const ASN1_TYPE) callconv(.c) c_int;
pub const sk_ASN1_TYPE_freefunc = ?*const fn ([*c]ASN1_TYPE) callconv(.c) void;
pub const sk_ASN1_TYPE_copyfunc = ?*const fn ([*c]const ASN1_TYPE) callconv(.c) [*c]ASN1_TYPE;
pub fn ossl_check_ASN1_TYPE_type(arg_ptr: [*c]ASN1_TYPE) callconv(.c) [*c]ASN1_TYPE {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_ASN1_TYPE_sk_type(arg_sk: ?*const struct_stack_st_ASN1_TYPE) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_TYPE_sk_type(arg_sk: ?*struct_stack_st_ASN1_TYPE) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_TYPE_compfunc_type(arg_cmp: sk_ASN1_TYPE_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_ASN1_TYPE_copyfunc_type(arg_cpy: sk_ASN1_TYPE_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_ASN1_TYPE_freefunc_type(arg_fr: sk_ASN1_TYPE_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub const ASN1_SEQUENCE_ANY = struct_stack_st_ASN1_TYPE;
pub extern fn d2i_ASN1_SEQUENCE_ANY(a: [*c]?*ASN1_SEQUENCE_ANY, in: [*c][*c]const u8, len: c_long) ?*ASN1_SEQUENCE_ANY;
pub extern fn i2d_ASN1_SEQUENCE_ANY(a: ?*const ASN1_SEQUENCE_ANY, out: [*c][*c]u8) c_int;
pub extern fn ASN1_SEQUENCE_ANY_it() ?*const ASN1_ITEM;
pub extern fn d2i_ASN1_SET_ANY(a: [*c]?*ASN1_SEQUENCE_ANY, in: [*c][*c]const u8, len: c_long) ?*ASN1_SEQUENCE_ANY;
pub extern fn i2d_ASN1_SET_ANY(a: ?*const ASN1_SEQUENCE_ANY, out: [*c][*c]u8) c_int;
pub extern fn ASN1_SET_ANY_it() ?*const ASN1_ITEM;
pub const struct_BIT_STRING_BITNAME_st = extern struct {
    bitnum: c_int = @import("std").mem.zeroes(c_int),
    lname: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    sname: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const BIT_STRING_BITNAME = struct_BIT_STRING_BITNAME_st;
pub extern fn ASN1_TYPE_new() [*c]ASN1_TYPE;
pub extern fn ASN1_TYPE_free(a: [*c]ASN1_TYPE) void;
pub extern fn d2i_ASN1_TYPE(a: [*c][*c]ASN1_TYPE, in: [*c][*c]const u8, len: c_long) [*c]ASN1_TYPE;
pub extern fn i2d_ASN1_TYPE(a: [*c]const ASN1_TYPE, out: [*c][*c]u8) c_int;
pub extern fn ASN1_ANY_it() ?*const ASN1_ITEM;
pub extern fn ASN1_TYPE_get(a: [*c]const ASN1_TYPE) c_int;
pub extern fn ASN1_TYPE_set(a: [*c]ASN1_TYPE, @"type": c_int, value: ?*anyopaque) void;
pub extern fn ASN1_TYPE_set1(a: [*c]ASN1_TYPE, @"type": c_int, value: ?*const anyopaque) c_int;
pub extern fn ASN1_TYPE_cmp(a: [*c]const ASN1_TYPE, b: [*c]const ASN1_TYPE) c_int;
pub extern fn ASN1_TYPE_pack_sequence(it: ?*const ASN1_ITEM, s: ?*anyopaque, t: [*c][*c]ASN1_TYPE) [*c]ASN1_TYPE;
pub extern fn ASN1_TYPE_unpack_sequence(it: ?*const ASN1_ITEM, t: [*c]const ASN1_TYPE) ?*anyopaque;
pub const struct_stack_st_ASN1_OBJECT = opaque {};
pub const sk_ASN1_OBJECT_compfunc = ?*const fn ([*c]const ?*const ASN1_OBJECT, [*c]const ?*const ASN1_OBJECT) callconv(.c) c_int;
pub const sk_ASN1_OBJECT_freefunc = ?*const fn (?*ASN1_OBJECT) callconv(.c) void;
pub const sk_ASN1_OBJECT_copyfunc = ?*const fn (?*const ASN1_OBJECT) callconv(.c) ?*ASN1_OBJECT;
pub fn ossl_check_ASN1_OBJECT_type(arg_ptr: ?*ASN1_OBJECT) callconv(.c) ?*ASN1_OBJECT {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_ASN1_OBJECT_sk_type(arg_sk: ?*const struct_stack_st_ASN1_OBJECT) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_OBJECT_sk_type(arg_sk: ?*struct_stack_st_ASN1_OBJECT) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_OBJECT_compfunc_type(arg_cmp: sk_ASN1_OBJECT_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_ASN1_OBJECT_copyfunc_type(arg_cpy: sk_ASN1_OBJECT_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_ASN1_OBJECT_freefunc_type(arg_fr: sk_ASN1_OBJECT_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub extern fn ASN1_OBJECT_new() ?*ASN1_OBJECT;
pub extern fn ASN1_OBJECT_free(a: ?*ASN1_OBJECT) void;
pub extern fn d2i_ASN1_OBJECT(a: [*c]?*ASN1_OBJECT, in: [*c][*c]const u8, len: c_long) ?*ASN1_OBJECT;
pub extern fn i2d_ASN1_OBJECT(a: ?*const ASN1_OBJECT, out: [*c][*c]u8) c_int;
pub extern fn ASN1_OBJECT_it() ?*const ASN1_ITEM;
pub extern fn ASN1_STRING_new() [*c]ASN1_STRING;
pub extern fn ASN1_STRING_free(a: [*c]ASN1_STRING) void;
pub extern fn ASN1_STRING_clear_free(a: [*c]ASN1_STRING) void;
pub extern fn ASN1_STRING_copy(dst: [*c]ASN1_STRING, str: [*c]const ASN1_STRING) c_int;
pub extern fn ASN1_STRING_dup(a: [*c]const ASN1_STRING) [*c]ASN1_STRING;
pub extern fn ASN1_STRING_type_new(@"type": c_int) [*c]ASN1_STRING;
pub extern fn ASN1_STRING_cmp(a: [*c]const ASN1_STRING, b: [*c]const ASN1_STRING) c_int;
pub extern fn ASN1_STRING_set(str: [*c]ASN1_STRING, data: ?*const anyopaque, len: c_int) c_int;
pub extern fn ASN1_STRING_set0(str: [*c]ASN1_STRING, data: ?*anyopaque, len: c_int) void;
pub extern fn ASN1_STRING_length(x: [*c]const ASN1_STRING) c_int;
pub extern fn ASN1_STRING_length_set(x: [*c]ASN1_STRING, n: c_int) void;
pub extern fn ASN1_STRING_type(x: [*c]const ASN1_STRING) c_int;
pub extern fn ASN1_STRING_data(x: [*c]ASN1_STRING) [*c]u8;
pub extern fn ASN1_STRING_get0_data(x: [*c]const ASN1_STRING) [*c]const u8;
pub extern fn ASN1_BIT_STRING_new() [*c]ASN1_BIT_STRING;
pub extern fn ASN1_BIT_STRING_free(a: [*c]ASN1_BIT_STRING) void;
pub extern fn d2i_ASN1_BIT_STRING(a: [*c][*c]ASN1_BIT_STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_BIT_STRING;
pub extern fn i2d_ASN1_BIT_STRING(a: [*c]const ASN1_BIT_STRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_BIT_STRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_BIT_STRING_set(a: [*c]ASN1_BIT_STRING, d: [*c]u8, length: c_int) c_int;
pub extern fn ASN1_BIT_STRING_set_bit(a: [*c]ASN1_BIT_STRING, n: c_int, value: c_int) c_int;
pub extern fn ASN1_BIT_STRING_get_bit(a: [*c]const ASN1_BIT_STRING, n: c_int) c_int;
pub extern fn ASN1_BIT_STRING_check(a: [*c]const ASN1_BIT_STRING, flags: [*c]const u8, flags_len: c_int) c_int;
pub extern fn ASN1_BIT_STRING_name_print(out: ?*BIO, bs: [*c]ASN1_BIT_STRING, tbl: [*c]BIT_STRING_BITNAME, indent: c_int) c_int;
pub extern fn ASN1_BIT_STRING_num_asc(name: [*c]const u8, tbl: [*c]BIT_STRING_BITNAME) c_int;
pub extern fn ASN1_BIT_STRING_set_asc(bs: [*c]ASN1_BIT_STRING, name: [*c]const u8, value: c_int, tbl: [*c]BIT_STRING_BITNAME) c_int;
pub const struct_stack_st_ASN1_INTEGER = opaque {};
pub const sk_ASN1_INTEGER_compfunc = ?*const fn ([*c]const [*c]const ASN1_INTEGER, [*c]const [*c]const ASN1_INTEGER) callconv(.c) c_int;
pub const sk_ASN1_INTEGER_freefunc = ?*const fn ([*c]ASN1_INTEGER) callconv(.c) void;
pub const sk_ASN1_INTEGER_copyfunc = ?*const fn ([*c]const ASN1_INTEGER) callconv(.c) [*c]ASN1_INTEGER;
pub fn ossl_check_ASN1_INTEGER_type(arg_ptr: [*c]ASN1_INTEGER) callconv(.c) [*c]ASN1_INTEGER {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_ASN1_INTEGER_sk_type(arg_sk: ?*const struct_stack_st_ASN1_INTEGER) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_INTEGER_sk_type(arg_sk: ?*struct_stack_st_ASN1_INTEGER) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_INTEGER_compfunc_type(arg_cmp: sk_ASN1_INTEGER_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_ASN1_INTEGER_copyfunc_type(arg_cpy: sk_ASN1_INTEGER_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_ASN1_INTEGER_freefunc_type(arg_fr: sk_ASN1_INTEGER_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub extern fn ASN1_INTEGER_new() [*c]ASN1_INTEGER;
pub extern fn ASN1_INTEGER_free(a: [*c]ASN1_INTEGER) void;
pub extern fn d2i_ASN1_INTEGER(a: [*c][*c]ASN1_INTEGER, in: [*c][*c]const u8, len: c_long) [*c]ASN1_INTEGER;
pub extern fn i2d_ASN1_INTEGER(a: [*c]const ASN1_INTEGER, out: [*c][*c]u8) c_int;
pub extern fn ASN1_INTEGER_it() ?*const ASN1_ITEM;
pub extern fn d2i_ASN1_UINTEGER(a: [*c][*c]ASN1_INTEGER, pp: [*c][*c]const u8, length: c_long) [*c]ASN1_INTEGER;
pub extern fn ASN1_INTEGER_dup(a: [*c]const ASN1_INTEGER) [*c]ASN1_INTEGER;
pub extern fn ASN1_INTEGER_cmp(x: [*c]const ASN1_INTEGER, y: [*c]const ASN1_INTEGER) c_int;
pub extern fn ASN1_ENUMERATED_new() [*c]ASN1_ENUMERATED;
pub extern fn ASN1_ENUMERATED_free(a: [*c]ASN1_ENUMERATED) void;
pub extern fn d2i_ASN1_ENUMERATED(a: [*c][*c]ASN1_ENUMERATED, in: [*c][*c]const u8, len: c_long) [*c]ASN1_ENUMERATED;
pub extern fn i2d_ASN1_ENUMERATED(a: [*c]const ASN1_ENUMERATED, out: [*c][*c]u8) c_int;
pub extern fn ASN1_ENUMERATED_it() ?*const ASN1_ITEM;
pub extern fn ASN1_UTCTIME_check(a: [*c]const ASN1_UTCTIME) c_int;
pub extern fn ASN1_UTCTIME_set(s: [*c]ASN1_UTCTIME, t: time_t) [*c]ASN1_UTCTIME;
pub extern fn ASN1_UTCTIME_adj(s: [*c]ASN1_UTCTIME, t: time_t, offset_day: c_int, offset_sec: c_long) [*c]ASN1_UTCTIME;
pub extern fn ASN1_UTCTIME_set_string(s: [*c]ASN1_UTCTIME, str: [*c]const u8) c_int;
pub extern fn ASN1_UTCTIME_cmp_time_t(s: [*c]const ASN1_UTCTIME, t: time_t) c_int;
pub extern fn ASN1_GENERALIZEDTIME_check(a: [*c]const ASN1_GENERALIZEDTIME) c_int;
pub extern fn ASN1_GENERALIZEDTIME_set(s: [*c]ASN1_GENERALIZEDTIME, t: time_t) [*c]ASN1_GENERALIZEDTIME;
pub extern fn ASN1_GENERALIZEDTIME_adj(s: [*c]ASN1_GENERALIZEDTIME, t: time_t, offset_day: c_int, offset_sec: c_long) [*c]ASN1_GENERALIZEDTIME;
pub extern fn ASN1_GENERALIZEDTIME_set_string(s: [*c]ASN1_GENERALIZEDTIME, str: [*c]const u8) c_int;
pub extern fn ASN1_TIME_diff(pday: [*c]c_int, psec: [*c]c_int, from: [*c]const ASN1_TIME, to: [*c]const ASN1_TIME) c_int;
pub extern fn ASN1_OCTET_STRING_new() [*c]ASN1_OCTET_STRING;
pub extern fn ASN1_OCTET_STRING_free(a: [*c]ASN1_OCTET_STRING) void;
pub extern fn d2i_ASN1_OCTET_STRING(a: [*c][*c]ASN1_OCTET_STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_OCTET_STRING;
pub extern fn i2d_ASN1_OCTET_STRING(a: [*c]const ASN1_OCTET_STRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_OCTET_STRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_OCTET_STRING_dup(a: [*c]const ASN1_OCTET_STRING) [*c]ASN1_OCTET_STRING;
pub extern fn ASN1_OCTET_STRING_cmp(a: [*c]const ASN1_OCTET_STRING, b: [*c]const ASN1_OCTET_STRING) c_int;
pub extern fn ASN1_OCTET_STRING_set(str: [*c]ASN1_OCTET_STRING, data: [*c]const u8, len: c_int) c_int;
pub const struct_stack_st_ASN1_UTF8STRING = opaque {};
pub const sk_ASN1_UTF8STRING_compfunc = ?*const fn ([*c]const [*c]const ASN1_UTF8STRING, [*c]const [*c]const ASN1_UTF8STRING) callconv(.c) c_int;
pub const sk_ASN1_UTF8STRING_freefunc = ?*const fn ([*c]ASN1_UTF8STRING) callconv(.c) void;
pub const sk_ASN1_UTF8STRING_copyfunc = ?*const fn ([*c]const ASN1_UTF8STRING) callconv(.c) [*c]ASN1_UTF8STRING;
pub fn ossl_check_ASN1_UTF8STRING_type(arg_ptr: [*c]ASN1_UTF8STRING) callconv(.c) [*c]ASN1_UTF8STRING {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_ASN1_UTF8STRING_sk_type(arg_sk: ?*const struct_stack_st_ASN1_UTF8STRING) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_UTF8STRING_sk_type(arg_sk: ?*struct_stack_st_ASN1_UTF8STRING) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_UTF8STRING_compfunc_type(arg_cmp: sk_ASN1_UTF8STRING_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_ASN1_UTF8STRING_copyfunc_type(arg_cpy: sk_ASN1_UTF8STRING_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_ASN1_UTF8STRING_freefunc_type(arg_fr: sk_ASN1_UTF8STRING_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub extern fn ASN1_VISIBLESTRING_new() [*c]ASN1_VISIBLESTRING;
pub extern fn ASN1_VISIBLESTRING_free(a: [*c]ASN1_VISIBLESTRING) void;
pub extern fn d2i_ASN1_VISIBLESTRING(a: [*c][*c]ASN1_VISIBLESTRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_VISIBLESTRING;
pub extern fn i2d_ASN1_VISIBLESTRING(a: [*c]const ASN1_VISIBLESTRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_VISIBLESTRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_UNIVERSALSTRING_new() [*c]ASN1_UNIVERSALSTRING;
pub extern fn ASN1_UNIVERSALSTRING_free(a: [*c]ASN1_UNIVERSALSTRING) void;
pub extern fn d2i_ASN1_UNIVERSALSTRING(a: [*c][*c]ASN1_UNIVERSALSTRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_UNIVERSALSTRING;
pub extern fn i2d_ASN1_UNIVERSALSTRING(a: [*c]const ASN1_UNIVERSALSTRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_UNIVERSALSTRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_UTF8STRING_new() [*c]ASN1_UTF8STRING;
pub extern fn ASN1_UTF8STRING_free(a: [*c]ASN1_UTF8STRING) void;
pub extern fn d2i_ASN1_UTF8STRING(a: [*c][*c]ASN1_UTF8STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_UTF8STRING;
pub extern fn i2d_ASN1_UTF8STRING(a: [*c]const ASN1_UTF8STRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_UTF8STRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_NULL_new() [*c]ASN1_NULL;
pub extern fn ASN1_NULL_free(a: [*c]ASN1_NULL) void;
pub extern fn d2i_ASN1_NULL(a: [*c][*c]ASN1_NULL, in: [*c][*c]const u8, len: c_long) [*c]ASN1_NULL;
pub extern fn i2d_ASN1_NULL(a: [*c]const ASN1_NULL, out: [*c][*c]u8) c_int;
pub extern fn ASN1_NULL_it() ?*const ASN1_ITEM;
pub extern fn ASN1_BMPSTRING_new() [*c]ASN1_BMPSTRING;
pub extern fn ASN1_BMPSTRING_free(a: [*c]ASN1_BMPSTRING) void;
pub extern fn d2i_ASN1_BMPSTRING(a: [*c][*c]ASN1_BMPSTRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_BMPSTRING;
pub extern fn i2d_ASN1_BMPSTRING(a: [*c]const ASN1_BMPSTRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_BMPSTRING_it() ?*const ASN1_ITEM;
pub extern fn UTF8_getc(str: [*c]const u8, len: c_int, val: [*c]c_ulong) c_int;
pub extern fn UTF8_putc(str: [*c]u8, len: c_int, value: c_ulong) c_int;
pub const struct_stack_st_ASN1_GENERALSTRING = opaque {};
pub const sk_ASN1_GENERALSTRING_compfunc = ?*const fn ([*c]const [*c]const ASN1_GENERALSTRING, [*c]const [*c]const ASN1_GENERALSTRING) callconv(.c) c_int;
pub const sk_ASN1_GENERALSTRING_freefunc = ?*const fn ([*c]ASN1_GENERALSTRING) callconv(.c) void;
pub const sk_ASN1_GENERALSTRING_copyfunc = ?*const fn ([*c]const ASN1_GENERALSTRING) callconv(.c) [*c]ASN1_GENERALSTRING;
pub fn ossl_check_ASN1_GENERALSTRING_type(arg_ptr: [*c]ASN1_GENERALSTRING) callconv(.c) [*c]ASN1_GENERALSTRING {
    var ptr = arg_ptr;
    _ = &ptr;
    return ptr;
}
pub fn ossl_check_const_ASN1_GENERALSTRING_sk_type(arg_sk: ?*const struct_stack_st_ASN1_GENERALSTRING) callconv(.c) ?*const OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*const OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_GENERALSTRING_sk_type(arg_sk: ?*struct_stack_st_ASN1_GENERALSTRING) callconv(.c) ?*OPENSSL_STACK {
    var sk = arg_sk;
    _ = &sk;
    return @as(?*OPENSSL_STACK, @ptrCast(sk));
}
pub fn ossl_check_ASN1_GENERALSTRING_compfunc_type(arg_cmp: sk_ASN1_GENERALSTRING_compfunc) callconv(.c) OPENSSL_sk_compfunc {
    var cmp = arg_cmp;
    _ = &cmp;
    return @as(OPENSSL_sk_compfunc, @ptrCast(@alignCast(cmp)));
}
pub fn ossl_check_ASN1_GENERALSTRING_copyfunc_type(arg_cpy: sk_ASN1_GENERALSTRING_copyfunc) callconv(.c) OPENSSL_sk_copyfunc {
    var cpy = arg_cpy;
    _ = &cpy;
    return @as(OPENSSL_sk_copyfunc, @ptrCast(@alignCast(cpy)));
}
pub fn ossl_check_ASN1_GENERALSTRING_freefunc_type(arg_fr: sk_ASN1_GENERALSTRING_freefunc) callconv(.c) OPENSSL_sk_freefunc {
    var fr = arg_fr;
    _ = &fr;
    return @as(OPENSSL_sk_freefunc, @ptrCast(@alignCast(fr)));
}
pub extern fn ASN1_PRINTABLE_new() [*c]ASN1_STRING;
pub extern fn ASN1_PRINTABLE_free(a: [*c]ASN1_STRING) void;
pub extern fn d2i_ASN1_PRINTABLE(a: [*c][*c]ASN1_STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_STRING;
pub extern fn i2d_ASN1_PRINTABLE(a: [*c]const ASN1_STRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_PRINTABLE_it() ?*const ASN1_ITEM;
pub extern fn DIRECTORYSTRING_new() [*c]ASN1_STRING;
pub extern fn DIRECTORYSTRING_free(a: [*c]ASN1_STRING) void;
pub extern fn d2i_DIRECTORYSTRING(a: [*c][*c]ASN1_STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_STRING;
pub extern fn i2d_DIRECTORYSTRING(a: [*c]const ASN1_STRING, out: [*c][*c]u8) c_int;
pub extern fn DIRECTORYSTRING_it() ?*const ASN1_ITEM;
pub extern fn DISPLAYTEXT_new() [*c]ASN1_STRING;
pub extern fn DISPLAYTEXT_free(a: [*c]ASN1_STRING) void;
pub extern fn d2i_DISPLAYTEXT(a: [*c][*c]ASN1_STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_STRING;
pub extern fn i2d_DISPLAYTEXT(a: [*c]const ASN1_STRING, out: [*c][*c]u8) c_int;
pub extern fn DISPLAYTEXT_it() ?*const ASN1_ITEM;
pub extern fn ASN1_PRINTABLESTRING_new() [*c]ASN1_PRINTABLESTRING;
pub extern fn ASN1_PRINTABLESTRING_free(a: [*c]ASN1_PRINTABLESTRING) void;
pub extern fn d2i_ASN1_PRINTABLESTRING(a: [*c][*c]ASN1_PRINTABLESTRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_PRINTABLESTRING;
pub extern fn i2d_ASN1_PRINTABLESTRING(a: [*c]const ASN1_PRINTABLESTRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_PRINTABLESTRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_T61STRING_new() [*c]ASN1_T61STRING;
pub extern fn ASN1_T61STRING_free(a: [*c]ASN1_T61STRING) void;
pub extern fn d2i_ASN1_T61STRING(a: [*c][*c]ASN1_T61STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_T61STRING;
pub extern fn i2d_ASN1_T61STRING(a: [*c]const ASN1_T61STRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_T61STRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_IA5STRING_new() [*c]ASN1_IA5STRING;
pub extern fn ASN1_IA5STRING_free(a: [*c]ASN1_IA5STRING) void;
pub extern fn d2i_ASN1_IA5STRING(a: [*c][*c]ASN1_IA5STRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_IA5STRING;
pub extern fn i2d_ASN1_IA5STRING(a: [*c]const ASN1_IA5STRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_IA5STRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_GENERALSTRING_new() [*c]ASN1_GENERALSTRING;
pub extern fn ASN1_GENERALSTRING_free(a: [*c]ASN1_GENERALSTRING) void;
pub extern fn d2i_ASN1_GENERALSTRING(a: [*c][*c]ASN1_GENERALSTRING, in: [*c][*c]const u8, len: c_long) [*c]ASN1_GENERALSTRING;
pub extern fn i2d_ASN1_GENERALSTRING(a: [*c]const ASN1_GENERALSTRING, out: [*c][*c]u8) c_int;
pub extern fn ASN1_GENERALSTRING_it() ?*const ASN1_ITEM;
pub extern fn ASN1_UTCTIME_new() [*c]ASN1_UTCTIME;
pub extern fn ASN1_UTCTIME_free(a: [*c]ASN1_UTCTIME) void;
pub extern fn d2i_ASN1_UTCTIME(a: [*c][*c]ASN1_UTCTIME, in: [*c][*c]const u8, len: c_long) [*c]ASN1_UTCTIME;
pub extern fn i2d_ASN1_UTCTIME(a: [*c]const ASN1_UTCTIME, out: [*c][*c]u8) c_int;
pub extern fn ASN1_UTCTIME_it() ?*const ASN1_ITEM;
pub extern fn ASN1_GENERALIZEDTIME_new() [*c]ASN1_GENERALIZEDTIME;
pub extern fn ASN1_GENERALIZEDTIME_free(a: [*c]ASN1_GENERALIZEDTIME) void;
pub extern fn d2i_ASN1_GENERALIZEDTIME(a: [*c][*c]ASN1_GENERALIZEDTIME, in: [*c][*c]const u8, len: c_long) [*c]ASN1_GENERALIZEDTIME;
pub extern fn i2d_ASN1_GENERALIZEDTIME(a: [*c]const ASN1_GENERALIZEDTIME, out: [*c][*c]u8) c_int;
pub extern fn ASN1_GENERALIZEDTIME_it() ?*const ASN1_ITEM;
pub extern fn ASN1_TIME_new() [*c]ASN1_TIME;
pub extern fn ASN1_TIME_free(a: [*c]ASN1_TIME) void;
pub extern fn d2i_ASN1_TIME(a: [*c][*c]ASN1_TIME, in: [*c][*c]const u8, len: c_long) [*c]ASN1_TIME;
pub extern fn i2d_ASN1_TIME(a: [*c]const ASN1_TIME, out: [*c][*c]u8) c_int;
pub extern fn ASN1_TIME_it() ?*const ASN1_ITEM;
pub extern fn ASN1_TIME_dup(a: [*c]const ASN1_TIME) [*c]ASN1_TIME;
pub extern fn ASN1_UTCTIME_dup(a: [*c]const ASN1_UTCTIME) [*c]ASN1_UTCTIME;
pub extern fn ASN1_GENERALIZEDTIME_dup(a: [*c]const ASN1_GENERALIZEDTIME) [*c]ASN1_GENERALIZEDTIME;
pub extern fn ASN1_OCTET_STRING_NDEF_it() ?*const ASN1_ITEM;
pub extern fn ASN1_TIME_set(s: [*c]ASN1_TIME, t: time_t) [*c]ASN1_TIME;
pub extern fn ASN1_TIME_adj(s: [*c]ASN1_TIME, t: time_t, offset_day: c_int, offset_sec: c_long) [*c]ASN1_TIME;
pub extern fn ASN1_TIME_check(t: [*c]const ASN1_TIME) c_int;
pub extern fn ASN1_TIME_to_generalizedtime(t: [*c]const ASN1_TIME, out: [*c][*c]ASN1_GENERALIZEDTIME) [*c]ASN1_GENERALIZEDTIME;
pub extern fn ASN1_TIME_set_string(s: [*c]ASN1_TIME, str: [*c]const u8) c_int;
pub extern fn ASN1_TIME_set_string_X509(s: [*c]ASN1_TIME, str: [*c]const u8) c_int;
pub extern fn ASN1_TIME_to_tm(s: [*c]const ASN1_TIME, tm: [*c]struct_tm) c_int;
pub extern fn ASN1_TIME_normalize(s: [*c]ASN1_TIME) c_int;
pub extern fn ASN1_TIME_cmp_time_t(s: [*c]const ASN1_TIME, t: time_t) c_int;
pub extern fn ASN1_TIME_compare(a: [*c]const ASN1_TIME, b: [*c]const ASN1_TIME) c_int;
pub extern fn i2a_ASN1_INTEGER(bp: ?*BIO, a: [*c]const ASN1_INTEGER) c_int;
pub extern fn a2i_ASN1_INTEGER(bp: ?*BIO, bs: [*c]ASN1_INTEGER, buf: [*c]u8, size: c_int) c_int;
pub extern fn i2a_ASN1_ENUMERATED(bp: ?*BIO, a: [*c]const ASN1_ENUMERATED) c_int;
pub extern fn a2i_ASN1_ENUMERATED(bp: ?*BIO, bs: [*c]ASN1_ENUMERATED, buf: [*c]u8, size: c_int) c_int;
pub extern fn i2a_ASN1_OBJECT(bp: ?*BIO, a: ?*const ASN1_OBJECT) c_int;
pub extern fn a2i_ASN1_STRING(bp: ?*BIO, bs: [*c]ASN1_STRING, buf: [*c]u8, size: c_int) c_int;
pub extern fn i2a_ASN1_STRING(bp: ?*BIO, a: [*c]const ASN1_STRING, @"type": c_int) c_int;
pub extern fn i2t_ASN1_OBJECT(buf: [*c]u8, buf_len: c_int, a: ?*const ASN1_OBJECT) c_int;
pub extern fn a2d_ASN1_OBJECT(out: [*c]u8, olen: c_int, buf: [*c]const u8, num: c_int) c_int;
pub extern fn ASN1_OBJECT_create(nid: c_int, data: [*c]u8, len: c_int, sn: [*c]const u8, ln: [*c]const u8) ?*ASN1_OBJECT;
pub extern fn ASN1_INTEGER_get_int64(pr: [*c]i64, a: [*c]const ASN1_INTEGER) c_int;
pub extern fn ASN1_INTEGER_set_int64(a: [*c]ASN1_INTEGER, r: i64) c_int;
pub extern fn ASN1_INTEGER_get_uint64(pr: [*c]u64, a: [*c]const ASN1_INTEGER) c_int;
pub extern fn ASN1_INTEGER_set_uint64(a: [*c]ASN1_INTEGER, r: u64) c_int;
pub extern fn ASN1_INTEGER_set(a: [*c]ASN1_INTEGER, v: c_long) c_int;
pub extern fn ASN1_INTEGER_get(a: [*c]const ASN1_INTEGER) c_long;
pub extern fn BN_to_ASN1_INTEGER(bn: ?*const BIGNUM, ai: [*c]ASN1_INTEGER) [*c]ASN1_INTEGER;
pub extern fn ASN1_INTEGER_to_BN(ai: [*c]const ASN1_INTEGER, bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn ASN1_ENUMERATED_get_int64(pr: [*c]i64, a: [*c]const ASN1_ENUMERATED) c_int;
pub extern fn ASN1_ENUMERATED_set_int64(a: [*c]ASN1_ENUMERATED, r: i64) c_int;
pub extern fn ASN1_ENUMERATED_set(a: [*c]ASN1_ENUMERATED, v: c_long) c_int;
pub extern fn ASN1_ENUMERATED_get(a: [*c]const ASN1_ENUMERATED) c_long;
pub extern fn BN_to_ASN1_ENUMERATED(bn: ?*const BIGNUM, ai: [*c]ASN1_ENUMERATED) [*c]ASN1_ENUMERATED;
pub extern fn ASN1_ENUMERATED_to_BN(ai: [*c]const ASN1_ENUMERATED, bn: ?*BIGNUM) ?*BIGNUM;
pub extern fn ASN1_PRINTABLE_type(s: [*c]const u8, max: c_int) c_int;
pub extern fn ASN1_tag2bit(tag: c_int) c_ulong;
pub extern fn ASN1_get_object(pp: [*c][*c]const u8, plength: [*c]c_long, ptag: [*c]c_int, pclass: [*c]c_int, omax: c_long) c_int;
pub extern fn ASN1_check_infinite_end(p: [*c][*c]u8, len: c_long) c_int;
pub extern fn ASN1_const_check_infinite_end(p: [*c][*c]const u8, len: c_long) c_int;
pub extern fn ASN1_put_object(pp: [*c][*c]u8, constructed: c_int, length: c_int, tag: c_int, xclass: c_int) void;
pub extern fn ASN1_put_eoc(pp: [*c][*c]u8) c_int;
pub extern fn ASN1_object_size(constructed: c_int, length: c_int, tag: c_int) c_int;
pub extern fn ASN1_dup(i2d: ?*const i2d_of_void, d2i: ?*const d2i_of_void, x: ?*const anyopaque) ?*anyopaque;
pub extern fn ASN1_item_dup(it: ?*const ASN1_ITEM, x: ?*const anyopaque) ?*anyopaque;
pub extern fn ASN1_item_sign_ex(it: ?*const ASN1_ITEM, algor1: ?*X509_ALGOR, algor2: ?*X509_ALGOR, signature: [*c]ASN1_BIT_STRING, data: ?*const anyopaque, id: [*c]const ASN1_OCTET_STRING, pkey: ?*EVP_PKEY, md: ?*const EVP_MD, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn ASN1_item_verify_ex(it: ?*const ASN1_ITEM, alg: ?*const X509_ALGOR, signature: [*c]const ASN1_BIT_STRING, data: ?*const anyopaque, id: [*c]const ASN1_OCTET_STRING, pkey: ?*EVP_PKEY, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn ASN1_d2i_fp(xnew: ?*const fn () callconv(.c) ?*anyopaque, d2i: ?*const d2i_of_void, in: [*c]FILE, x: [*c]?*anyopaque) ?*anyopaque;
pub extern fn ASN1_item_d2i_fp_ex(it: ?*const ASN1_ITEM, in: [*c]FILE, x: ?*anyopaque, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) ?*anyopaque;
pub extern fn ASN1_item_d2i_fp(it: ?*const ASN1_ITEM, in: [*c]FILE, x: ?*anyopaque) ?*anyopaque;
pub extern fn ASN1_i2d_fp(i2d: ?*const i2d_of_void, out: [*c]FILE, x: ?*const anyopaque) c_int;
pub extern fn ASN1_item_i2d_fp(it: ?*const ASN1_ITEM, out: [*c]FILE, x: ?*const anyopaque) c_int;
pub extern fn ASN1_STRING_print_ex_fp(fp: [*c]FILE, str: [*c]const ASN1_STRING, flags: c_ulong) c_int;
pub extern fn ASN1_STRING_to_UTF8(out: [*c][*c]u8, in: [*c]const ASN1_STRING) c_int;
pub extern fn ASN1_d2i_bio(xnew: ?*const fn () callconv(.c) ?*anyopaque, d2i: ?*const d2i_of_void, in: ?*BIO, x: [*c]?*anyopaque) ?*anyopaque;
pub extern fn ASN1_item_d2i_bio_ex(it: ?*const ASN1_ITEM, in: ?*BIO, pval: ?*anyopaque, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) ?*anyopaque;
pub extern fn ASN1_item_d2i_bio(it: ?*const ASN1_ITEM, in: ?*BIO, pval: ?*anyopaque) ?*anyopaque;
pub extern fn ASN1_i2d_bio(i2d: ?*const i2d_of_void, out: ?*BIO, x: ?*const anyopaque) c_int;
pub extern fn ASN1_item_i2d_bio(it: ?*const ASN1_ITEM, out: ?*BIO, x: ?*const anyopaque) c_int;
pub extern fn ASN1_item_i2d_mem_bio(it: ?*const ASN1_ITEM, val: ?*const ASN1_VALUE) ?*BIO;
pub extern fn ASN1_UTCTIME_print(fp: ?*BIO, a: [*c]const ASN1_UTCTIME) c_int;
pub extern fn ASN1_GENERALIZEDTIME_print(fp: ?*BIO, a: [*c]const ASN1_GENERALIZEDTIME) c_int;
pub extern fn ASN1_TIME_print(bp: ?*BIO, tm: [*c]const ASN1_TIME) c_int;
pub extern fn ASN1_TIME_print_ex(bp: ?*BIO, tm: [*c]const ASN1_TIME, flags: c_ulong) c_int;
pub extern fn ASN1_STRING_print(bp: ?*BIO, v: [*c]const ASN1_STRING) c_int;
pub extern fn ASN1_STRING_print_ex(out: ?*BIO, str: [*c]const ASN1_STRING, flags: c_ulong) c_int;
pub extern fn ASN1_buf_print(bp: ?*BIO, buf: [*c]const u8, buflen: usize, off: c_int) c_int;
pub extern fn ASN1_bn_print(bp: ?*BIO, number: [*c]const u8, num: ?*const BIGNUM, buf: [*c]u8, off: c_int) c_int;
pub extern fn ASN1_parse(bp: ?*BIO, pp: [*c]const u8, len: c_long, indent: c_int) c_int;
pub extern fn ASN1_parse_dump(bp: ?*BIO, pp: [*c]const u8, len: c_long, indent: c_int, dump: c_int) c_int;
pub extern fn ASN1_tag2str(tag: c_int) [*c]const u8;
pub extern fn ASN1_UNIVERSALSTRING_to_string(s: [*c]ASN1_UNIVERSALSTRING) c_int;
pub extern fn ASN1_TYPE_set_octetstring(a: [*c]ASN1_TYPE, data: [*c]u8, len: c_int) c_int;
pub extern fn ASN1_TYPE_get_octetstring(a: [*c]const ASN1_TYPE, data: [*c]u8, max_len: c_int) c_int;
pub extern fn ASN1_TYPE_set_int_octetstring(a: [*c]ASN1_TYPE, num: c_long, data: [*c]u8, len: c_int) c_int;
pub extern fn ASN1_TYPE_get_int_octetstring(a: [*c]const ASN1_TYPE, num: [*c]c_long, data: [*c]u8, max_len: c_int) c_int;
pub extern fn ASN1_item_unpack(oct: [*c]const ASN1_STRING, it: ?*const ASN1_ITEM) ?*anyopaque;
pub extern fn ASN1_item_pack(obj: ?*anyopaque, it: ?*const ASN1_ITEM, oct: [*c][*c]ASN1_OCTET_STRING) [*c]ASN1_STRING;
pub extern fn ASN1_STRING_set_default_mask(mask: c_ulong) void;
pub extern fn ASN1_STRING_set_default_mask_asc(p: [*c]const u8) c_int;
pub extern fn ASN1_STRING_get_default_mask() c_ulong;
pub extern fn ASN1_mbstring_copy(out: [*c][*c]ASN1_STRING, in: [*c]const u8, len: c_int, inform: c_int, mask: c_ulong) c_int;
pub extern fn ASN1_mbstring_ncopy(out: [*c][*c]ASN1_STRING, in: [*c]const u8, len: c_int, inform: c_int, mask: c_ulong, minsize: c_long, maxsize: c_long) c_int;
pub extern fn ASN1_STRING_set_by_NID(out: [*c][*c]ASN1_STRING, in: [*c]const u8, inlen: c_int, inform: c_int, nid: c_int) [*c]ASN1_STRING;
pub extern fn ASN1_STRING_TABLE_get(nid: c_int) [*c]ASN1_STRING_TABLE;
pub extern fn ASN1_STRING_TABLE_add(c_int, c_long, c_long, c_ulong, c_ulong) c_int;
pub extern fn ASN1_STRING_TABLE_cleanup() void;
pub extern fn ASN1_item_new(it: ?*const ASN1_ITEM) ?*ASN1_VALUE;
pub extern fn ASN1_item_new_ex(it: ?*const ASN1_ITEM, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) ?*ASN1_VALUE;
pub extern fn ASN1_item_free(val: ?*ASN1_VALUE, it: ?*const ASN1_ITEM) void;
pub extern fn ASN1_item_d2i_ex(val: [*c]?*ASN1_VALUE, in: [*c][*c]const u8, len: c_long, it: ?*const ASN1_ITEM, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) ?*ASN1_VALUE;
pub extern fn ASN1_item_d2i(val: [*c]?*ASN1_VALUE, in: [*c][*c]const u8, len: c_long, it: ?*const ASN1_ITEM) ?*ASN1_VALUE;
pub extern fn ASN1_item_i2d(val: ?*const ASN1_VALUE, out: [*c][*c]u8, it: ?*const ASN1_ITEM) c_int;
pub extern fn ASN1_item_ndef_i2d(val: ?*const ASN1_VALUE, out: [*c][*c]u8, it: ?*const ASN1_ITEM) c_int;
pub extern fn ASN1_add_oid_module() void;
pub extern fn ASN1_add_stable_module() void;
pub extern fn ASN1_generate_nconf(str: [*c]const u8, nconf: ?*CONF) [*c]ASN1_TYPE;
pub extern fn ASN1_generate_v3(str: [*c]const u8, cnf: ?*X509V3_CTX) [*c]ASN1_TYPE;
pub extern fn ASN1_str2mask(str: [*c]const u8, pmask: [*c]c_ulong) c_int;
pub extern fn ASN1_item_print(out: ?*BIO, ifld: ?*const ASN1_VALUE, indent: c_int, it: ?*const ASN1_ITEM, pctx: ?*const ASN1_PCTX) c_int;
pub extern fn ASN1_PCTX_new() ?*ASN1_PCTX;
pub extern fn ASN1_PCTX_free(p: ?*ASN1_PCTX) void;
pub extern fn ASN1_PCTX_get_flags(p: ?*const ASN1_PCTX) c_ulong;
pub extern fn ASN1_PCTX_set_flags(p: ?*ASN1_PCTX, flags: c_ulong) void;
pub extern fn ASN1_PCTX_get_nm_flags(p: ?*const ASN1_PCTX) c_ulong;
pub extern fn ASN1_PCTX_set_nm_flags(p: ?*ASN1_PCTX, flags: c_ulong) void;
pub extern fn ASN1_PCTX_get_cert_flags(p: ?*const ASN1_PCTX) c_ulong;
pub extern fn ASN1_PCTX_set_cert_flags(p: ?*ASN1_PCTX, flags: c_ulong) void;
pub extern fn ASN1_PCTX_get_oid_flags(p: ?*const ASN1_PCTX) c_ulong;
pub extern fn ASN1_PCTX_set_oid_flags(p: ?*ASN1_PCTX, flags: c_ulong) void;
pub extern fn ASN1_PCTX_get_str_flags(p: ?*const ASN1_PCTX) c_ulong;
pub extern fn ASN1_PCTX_set_str_flags(p: ?*ASN1_PCTX, flags: c_ulong) void;
pub extern fn ASN1_SCTX_new(scan_cb: ?*const fn (?*ASN1_SCTX) callconv(.c) c_int) ?*ASN1_SCTX;
pub extern fn ASN1_SCTX_free(p: ?*ASN1_SCTX) void;
pub extern fn ASN1_SCTX_get_item(p: ?*ASN1_SCTX) ?*const ASN1_ITEM;
pub extern fn ASN1_SCTX_get_template(p: ?*ASN1_SCTX) ?*const ASN1_TEMPLATE;
pub extern fn ASN1_SCTX_get_flags(p: ?*ASN1_SCTX) c_ulong;
pub extern fn ASN1_SCTX_set_app_data(p: ?*ASN1_SCTX, data: ?*anyopaque) void;
pub extern fn ASN1_SCTX_get_app_data(p: ?*ASN1_SCTX) ?*anyopaque;
pub extern fn BIO_f_asn1() ?*const BIO_METHOD;
pub extern fn BIO_new_NDEF(out: ?*BIO, val: ?*ASN1_VALUE, it: ?*const ASN1_ITEM) ?*BIO;
pub extern fn i2d_ASN1_bio_stream(out: ?*BIO, val: ?*ASN1_VALUE, in: ?*BIO, flags: c_int, it: ?*const ASN1_ITEM) c_int;
pub extern fn PEM_write_bio_ASN1_stream(out: ?*BIO, val: ?*ASN1_VALUE, in: ?*BIO, flags: c_int, hdr: [*c]const u8, it: ?*const ASN1_ITEM) c_int;
pub extern fn SMIME_write_ASN1(bio: ?*BIO, val: ?*ASN1_VALUE, data: ?*BIO, flags: c_int, ctype_nid: c_int, econt_nid: c_int, mdalgs: ?*struct_stack_st_X509_ALGOR, it: ?*const ASN1_ITEM) c_int;
pub extern fn SMIME_write_ASN1_ex(bio: ?*BIO, val: ?*ASN1_VALUE, data: ?*BIO, flags: c_int, ctype_nid: c_int, econt_nid: c_int, mdalgs: ?*struct_stack_st_X509_ALGOR, it: ?*const ASN1_ITEM, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn SMIME_read_ASN1(bio: ?*BIO, bcont: [*c]?*BIO, it: ?*const ASN1_ITEM) ?*ASN1_VALUE;
pub extern fn SMIME_read_ASN1_ex(bio: ?*BIO, flags: c_int, bcont: [*c]?*BIO, it: ?*const ASN1_ITEM, x: [*c]?*ASN1_VALUE, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) ?*ASN1_VALUE;
pub extern fn SMIME_crlf_copy(in: ?*BIO, out: ?*BIO, flags: c_int) c_int;
pub extern fn SMIME_text(in: ?*BIO, out: ?*BIO) c_int;
pub extern fn ASN1_ITEM_lookup(name: [*c]const u8) ?*const ASN1_ITEM;
pub extern fn ASN1_ITEM_get(i: usize) ?*const ASN1_ITEM;
pub const struct_obj_name_st = extern struct {
    type: c_int = @import("std").mem.zeroes(c_int),
    alias: c_int = @import("std").mem.zeroes(c_int),
    name: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    data: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
};
pub const OBJ_NAME = struct_obj_name_st;
pub extern fn OBJ_NAME_init() c_int;
pub extern fn OBJ_NAME_new_index(hash_func: ?*const fn ([*c]const u8) callconv(.c) c_ulong, cmp_func: ?*const fn ([*c]const u8, [*c]const u8) callconv(.c) c_int, free_func: ?*const fn ([*c]const u8, c_int, [*c]const u8) callconv(.c) void) c_int;
pub extern fn OBJ_NAME_get(name: [*c]const u8, @"type": c_int) [*c]const u8;
pub extern fn OBJ_NAME_add(name: [*c]const u8, @"type": c_int, data: [*c]const u8) c_int;
pub extern fn OBJ_NAME_remove(name: [*c]const u8, @"type": c_int) c_int;
pub extern fn OBJ_NAME_cleanup(@"type": c_int) void;
pub extern fn OBJ_NAME_do_all(@"type": c_int, @"fn": ?*const fn ([*c]const OBJ_NAME, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn OBJ_NAME_do_all_sorted(@"type": c_int, @"fn": ?*const fn ([*c]const OBJ_NAME, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn OBJ_dup(a: ?*const ASN1_OBJECT) ?*ASN1_OBJECT;
pub extern fn OBJ_nid2obj(n: c_int) ?*ASN1_OBJECT;
pub extern fn OBJ_nid2ln(n: c_int) [*c]const u8;
pub extern fn OBJ_nid2sn(n: c_int) [*c]const u8;
pub extern fn OBJ_obj2nid(o: ?*const ASN1_OBJECT) c_int;
pub extern fn OBJ_txt2obj(s: [*c]const u8, no_name: c_int) ?*ASN1_OBJECT;
pub extern fn OBJ_obj2txt(buf: [*c]u8, buf_len: c_int, a: ?*const ASN1_OBJECT, no_name: c_int) c_int;
pub extern fn OBJ_txt2nid(s: [*c]const u8) c_int;
pub extern fn OBJ_ln2nid(s: [*c]const u8) c_int;
pub extern fn OBJ_sn2nid(s: [*c]const u8) c_int;
pub extern fn OBJ_cmp(a: ?*const ASN1_OBJECT, b: ?*const ASN1_OBJECT) c_int;
pub extern fn OBJ_bsearch_(key: ?*const anyopaque, base: ?*const anyopaque, num: c_int, size: c_int, cmp: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int) ?*const anyopaque;
pub extern fn OBJ_bsearch_ex_(key: ?*const anyopaque, base: ?*const anyopaque, num: c_int, size: c_int, cmp: ?*const fn (?*const anyopaque, ?*const anyopaque) callconv(.c) c_int, flags: c_int) ?*const anyopaque;
pub extern fn OBJ_new_nid(num: c_int) c_int;
pub extern fn OBJ_add_object(obj: ?*const ASN1_OBJECT) c_int;
pub extern fn OBJ_create(oid: [*c]const u8, sn: [*c]const u8, ln: [*c]const u8) c_int;
pub extern fn OBJ_create_objects(in: ?*BIO) c_int;
pub extern fn OBJ_length(obj: ?*const ASN1_OBJECT) usize;
pub extern fn OBJ_get0_data(obj: ?*const ASN1_OBJECT) [*c]const u8;
pub extern fn OBJ_find_sigid_algs(signid: c_int, pdig_nid: [*c]c_int, ppkey_nid: [*c]c_int) c_int;
pub extern fn OBJ_find_sigid_by_algs(psignid: [*c]c_int, dig_nid: c_int, pkey_nid: c_int) c_int;
pub extern fn OBJ_add_sigid(signid: c_int, dig_id: c_int, pkey_id: c_int) c_int;
pub extern fn OBJ_sigid_free() void;
pub extern fn EVP_set_default_properties(libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn EVP_default_properties_is_fips_enabled(libctx: ?*OSSL_LIB_CTX) c_int;
pub extern fn EVP_default_properties_enable_fips(libctx: ?*OSSL_LIB_CTX, enable: c_int) c_int;
pub extern fn EVP_MD_meth_new(md_type: c_int, pkey_type: c_int) ?*EVP_MD;
pub extern fn EVP_MD_meth_dup(md: ?*const EVP_MD) ?*EVP_MD;
pub extern fn EVP_MD_meth_free(md: ?*EVP_MD) void;
pub extern fn EVP_MD_meth_set_input_blocksize(md: ?*EVP_MD, blocksize: c_int) c_int;
pub extern fn EVP_MD_meth_set_result_size(md: ?*EVP_MD, resultsize: c_int) c_int;
pub extern fn EVP_MD_meth_set_app_datasize(md: ?*EVP_MD, datasize: c_int) c_int;
pub extern fn EVP_MD_meth_set_flags(md: ?*EVP_MD, flags: c_ulong) c_int;
pub extern fn EVP_MD_meth_set_init(md: ?*EVP_MD, init: ?*const fn (?*EVP_MD_CTX) callconv(.c) c_int) c_int;
pub extern fn EVP_MD_meth_set_update(md: ?*EVP_MD, update: ?*const fn (?*EVP_MD_CTX, ?*const anyopaque, usize) callconv(.c) c_int) c_int;
pub extern fn EVP_MD_meth_set_final(md: ?*EVP_MD, final: ?*const fn (?*EVP_MD_CTX, [*c]u8) callconv(.c) c_int) c_int;
pub extern fn EVP_MD_meth_set_copy(md: ?*EVP_MD, copy: ?*const fn (?*EVP_MD_CTX, ?*const EVP_MD_CTX) callconv(.c) c_int) c_int;
pub extern fn EVP_MD_meth_set_cleanup(md: ?*EVP_MD, cleanup: ?*const fn (?*EVP_MD_CTX) callconv(.c) c_int) c_int;
pub extern fn EVP_MD_meth_set_ctrl(md: ?*EVP_MD, ctrl: ?*const fn (?*EVP_MD_CTX, c_int, c_int, ?*anyopaque) callconv(.c) c_int) c_int;
pub extern fn EVP_MD_meth_get_input_blocksize(md: ?*const EVP_MD) c_int;
pub extern fn EVP_MD_meth_get_result_size(md: ?*const EVP_MD) c_int;
pub extern fn EVP_MD_meth_get_app_datasize(md: ?*const EVP_MD) c_int;
pub extern fn EVP_MD_meth_get_flags(md: ?*const EVP_MD) c_ulong;
pub extern fn EVP_MD_meth_get_init(md: ?*const EVP_MD) ?*const fn (?*EVP_MD_CTX) callconv(.c) c_int;
pub extern fn EVP_MD_meth_get_update(md: ?*const EVP_MD) ?*const fn (?*EVP_MD_CTX, ?*const anyopaque, usize) callconv(.c) c_int;
pub extern fn EVP_MD_meth_get_final(md: ?*const EVP_MD) ?*const fn (?*EVP_MD_CTX, [*c]u8) callconv(.c) c_int;
pub extern fn EVP_MD_meth_get_copy(md: ?*const EVP_MD) ?*const fn (?*EVP_MD_CTX, ?*const EVP_MD_CTX) callconv(.c) c_int;
pub extern fn EVP_MD_meth_get_cleanup(md: ?*const EVP_MD) ?*const fn (?*EVP_MD_CTX) callconv(.c) c_int;
pub extern fn EVP_MD_meth_get_ctrl(md: ?*const EVP_MD) ?*const fn (?*EVP_MD_CTX, c_int, c_int, ?*anyopaque) callconv(.c) c_int;
pub extern fn EVP_CIPHER_meth_new(cipher_type: c_int, block_size: c_int, key_len: c_int) ?*EVP_CIPHER;
pub extern fn EVP_CIPHER_meth_dup(cipher: ?*const EVP_CIPHER) ?*EVP_CIPHER;
pub extern fn EVP_CIPHER_meth_free(cipher: ?*EVP_CIPHER) void;
pub extern fn EVP_CIPHER_meth_set_iv_length(cipher: ?*EVP_CIPHER, iv_len: c_int) c_int;
pub extern fn EVP_CIPHER_meth_set_flags(cipher: ?*EVP_CIPHER, flags: c_ulong) c_int;
pub extern fn EVP_CIPHER_meth_set_impl_ctx_size(cipher: ?*EVP_CIPHER, ctx_size: c_int) c_int;
pub extern fn EVP_CIPHER_meth_set_init(cipher: ?*EVP_CIPHER, init: ?*const fn (?*EVP_CIPHER_CTX, [*c]const u8, [*c]const u8, c_int) callconv(.c) c_int) c_int;
pub extern fn EVP_CIPHER_meth_set_do_cipher(cipher: ?*EVP_CIPHER, do_cipher: ?*const fn (?*EVP_CIPHER_CTX, [*c]u8, [*c]const u8, usize) callconv(.c) c_int) c_int;
pub extern fn EVP_CIPHER_meth_set_cleanup(cipher: ?*EVP_CIPHER, cleanup: ?*const fn (?*EVP_CIPHER_CTX) callconv(.c) c_int) c_int;
pub extern fn EVP_CIPHER_meth_set_set_asn1_params(cipher: ?*EVP_CIPHER, set_asn1_parameters: ?*const fn (?*EVP_CIPHER_CTX, [*c]ASN1_TYPE) callconv(.c) c_int) c_int;
pub extern fn EVP_CIPHER_meth_set_get_asn1_params(cipher: ?*EVP_CIPHER, get_asn1_parameters: ?*const fn (?*EVP_CIPHER_CTX, [*c]ASN1_TYPE) callconv(.c) c_int) c_int;
pub extern fn EVP_CIPHER_meth_set_ctrl(cipher: ?*EVP_CIPHER, ctrl: ?*const fn (?*EVP_CIPHER_CTX, c_int, c_int, ?*anyopaque) callconv(.c) c_int) c_int;
pub extern fn EVP_CIPHER_meth_get_init(cipher: ?*const EVP_CIPHER) ?*const fn (?*EVP_CIPHER_CTX, [*c]const u8, [*c]const u8, c_int) callconv(.c) c_int;
pub extern fn EVP_CIPHER_meth_get_do_cipher(cipher: ?*const EVP_CIPHER) ?*const fn (?*EVP_CIPHER_CTX, [*c]u8, [*c]const u8, usize) callconv(.c) c_int;
pub extern fn EVP_CIPHER_meth_get_cleanup(cipher: ?*const EVP_CIPHER) ?*const fn (?*EVP_CIPHER_CTX) callconv(.c) c_int;
pub extern fn EVP_CIPHER_meth_get_set_asn1_params(cipher: ?*const EVP_CIPHER) ?*const fn (?*EVP_CIPHER_CTX, [*c]ASN1_TYPE) callconv(.c) c_int;
pub extern fn EVP_CIPHER_meth_get_get_asn1_params(cipher: ?*const EVP_CIPHER) ?*const fn (?*EVP_CIPHER_CTX, [*c]ASN1_TYPE) callconv(.c) c_int;
pub extern fn EVP_CIPHER_meth_get_ctrl(cipher: ?*const EVP_CIPHER) ?*const fn (?*EVP_CIPHER_CTX, c_int, c_int, ?*anyopaque) callconv(.c) c_int;
pub const EVP_CTRL_TLS1_1_MULTIBLOCK_PARAM = extern struct {
    out: [*c]u8 = @import("std").mem.zeroes([*c]u8),
    inp: [*c]const u8 = @import("std").mem.zeroes([*c]const u8),
    len: usize = @import("std").mem.zeroes(usize),
    interleave: c_uint = @import("std").mem.zeroes(c_uint),
};
pub const struct_evp_cipher_info_st = extern struct {
    cipher: ?*const EVP_CIPHER = @import("std").mem.zeroes(?*const EVP_CIPHER),
    iv: [16]u8 = @import("std").mem.zeroes([16]u8),
};
pub const EVP_CIPHER_INFO = struct_evp_cipher_info_st;
pub const EVP_PBE_KEYGEN = fn (?*EVP_CIPHER_CTX, [*c]const u8, c_int, [*c]ASN1_TYPE, ?*const EVP_CIPHER, ?*const EVP_MD, c_int) callconv(.c) c_int;
pub const EVP_PBE_KEYGEN_EX = fn (?*EVP_CIPHER_CTX, [*c]const u8, c_int, [*c]ASN1_TYPE, ?*const EVP_CIPHER, ?*const EVP_MD, c_int, ?*OSSL_LIB_CTX, [*c]const u8) callconv(.c) c_int;
pub extern fn EVP_MD_get_type(md: ?*const EVP_MD) c_int;
pub extern fn EVP_MD_get0_name(md: ?*const EVP_MD) [*c]const u8;
pub extern fn EVP_MD_get0_description(md: ?*const EVP_MD) [*c]const u8;
pub extern fn EVP_MD_is_a(md: ?*const EVP_MD, name: [*c]const u8) c_int;
pub extern fn EVP_MD_names_do_all(md: ?*const EVP_MD, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_MD_get0_provider(md: ?*const EVP_MD) ?*const OSSL_PROVIDER;
pub extern fn EVP_MD_get_pkey_type(md: ?*const EVP_MD) c_int;
pub extern fn EVP_MD_get_size(md: ?*const EVP_MD) c_int;
pub extern fn EVP_MD_get_block_size(md: ?*const EVP_MD) c_int;
pub extern fn EVP_MD_get_flags(md: ?*const EVP_MD) c_ulong;
pub extern fn EVP_MD_CTX_get0_md(ctx: ?*const EVP_MD_CTX) ?*const EVP_MD;
pub extern fn EVP_MD_CTX_get1_md(ctx: ?*EVP_MD_CTX) ?*EVP_MD;
pub extern fn EVP_MD_CTX_md(ctx: ?*const EVP_MD_CTX) ?*const EVP_MD;
pub extern fn EVP_MD_CTX_update_fn(ctx: ?*EVP_MD_CTX) ?*const fn (?*EVP_MD_CTX, ?*const anyopaque, usize) callconv(.c) c_int;
pub extern fn EVP_MD_CTX_set_update_fn(ctx: ?*EVP_MD_CTX, update: ?*const fn (?*EVP_MD_CTX, ?*const anyopaque, usize) callconv(.c) c_int) void;
pub extern fn EVP_MD_CTX_get_pkey_ctx(ctx: ?*const EVP_MD_CTX) ?*EVP_PKEY_CTX;
pub extern fn EVP_MD_CTX_set_pkey_ctx(ctx: ?*EVP_MD_CTX, pctx: ?*EVP_PKEY_CTX) void;
pub extern fn EVP_MD_CTX_get0_md_data(ctx: ?*const EVP_MD_CTX) ?*anyopaque;
pub extern fn EVP_CIPHER_get_nid(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_get0_name(cipher: ?*const EVP_CIPHER) [*c]const u8;
pub extern fn EVP_CIPHER_get0_description(cipher: ?*const EVP_CIPHER) [*c]const u8;
pub extern fn EVP_CIPHER_is_a(cipher: ?*const EVP_CIPHER, name: [*c]const u8) c_int;
pub extern fn EVP_CIPHER_names_do_all(cipher: ?*const EVP_CIPHER, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_CIPHER_get0_provider(cipher: ?*const EVP_CIPHER) ?*const OSSL_PROVIDER;
pub extern fn EVP_CIPHER_get_block_size(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_impl_ctx_size(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_get_key_length(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_get_iv_length(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_get_flags(cipher: ?*const EVP_CIPHER) c_ulong;
pub extern fn EVP_CIPHER_get_mode(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_get_type(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_fetch(ctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_CIPHER;
pub extern fn EVP_CIPHER_up_ref(cipher: ?*EVP_CIPHER) c_int;
pub extern fn EVP_CIPHER_free(cipher: ?*EVP_CIPHER) void;
pub extern fn EVP_CIPHER_CTX_get0_cipher(ctx: ?*const EVP_CIPHER_CTX) ?*const EVP_CIPHER;
pub extern fn EVP_CIPHER_CTX_get1_cipher(ctx: ?*EVP_CIPHER_CTX) ?*EVP_CIPHER;
pub extern fn EVP_CIPHER_CTX_is_encrypting(ctx: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_get_nid(ctx: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_get_block_size(ctx: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_get_key_length(ctx: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_get_iv_length(ctx: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_get_tag_length(ctx: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_cipher(ctx: ?*const EVP_CIPHER_CTX) ?*const EVP_CIPHER;
pub extern fn EVP_CIPHER_CTX_iv(ctx: ?*const EVP_CIPHER_CTX) [*c]const u8;
pub extern fn EVP_CIPHER_CTX_original_iv(ctx: ?*const EVP_CIPHER_CTX) [*c]const u8;
pub extern fn EVP_CIPHER_CTX_iv_noconst(ctx: ?*EVP_CIPHER_CTX) [*c]u8;
pub extern fn EVP_CIPHER_CTX_get_updated_iv(ctx: ?*EVP_CIPHER_CTX, buf: ?*anyopaque, len: usize) c_int;
pub extern fn EVP_CIPHER_CTX_get_original_iv(ctx: ?*EVP_CIPHER_CTX, buf: ?*anyopaque, len: usize) c_int;
pub extern fn EVP_CIPHER_CTX_buf_noconst(ctx: ?*EVP_CIPHER_CTX) [*c]u8;
pub extern fn EVP_CIPHER_CTX_get_num(ctx: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_set_num(ctx: ?*EVP_CIPHER_CTX, num: c_int) c_int;
pub extern fn EVP_CIPHER_CTX_copy(out: ?*EVP_CIPHER_CTX, in: ?*const EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_get_app_data(ctx: ?*const EVP_CIPHER_CTX) ?*anyopaque;
pub extern fn EVP_CIPHER_CTX_set_app_data(ctx: ?*EVP_CIPHER_CTX, data: ?*anyopaque) void;
pub extern fn EVP_CIPHER_CTX_get_cipher_data(ctx: ?*const EVP_CIPHER_CTX) ?*anyopaque;
pub extern fn EVP_CIPHER_CTX_set_cipher_data(ctx: ?*EVP_CIPHER_CTX, cipher_data: ?*anyopaque) ?*anyopaque;
pub extern fn EVP_Cipher(c: ?*EVP_CIPHER_CTX, out: [*c]u8, in: [*c]const u8, inl: c_uint) c_int;
pub extern fn EVP_MD_get_params(digest: ?*const EVP_MD, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_MD_CTX_set_params(ctx: ?*EVP_MD_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_MD_CTX_get_params(ctx: ?*EVP_MD_CTX, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_MD_gettable_params(digest: ?*const EVP_MD) [*c]const OSSL_PARAM;
pub extern fn EVP_MD_settable_ctx_params(md: ?*const EVP_MD) [*c]const OSSL_PARAM;
pub extern fn EVP_MD_gettable_ctx_params(md: ?*const EVP_MD) [*c]const OSSL_PARAM;
pub extern fn EVP_MD_CTX_settable_params(ctx: ?*EVP_MD_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_MD_CTX_gettable_params(ctx: ?*EVP_MD_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_MD_CTX_ctrl(ctx: ?*EVP_MD_CTX, cmd: c_int, p1: c_int, p2: ?*anyopaque) c_int;
pub extern fn EVP_MD_CTX_new() ?*EVP_MD_CTX;
pub extern fn EVP_MD_CTX_reset(ctx: ?*EVP_MD_CTX) c_int;
pub extern fn EVP_MD_CTX_free(ctx: ?*EVP_MD_CTX) void;
pub extern fn EVP_MD_CTX_copy_ex(out: ?*EVP_MD_CTX, in: ?*const EVP_MD_CTX) c_int;
pub extern fn EVP_MD_CTX_set_flags(ctx: ?*EVP_MD_CTX, flags: c_int) void;
pub extern fn EVP_MD_CTX_clear_flags(ctx: ?*EVP_MD_CTX, flags: c_int) void;
pub extern fn EVP_MD_CTX_test_flags(ctx: ?*const EVP_MD_CTX, flags: c_int) c_int;
pub extern fn EVP_DigestInit_ex2(ctx: ?*EVP_MD_CTX, @"type": ?*const EVP_MD, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_DigestInit_ex(ctx: ?*EVP_MD_CTX, @"type": ?*const EVP_MD, impl: ?*ENGINE) c_int;
pub extern fn EVP_DigestUpdate(ctx: ?*EVP_MD_CTX, d: ?*const anyopaque, cnt: usize) c_int;
pub extern fn EVP_DigestFinal_ex(ctx: ?*EVP_MD_CTX, md: [*c]u8, s: [*c]c_uint) c_int;
pub extern fn EVP_Digest(data: ?*const anyopaque, count: usize, md: [*c]u8, size: [*c]c_uint, @"type": ?*const EVP_MD, impl: ?*ENGINE) c_int;
pub extern fn EVP_Q_digest(libctx: ?*OSSL_LIB_CTX, name: [*c]const u8, propq: [*c]const u8, data: ?*const anyopaque, datalen: usize, md: [*c]u8, mdlen: [*c]usize) c_int;
pub extern fn EVP_MD_CTX_copy(out: ?*EVP_MD_CTX, in: ?*const EVP_MD_CTX) c_int;
pub extern fn EVP_DigestInit(ctx: ?*EVP_MD_CTX, @"type": ?*const EVP_MD) c_int;
pub extern fn EVP_DigestFinal(ctx: ?*EVP_MD_CTX, md: [*c]u8, s: [*c]c_uint) c_int;
pub extern fn EVP_DigestFinalXOF(ctx: ?*EVP_MD_CTX, md: [*c]u8, len: usize) c_int;
pub extern fn EVP_MD_fetch(ctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_MD;
pub extern fn EVP_MD_up_ref(md: ?*EVP_MD) c_int;
pub extern fn EVP_MD_free(md: ?*EVP_MD) void;
pub extern fn EVP_read_pw_string(buf: [*c]u8, length: c_int, prompt: [*c]const u8, verify: c_int) c_int;
pub extern fn EVP_read_pw_string_min(buf: [*c]u8, minlen: c_int, maxlen: c_int, prompt: [*c]const u8, verify: c_int) c_int;
pub extern fn EVP_set_pw_prompt(prompt: [*c]const u8) void;
pub extern fn EVP_get_pw_prompt() [*c]u8;
pub extern fn EVP_BytesToKey(@"type": ?*const EVP_CIPHER, md: ?*const EVP_MD, salt: [*c]const u8, data: [*c]const u8, datal: c_int, count: c_int, key: [*c]u8, iv: [*c]u8) c_int;
pub extern fn EVP_CIPHER_CTX_set_flags(ctx: ?*EVP_CIPHER_CTX, flags: c_int) void;
pub extern fn EVP_CIPHER_CTX_clear_flags(ctx: ?*EVP_CIPHER_CTX, flags: c_int) void;
pub extern fn EVP_CIPHER_CTX_test_flags(ctx: ?*const EVP_CIPHER_CTX, flags: c_int) c_int;
pub extern fn EVP_EncryptInit(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, key: [*c]const u8, iv: [*c]const u8) c_int;
pub extern fn EVP_EncryptInit_ex(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, impl: ?*ENGINE, key: [*c]const u8, iv: [*c]const u8) c_int;
pub extern fn EVP_EncryptInit_ex2(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, key: [*c]const u8, iv: [*c]const u8, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_EncryptUpdate(ctx: ?*EVP_CIPHER_CTX, out: [*c]u8, outl: [*c]c_int, in: [*c]const u8, inl: c_int) c_int;
pub extern fn EVP_EncryptFinal_ex(ctx: ?*EVP_CIPHER_CTX, out: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_EncryptFinal(ctx: ?*EVP_CIPHER_CTX, out: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_DecryptInit(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, key: [*c]const u8, iv: [*c]const u8) c_int;
pub extern fn EVP_DecryptInit_ex(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, impl: ?*ENGINE, key: [*c]const u8, iv: [*c]const u8) c_int;
pub extern fn EVP_DecryptInit_ex2(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, key: [*c]const u8, iv: [*c]const u8, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_DecryptUpdate(ctx: ?*EVP_CIPHER_CTX, out: [*c]u8, outl: [*c]c_int, in: [*c]const u8, inl: c_int) c_int;
pub extern fn EVP_DecryptFinal(ctx: ?*EVP_CIPHER_CTX, outm: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_DecryptFinal_ex(ctx: ?*EVP_CIPHER_CTX, outm: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_CipherInit(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, key: [*c]const u8, iv: [*c]const u8, enc: c_int) c_int;
pub extern fn EVP_CipherInit_ex(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, impl: ?*ENGINE, key: [*c]const u8, iv: [*c]const u8, enc: c_int) c_int;
pub extern fn EVP_CipherInit_ex2(ctx: ?*EVP_CIPHER_CTX, cipher: ?*const EVP_CIPHER, key: [*c]const u8, iv: [*c]const u8, enc: c_int, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_CipherUpdate(ctx: ?*EVP_CIPHER_CTX, out: [*c]u8, outl: [*c]c_int, in: [*c]const u8, inl: c_int) c_int;
pub extern fn EVP_CipherFinal(ctx: ?*EVP_CIPHER_CTX, outm: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_CipherFinal_ex(ctx: ?*EVP_CIPHER_CTX, outm: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_SignFinal(ctx: ?*EVP_MD_CTX, md: [*c]u8, s: [*c]c_uint, pkey: ?*EVP_PKEY) c_int;
pub extern fn EVP_SignFinal_ex(ctx: ?*EVP_MD_CTX, md: [*c]u8, s: [*c]c_uint, pkey: ?*EVP_PKEY, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn EVP_DigestSign(ctx: ?*EVP_MD_CTX, sigret: [*c]u8, siglen: [*c]usize, tbs: [*c]const u8, tbslen: usize) c_int;
pub extern fn EVP_VerifyFinal(ctx: ?*EVP_MD_CTX, sigbuf: [*c]const u8, siglen: c_uint, pkey: ?*EVP_PKEY) c_int;
pub extern fn EVP_VerifyFinal_ex(ctx: ?*EVP_MD_CTX, sigbuf: [*c]const u8, siglen: c_uint, pkey: ?*EVP_PKEY, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn EVP_DigestVerify(ctx: ?*EVP_MD_CTX, sigret: [*c]const u8, siglen: usize, tbs: [*c]const u8, tbslen: usize) c_int;
pub extern fn EVP_DigestSignInit_ex(ctx: ?*EVP_MD_CTX, pctx: [*c]?*EVP_PKEY_CTX, mdname: [*c]const u8, libctx: ?*OSSL_LIB_CTX, props: [*c]const u8, pkey: ?*EVP_PKEY, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_DigestSignInit(ctx: ?*EVP_MD_CTX, pctx: [*c]?*EVP_PKEY_CTX, @"type": ?*const EVP_MD, e: ?*ENGINE, pkey: ?*EVP_PKEY) c_int;
pub extern fn EVP_DigestSignUpdate(ctx: ?*EVP_MD_CTX, data: ?*const anyopaque, dsize: usize) c_int;
pub extern fn EVP_DigestSignFinal(ctx: ?*EVP_MD_CTX, sigret: [*c]u8, siglen: [*c]usize) c_int;
pub extern fn EVP_DigestVerifyInit_ex(ctx: ?*EVP_MD_CTX, pctx: [*c]?*EVP_PKEY_CTX, mdname: [*c]const u8, libctx: ?*OSSL_LIB_CTX, props: [*c]const u8, pkey: ?*EVP_PKEY, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_DigestVerifyInit(ctx: ?*EVP_MD_CTX, pctx: [*c]?*EVP_PKEY_CTX, @"type": ?*const EVP_MD, e: ?*ENGINE, pkey: ?*EVP_PKEY) c_int;
pub extern fn EVP_DigestVerifyUpdate(ctx: ?*EVP_MD_CTX, data: ?*const anyopaque, dsize: usize) c_int;
pub extern fn EVP_DigestVerifyFinal(ctx: ?*EVP_MD_CTX, sig: [*c]const u8, siglen: usize) c_int;
pub extern fn EVP_OpenInit(ctx: ?*EVP_CIPHER_CTX, @"type": ?*const EVP_CIPHER, ek: [*c]const u8, ekl: c_int, iv: [*c]const u8, priv: ?*EVP_PKEY) c_int;
pub extern fn EVP_OpenFinal(ctx: ?*EVP_CIPHER_CTX, out: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_SealInit(ctx: ?*EVP_CIPHER_CTX, @"type": ?*const EVP_CIPHER, ek: [*c][*c]u8, ekl: [*c]c_int, iv: [*c]u8, pubk: [*c]?*EVP_PKEY, npubk: c_int) c_int;
pub extern fn EVP_SealFinal(ctx: ?*EVP_CIPHER_CTX, out: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_ENCODE_CTX_new() ?*EVP_ENCODE_CTX;
pub extern fn EVP_ENCODE_CTX_free(ctx: ?*EVP_ENCODE_CTX) void;
pub extern fn EVP_ENCODE_CTX_copy(dctx: ?*EVP_ENCODE_CTX, sctx: ?*const EVP_ENCODE_CTX) c_int;
pub extern fn EVP_ENCODE_CTX_num(ctx: ?*EVP_ENCODE_CTX) c_int;
pub extern fn EVP_EncodeInit(ctx: ?*EVP_ENCODE_CTX) void;
pub extern fn EVP_EncodeUpdate(ctx: ?*EVP_ENCODE_CTX, out: [*c]u8, outl: [*c]c_int, in: [*c]const u8, inl: c_int) c_int;
pub extern fn EVP_EncodeFinal(ctx: ?*EVP_ENCODE_CTX, out: [*c]u8, outl: [*c]c_int) void;
pub extern fn EVP_EncodeBlock(t: [*c]u8, f: [*c]const u8, n: c_int) c_int;
pub extern fn EVP_DecodeInit(ctx: ?*EVP_ENCODE_CTX) void;
pub extern fn EVP_DecodeUpdate(ctx: ?*EVP_ENCODE_CTX, out: [*c]u8, outl: [*c]c_int, in: [*c]const u8, inl: c_int) c_int;
pub extern fn EVP_DecodeFinal(ctx: ?*EVP_ENCODE_CTX, out: [*c]u8, outl: [*c]c_int) c_int;
pub extern fn EVP_DecodeBlock(t: [*c]u8, f: [*c]const u8, n: c_int) c_int;
pub extern fn EVP_CIPHER_CTX_new() ?*EVP_CIPHER_CTX;
pub extern fn EVP_CIPHER_CTX_reset(c: ?*EVP_CIPHER_CTX) c_int;
pub extern fn EVP_CIPHER_CTX_free(c: ?*EVP_CIPHER_CTX) void;
pub extern fn EVP_CIPHER_CTX_set_key_length(x: ?*EVP_CIPHER_CTX, keylen: c_int) c_int;
pub extern fn EVP_CIPHER_CTX_set_padding(c: ?*EVP_CIPHER_CTX, pad: c_int) c_int;
pub extern fn EVP_CIPHER_CTX_ctrl(ctx: ?*EVP_CIPHER_CTX, @"type": c_int, arg: c_int, ptr: ?*anyopaque) c_int;
pub extern fn EVP_CIPHER_CTX_rand_key(ctx: ?*EVP_CIPHER_CTX, key: [*c]u8) c_int;
pub extern fn EVP_CIPHER_get_params(cipher: ?*EVP_CIPHER, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_CIPHER_CTX_set_params(ctx: ?*EVP_CIPHER_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_CIPHER_CTX_get_params(ctx: ?*EVP_CIPHER_CTX, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_CIPHER_gettable_params(cipher: ?*const EVP_CIPHER) [*c]const OSSL_PARAM;
pub extern fn EVP_CIPHER_settable_ctx_params(cipher: ?*const EVP_CIPHER) [*c]const OSSL_PARAM;
pub extern fn EVP_CIPHER_gettable_ctx_params(cipher: ?*const EVP_CIPHER) [*c]const OSSL_PARAM;
pub extern fn EVP_CIPHER_CTX_settable_params(ctx: ?*EVP_CIPHER_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_CIPHER_CTX_gettable_params(ctx: ?*EVP_CIPHER_CTX) [*c]const OSSL_PARAM;
pub extern fn BIO_f_md() ?*const BIO_METHOD;
pub extern fn BIO_f_base64() ?*const BIO_METHOD;
pub extern fn BIO_f_cipher() ?*const BIO_METHOD;
pub extern fn BIO_f_reliable() ?*const BIO_METHOD;
pub extern fn BIO_set_cipher(b: ?*BIO, c: ?*const EVP_CIPHER, k: [*c]const u8, i: [*c]const u8, enc: c_int) c_int;
pub extern fn EVP_md_null() ?*const EVP_MD;
pub extern fn EVP_md4() ?*const EVP_MD;
pub extern fn EVP_md5() ?*const EVP_MD;
pub extern fn EVP_md5_sha1() ?*const EVP_MD;
pub extern fn EVP_blake2b512() ?*const EVP_MD;
pub extern fn EVP_blake2s256() ?*const EVP_MD;
pub extern fn EVP_sha1() ?*const EVP_MD;
pub extern fn EVP_sha224() ?*const EVP_MD;
pub extern fn EVP_sha256() ?*const EVP_MD;
pub extern fn EVP_sha384() ?*const EVP_MD;
pub extern fn EVP_sha512() ?*const EVP_MD;
pub extern fn EVP_sha512_224() ?*const EVP_MD;
pub extern fn EVP_sha512_256() ?*const EVP_MD;
pub extern fn EVP_sha3_224() ?*const EVP_MD;
pub extern fn EVP_sha3_256() ?*const EVP_MD;
pub extern fn EVP_sha3_384() ?*const EVP_MD;
pub extern fn EVP_sha3_512() ?*const EVP_MD;
pub extern fn EVP_shake128() ?*const EVP_MD;
pub extern fn EVP_shake256() ?*const EVP_MD;
pub extern fn EVP_ripemd160() ?*const EVP_MD;
pub extern fn EVP_whirlpool() ?*const EVP_MD;
pub extern fn EVP_sm3() ?*const EVP_MD;
pub extern fn EVP_enc_null() ?*const EVP_CIPHER;
pub extern fn EVP_des_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_des_cfb64() ?*const EVP_CIPHER;
pub extern fn EVP_des_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_des_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede_cfb64() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3_cfb64() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_des_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_des_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_desx_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_des_ede3_wrap() ?*const EVP_CIPHER;
pub extern fn EVP_rc4() ?*const EVP_CIPHER;
pub extern fn EVP_rc4_40() ?*const EVP_CIPHER;
pub extern fn EVP_rc4_hmac_md5() ?*const EVP_CIPHER;
pub extern fn EVP_rc2_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_rc2_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_rc2_40_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_rc2_64_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_rc2_cfb64() ?*const EVP_CIPHER;
pub extern fn EVP_rc2_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_bf_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_bf_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_bf_cfb64() ?*const EVP_CIPHER;
pub extern fn EVP_bf_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_cast5_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_cast5_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_cast5_cfb64() ?*const EVP_CIPHER;
pub extern fn EVP_cast5_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_ccm() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_gcm() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_xts() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_wrap() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_wrap_pad() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_ocb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_ccm() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_gcm() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_wrap() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_wrap_pad() ?*const EVP_CIPHER;
pub extern fn EVP_aes_192_ocb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_ccm() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_gcm() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_xts() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_wrap() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_wrap_pad() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_ocb() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_cbc_hmac_sha1() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_cbc_hmac_sha1() ?*const EVP_CIPHER;
pub extern fn EVP_aes_128_cbc_hmac_sha256() ?*const EVP_CIPHER;
pub extern fn EVP_aes_256_cbc_hmac_sha256() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_gcm() ?*const EVP_CIPHER;
pub extern fn EVP_aria_128_ccm() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_gcm() ?*const EVP_CIPHER;
pub extern fn EVP_aria_192_ccm() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_gcm() ?*const EVP_CIPHER;
pub extern fn EVP_aria_256_ccm() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_128_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_128_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_128_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_128_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_128_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_128_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_128_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_192_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_192_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_192_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_192_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_192_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_192_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_192_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_256_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_256_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_256_cfb1() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_256_cfb8() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_256_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_256_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_camellia_256_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_chacha20() ?*const EVP_CIPHER;
pub extern fn EVP_chacha20_poly1305() ?*const EVP_CIPHER;
pub extern fn EVP_seed_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_seed_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_seed_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_seed_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_sm4_ecb() ?*const EVP_CIPHER;
pub extern fn EVP_sm4_cbc() ?*const EVP_CIPHER;
pub extern fn EVP_sm4_cfb128() ?*const EVP_CIPHER;
pub extern fn EVP_sm4_ofb() ?*const EVP_CIPHER;
pub extern fn EVP_sm4_ctr() ?*const EVP_CIPHER;
pub extern fn EVP_add_cipher(cipher: ?*const EVP_CIPHER) c_int;
pub extern fn EVP_add_digest(digest: ?*const EVP_MD) c_int;
pub extern fn EVP_get_cipherbyname(name: [*c]const u8) ?*const EVP_CIPHER;
pub extern fn EVP_get_digestbyname(name: [*c]const u8) ?*const EVP_MD;
pub extern fn EVP_CIPHER_do_all(@"fn": ?*const fn (?*const EVP_CIPHER, [*c]const u8, [*c]const u8, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_CIPHER_do_all_sorted(@"fn": ?*const fn (?*const EVP_CIPHER, [*c]const u8, [*c]const u8, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_CIPHER_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_CIPHER, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_MD_do_all(@"fn": ?*const fn (?*const EVP_MD, [*c]const u8, [*c]const u8, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_MD_do_all_sorted(@"fn": ?*const fn (?*const EVP_MD, [*c]const u8, [*c]const u8, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_MD_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_MD, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_MAC_fetch(libctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_MAC;
pub extern fn EVP_MAC_up_ref(mac: ?*EVP_MAC) c_int;
pub extern fn EVP_MAC_free(mac: ?*EVP_MAC) void;
pub extern fn EVP_MAC_get0_name(mac: ?*const EVP_MAC) [*c]const u8;
pub extern fn EVP_MAC_get0_description(mac: ?*const EVP_MAC) [*c]const u8;
pub extern fn EVP_MAC_is_a(mac: ?*const EVP_MAC, name: [*c]const u8) c_int;
pub extern fn EVP_MAC_get0_provider(mac: ?*const EVP_MAC) ?*const OSSL_PROVIDER;
pub extern fn EVP_MAC_get_params(mac: ?*EVP_MAC, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_MAC_CTX_new(mac: ?*EVP_MAC) ?*EVP_MAC_CTX;
pub extern fn EVP_MAC_CTX_free(ctx: ?*EVP_MAC_CTX) void;
pub extern fn EVP_MAC_CTX_dup(src: ?*const EVP_MAC_CTX) ?*EVP_MAC_CTX;
pub extern fn EVP_MAC_CTX_get0_mac(ctx: ?*EVP_MAC_CTX) ?*EVP_MAC;
pub extern fn EVP_MAC_CTX_get_params(ctx: ?*EVP_MAC_CTX, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_MAC_CTX_set_params(ctx: ?*EVP_MAC_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_MAC_CTX_get_mac_size(ctx: ?*EVP_MAC_CTX) usize;
pub extern fn EVP_MAC_CTX_get_block_size(ctx: ?*EVP_MAC_CTX) usize;
pub extern fn EVP_Q_mac(libctx: ?*OSSL_LIB_CTX, name: [*c]const u8, propq: [*c]const u8, subalg: [*c]const u8, params: [*c]const OSSL_PARAM, key: ?*const anyopaque, keylen: usize, data: [*c]const u8, datalen: usize, out: [*c]u8, outsize: usize, outlen: [*c]usize) [*c]u8;
pub extern fn EVP_MAC_init(ctx: ?*EVP_MAC_CTX, key: [*c]const u8, keylen: usize, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_MAC_update(ctx: ?*EVP_MAC_CTX, data: [*c]const u8, datalen: usize) c_int;
pub extern fn EVP_MAC_final(ctx: ?*EVP_MAC_CTX, out: [*c]u8, outl: [*c]usize, outsize: usize) c_int;
pub extern fn EVP_MAC_finalXOF(ctx: ?*EVP_MAC_CTX, out: [*c]u8, outsize: usize) c_int;
pub extern fn EVP_MAC_gettable_params(mac: ?*const EVP_MAC) [*c]const OSSL_PARAM;
pub extern fn EVP_MAC_gettable_ctx_params(mac: ?*const EVP_MAC) [*c]const OSSL_PARAM;
pub extern fn EVP_MAC_settable_ctx_params(mac: ?*const EVP_MAC) [*c]const OSSL_PARAM;
pub extern fn EVP_MAC_CTX_gettable_params(ctx: ?*EVP_MAC_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_MAC_CTX_settable_params(ctx: ?*EVP_MAC_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_MAC_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_MAC, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_MAC_names_do_all(mac: ?*const EVP_MAC, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_RAND_fetch(libctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_RAND;
pub extern fn EVP_RAND_up_ref(rand: ?*EVP_RAND) c_int;
pub extern fn EVP_RAND_free(rand: ?*EVP_RAND) void;
pub extern fn EVP_RAND_get0_name(rand: ?*const EVP_RAND) [*c]const u8;
pub extern fn EVP_RAND_get0_description(md: ?*const EVP_RAND) [*c]const u8;
pub extern fn EVP_RAND_is_a(rand: ?*const EVP_RAND, name: [*c]const u8) c_int;
pub extern fn EVP_RAND_get0_provider(rand: ?*const EVP_RAND) ?*const OSSL_PROVIDER;
pub extern fn EVP_RAND_get_params(rand: ?*EVP_RAND, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_RAND_CTX_new(rand: ?*EVP_RAND, parent: ?*EVP_RAND_CTX) ?*EVP_RAND_CTX;
pub extern fn EVP_RAND_CTX_free(ctx: ?*EVP_RAND_CTX) void;
pub extern fn EVP_RAND_CTX_get0_rand(ctx: ?*EVP_RAND_CTX) ?*EVP_RAND;
pub extern fn EVP_RAND_CTX_get_params(ctx: ?*EVP_RAND_CTX, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_RAND_CTX_set_params(ctx: ?*EVP_RAND_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_RAND_gettable_params(rand: ?*const EVP_RAND) [*c]const OSSL_PARAM;
pub extern fn EVP_RAND_gettable_ctx_params(rand: ?*const EVP_RAND) [*c]const OSSL_PARAM;
pub extern fn EVP_RAND_settable_ctx_params(rand: ?*const EVP_RAND) [*c]const OSSL_PARAM;
pub extern fn EVP_RAND_CTX_gettable_params(ctx: ?*EVP_RAND_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_RAND_CTX_settable_params(ctx: ?*EVP_RAND_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_RAND_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_RAND, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_RAND_names_do_all(rand: ?*const EVP_RAND, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_RAND_instantiate(ctx: ?*EVP_RAND_CTX, strength: c_uint, prediction_resistance: c_int, pstr: [*c]const u8, pstr_len: usize, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_RAND_uninstantiate(ctx: ?*EVP_RAND_CTX) c_int;
pub extern fn EVP_RAND_generate(ctx: ?*EVP_RAND_CTX, out: [*c]u8, outlen: usize, strength: c_uint, prediction_resistance: c_int, addin: [*c]const u8, addin_len: usize) c_int;
pub extern fn EVP_RAND_reseed(ctx: ?*EVP_RAND_CTX, prediction_resistance: c_int, ent: [*c]const u8, ent_len: usize, addin: [*c]const u8, addin_len: usize) c_int;
pub extern fn EVP_RAND_nonce(ctx: ?*EVP_RAND_CTX, out: [*c]u8, outlen: usize) c_int;
pub extern fn EVP_RAND_enable_locking(ctx: ?*EVP_RAND_CTX) c_int;
pub extern fn EVP_RAND_verify_zeroization(ctx: ?*EVP_RAND_CTX) c_int;
pub extern fn EVP_RAND_get_strength(ctx: ?*EVP_RAND_CTX) c_uint;
pub extern fn EVP_RAND_get_state(ctx: ?*EVP_RAND_CTX) c_int;
pub extern fn EVP_PKEY_decrypt_old(dec_key: [*c]u8, enc_key: [*c]const u8, enc_key_len: c_int, private_key: ?*EVP_PKEY) c_int;
pub extern fn EVP_PKEY_encrypt_old(enc_key: [*c]u8, key: [*c]const u8, key_len: c_int, pub_key: ?*EVP_PKEY) c_int;
pub extern fn EVP_PKEY_is_a(pkey: ?*const EVP_PKEY, name: [*c]const u8) c_int;
pub extern fn EVP_PKEY_type_names_do_all(pkey: ?*const EVP_PKEY, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_PKEY_type(@"type": c_int) c_int;
pub extern fn EVP_PKEY_get_id(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_get_base_id(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_get_bits(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_get_security_bits(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_get_size(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_can_sign(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_set_type(pkey: ?*EVP_PKEY, @"type": c_int) c_int;
pub extern fn EVP_PKEY_set_type_str(pkey: ?*EVP_PKEY, str: [*c]const u8, len: c_int) c_int;
pub extern fn EVP_PKEY_set_type_by_keymgmt(pkey: ?*EVP_PKEY, keymgmt: ?*EVP_KEYMGMT) c_int;
pub extern fn EVP_PKEY_set1_engine(pkey: ?*EVP_PKEY, e: ?*ENGINE) c_int;
pub extern fn EVP_PKEY_get0_engine(pkey: ?*const EVP_PKEY) ?*ENGINE;
pub extern fn EVP_PKEY_assign(pkey: ?*EVP_PKEY, @"type": c_int, key: ?*anyopaque) c_int;
pub extern fn EVP_PKEY_get0(pkey: ?*const EVP_PKEY) ?*anyopaque;
pub extern fn EVP_PKEY_get0_hmac(pkey: ?*const EVP_PKEY, len: [*c]usize) [*c]const u8;
pub extern fn EVP_PKEY_get0_poly1305(pkey: ?*const EVP_PKEY, len: [*c]usize) [*c]const u8;
pub extern fn EVP_PKEY_get0_siphash(pkey: ?*const EVP_PKEY, len: [*c]usize) [*c]const u8;
pub extern fn EVP_PKEY_set1_RSA(pkey: ?*EVP_PKEY, key: ?*struct_rsa_st) c_int;
pub extern fn EVP_PKEY_get0_RSA(pkey: ?*const EVP_PKEY) ?*const struct_rsa_st;
pub extern fn EVP_PKEY_get1_RSA(pkey: ?*EVP_PKEY) ?*struct_rsa_st;
pub extern fn EVP_PKEY_set1_DSA(pkey: ?*EVP_PKEY, key: ?*struct_dsa_st) c_int;
pub extern fn EVP_PKEY_get0_DSA(pkey: ?*const EVP_PKEY) ?*const struct_dsa_st;
pub extern fn EVP_PKEY_get1_DSA(pkey: ?*EVP_PKEY) ?*struct_dsa_st;
pub extern fn EVP_PKEY_set1_DH(pkey: ?*EVP_PKEY, key: ?*struct_dh_st) c_int;
pub extern fn EVP_PKEY_get0_DH(pkey: ?*const EVP_PKEY) ?*const struct_dh_st;
pub extern fn EVP_PKEY_get1_DH(pkey: ?*EVP_PKEY) ?*struct_dh_st;
pub extern fn EVP_PKEY_set1_EC_KEY(pkey: ?*EVP_PKEY, key: ?*struct_ec_key_st) c_int;
pub extern fn EVP_PKEY_get0_EC_KEY(pkey: ?*const EVP_PKEY) ?*const struct_ec_key_st;
pub extern fn EVP_PKEY_get1_EC_KEY(pkey: ?*EVP_PKEY) ?*struct_ec_key_st;
pub extern fn EVP_PKEY_new() ?*EVP_PKEY;
pub extern fn EVP_PKEY_up_ref(pkey: ?*EVP_PKEY) c_int;
pub extern fn EVP_PKEY_dup(pkey: ?*EVP_PKEY) ?*EVP_PKEY;
pub extern fn EVP_PKEY_free(pkey: ?*EVP_PKEY) void;
pub extern fn EVP_PKEY_get0_description(pkey: ?*const EVP_PKEY) [*c]const u8;
pub extern fn EVP_PKEY_get0_provider(key: ?*const EVP_PKEY) ?*const OSSL_PROVIDER;
pub extern fn d2i_PublicKey(@"type": c_int, a: [*c]?*EVP_PKEY, pp: [*c][*c]const u8, length: c_long) ?*EVP_PKEY;
pub extern fn i2d_PublicKey(a: ?*const EVP_PKEY, pp: [*c][*c]u8) c_int;
pub extern fn d2i_PrivateKey_ex(@"type": c_int, a: [*c]?*EVP_PKEY, pp: [*c][*c]const u8, length: c_long, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) ?*EVP_PKEY;
pub extern fn d2i_PrivateKey(@"type": c_int, a: [*c]?*EVP_PKEY, pp: [*c][*c]const u8, length: c_long) ?*EVP_PKEY;
pub extern fn d2i_AutoPrivateKey_ex(a: [*c]?*EVP_PKEY, pp: [*c][*c]const u8, length: c_long, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) ?*EVP_PKEY;
pub extern fn d2i_AutoPrivateKey(a: [*c]?*EVP_PKEY, pp: [*c][*c]const u8, length: c_long) ?*EVP_PKEY;
pub extern fn i2d_PrivateKey(a: ?*const EVP_PKEY, pp: [*c][*c]u8) c_int;
pub extern fn i2d_KeyParams(a: ?*const EVP_PKEY, pp: [*c][*c]u8) c_int;
pub extern fn d2i_KeyParams(@"type": c_int, a: [*c]?*EVP_PKEY, pp: [*c][*c]const u8, length: c_long) ?*EVP_PKEY;
pub extern fn i2d_KeyParams_bio(bp: ?*BIO, pkey: ?*const EVP_PKEY) c_int;
pub extern fn d2i_KeyParams_bio(@"type": c_int, a: [*c]?*EVP_PKEY, in: ?*BIO) ?*EVP_PKEY;
pub extern fn EVP_PKEY_copy_parameters(to: ?*EVP_PKEY, from: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_missing_parameters(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_save_parameters(pkey: ?*EVP_PKEY, mode: c_int) c_int;
pub extern fn EVP_PKEY_parameters_eq(a: ?*const EVP_PKEY, b: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_eq(a: ?*const EVP_PKEY, b: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_cmp_parameters(a: ?*const EVP_PKEY, b: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_cmp(a: ?*const EVP_PKEY, b: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_print_public(out: ?*BIO, pkey: ?*const EVP_PKEY, indent: c_int, pctx: ?*ASN1_PCTX) c_int;
pub extern fn EVP_PKEY_print_private(out: ?*BIO, pkey: ?*const EVP_PKEY, indent: c_int, pctx: ?*ASN1_PCTX) c_int;
pub extern fn EVP_PKEY_print_params(out: ?*BIO, pkey: ?*const EVP_PKEY, indent: c_int, pctx: ?*ASN1_PCTX) c_int;
pub extern fn EVP_PKEY_print_public_fp(fp: [*c]FILE, pkey: ?*const EVP_PKEY, indent: c_int, pctx: ?*ASN1_PCTX) c_int;
pub extern fn EVP_PKEY_print_private_fp(fp: [*c]FILE, pkey: ?*const EVP_PKEY, indent: c_int, pctx: ?*ASN1_PCTX) c_int;
pub extern fn EVP_PKEY_print_params_fp(fp: [*c]FILE, pkey: ?*const EVP_PKEY, indent: c_int, pctx: ?*ASN1_PCTX) c_int;
pub extern fn EVP_PKEY_get_default_digest_nid(pkey: ?*EVP_PKEY, pnid: [*c]c_int) c_int;
pub extern fn EVP_PKEY_get_default_digest_name(pkey: ?*EVP_PKEY, mdname: [*c]u8, mdname_sz: usize) c_int;
pub extern fn EVP_PKEY_digestsign_supports_digest(pkey: ?*EVP_PKEY, libctx: ?*OSSL_LIB_CTX, name: [*c]const u8, propq: [*c]const u8) c_int;
pub extern fn EVP_PKEY_set1_encoded_public_key(pkey: ?*EVP_PKEY, @"pub": [*c]const u8, publen: usize) c_int;
pub extern fn EVP_PKEY_get1_encoded_public_key(pkey: ?*EVP_PKEY, ppub: [*c][*c]u8) usize;
pub extern fn EVP_CIPHER_param_to_asn1(c: ?*EVP_CIPHER_CTX, @"type": [*c]ASN1_TYPE) c_int;
pub extern fn EVP_CIPHER_asn1_to_param(c: ?*EVP_CIPHER_CTX, @"type": [*c]ASN1_TYPE) c_int;
pub extern fn EVP_CIPHER_set_asn1_iv(c: ?*EVP_CIPHER_CTX, @"type": [*c]ASN1_TYPE) c_int;
pub extern fn EVP_CIPHER_get_asn1_iv(c: ?*EVP_CIPHER_CTX, @"type": [*c]ASN1_TYPE) c_int;
pub extern fn PKCS5_PBE_keyivgen(ctx: ?*EVP_CIPHER_CTX, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, cipher: ?*const EVP_CIPHER, md: ?*const EVP_MD, en_de: c_int) c_int;
pub extern fn PKCS5_PBE_keyivgen_ex(cctx: ?*EVP_CIPHER_CTX, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, cipher: ?*const EVP_CIPHER, md: ?*const EVP_MD, en_de: c_int, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn PKCS5_PBKDF2_HMAC_SHA1(pass: [*c]const u8, passlen: c_int, salt: [*c]const u8, saltlen: c_int, iter: c_int, keylen: c_int, out: [*c]u8) c_int;
pub extern fn PKCS5_PBKDF2_HMAC(pass: [*c]const u8, passlen: c_int, salt: [*c]const u8, saltlen: c_int, iter: c_int, digest: ?*const EVP_MD, keylen: c_int, out: [*c]u8) c_int;
pub extern fn PKCS5_v2_PBE_keyivgen(ctx: ?*EVP_CIPHER_CTX, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, cipher: ?*const EVP_CIPHER, md: ?*const EVP_MD, en_de: c_int) c_int;
pub extern fn PKCS5_v2_PBE_keyivgen_ex(ctx: ?*EVP_CIPHER_CTX, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, cipher: ?*const EVP_CIPHER, md: ?*const EVP_MD, en_de: c_int, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn EVP_PBE_scrypt(pass: [*c]const u8, passlen: usize, salt: [*c]const u8, saltlen: usize, N: u64, r: u64, p: u64, maxmem: u64, key: [*c]u8, keylen: usize) c_int;
pub extern fn EVP_PBE_scrypt_ex(pass: [*c]const u8, passlen: usize, salt: [*c]const u8, saltlen: usize, N: u64, r: u64, p: u64, maxmem: u64, key: [*c]u8, keylen: usize, ctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn PKCS5_v2_scrypt_keyivgen(ctx: ?*EVP_CIPHER_CTX, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, c: ?*const EVP_CIPHER, md: ?*const EVP_MD, en_de: c_int) c_int;
pub extern fn PKCS5_v2_scrypt_keyivgen_ex(ctx: ?*EVP_CIPHER_CTX, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, c: ?*const EVP_CIPHER, md: ?*const EVP_MD, en_de: c_int, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn PKCS5_PBE_add() void;
pub extern fn EVP_PBE_CipherInit(pbe_obj: ?*ASN1_OBJECT, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, ctx: ?*EVP_CIPHER_CTX, en_de: c_int) c_int;
pub extern fn EVP_PBE_CipherInit_ex(pbe_obj: ?*ASN1_OBJECT, pass: [*c]const u8, passlen: c_int, param: [*c]ASN1_TYPE, ctx: ?*EVP_CIPHER_CTX, en_de: c_int, libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8) c_int;
pub extern fn EVP_PBE_alg_add_type(pbe_type: c_int, pbe_nid: c_int, cipher_nid: c_int, md_nid: c_int, keygen: ?*const EVP_PBE_KEYGEN) c_int;
pub extern fn EVP_PBE_alg_add(nid: c_int, cipher: ?*const EVP_CIPHER, md: ?*const EVP_MD, keygen: ?*const EVP_PBE_KEYGEN) c_int;
pub extern fn EVP_PBE_find(@"type": c_int, pbe_nid: c_int, pcnid: [*c]c_int, pmnid: [*c]c_int, pkeygen: [*c]?*const EVP_PBE_KEYGEN) c_int;
pub extern fn EVP_PBE_find_ex(@"type": c_int, pbe_nid: c_int, pcnid: [*c]c_int, pmnid: [*c]c_int, pkeygen: [*c]?*const EVP_PBE_KEYGEN, pkeygen_ex: [*c]?*const EVP_PBE_KEYGEN_EX) c_int;
pub extern fn EVP_PBE_cleanup() void;
pub extern fn EVP_PBE_get(ptype: [*c]c_int, ppbe_nid: [*c]c_int, num: usize) c_int;
pub extern fn EVP_PKEY_asn1_get_count() c_int;
pub extern fn EVP_PKEY_asn1_get0(idx: c_int) ?*const EVP_PKEY_ASN1_METHOD;
pub extern fn EVP_PKEY_asn1_find(pe: [*c]?*ENGINE, @"type": c_int) ?*const EVP_PKEY_ASN1_METHOD;
pub extern fn EVP_PKEY_asn1_find_str(pe: [*c]?*ENGINE, str: [*c]const u8, len: c_int) ?*const EVP_PKEY_ASN1_METHOD;
pub extern fn EVP_PKEY_asn1_add0(ameth: ?*const EVP_PKEY_ASN1_METHOD) c_int;
pub extern fn EVP_PKEY_asn1_add_alias(to: c_int, from: c_int) c_int;
pub extern fn EVP_PKEY_asn1_get0_info(ppkey_id: [*c]c_int, pkey_base_id: [*c]c_int, ppkey_flags: [*c]c_int, pinfo: [*c][*c]const u8, ppem_str: [*c][*c]const u8, ameth: ?*const EVP_PKEY_ASN1_METHOD) c_int;
pub extern fn EVP_PKEY_get0_asn1(pkey: ?*const EVP_PKEY) ?*const EVP_PKEY_ASN1_METHOD;
pub extern fn EVP_PKEY_asn1_new(id: c_int, flags: c_int, pem_str: [*c]const u8, info: [*c]const u8) ?*EVP_PKEY_ASN1_METHOD;
pub extern fn EVP_PKEY_asn1_copy(dst: ?*EVP_PKEY_ASN1_METHOD, src: ?*const EVP_PKEY_ASN1_METHOD) void;
pub extern fn EVP_PKEY_asn1_free(ameth: ?*EVP_PKEY_ASN1_METHOD) void;
pub extern fn EVP_PKEY_asn1_set_public(ameth: ?*EVP_PKEY_ASN1_METHOD, pub_decode: ?*const fn (?*EVP_PKEY, ?*const X509_PUBKEY) callconv(.c) c_int, pub_encode: ?*const fn (?*X509_PUBKEY, ?*const EVP_PKEY) callconv(.c) c_int, pub_cmp: ?*const fn (?*const EVP_PKEY, ?*const EVP_PKEY) callconv(.c) c_int, pub_print: ?*const fn (?*BIO, ?*const EVP_PKEY, c_int, ?*ASN1_PCTX) callconv(.c) c_int, pkey_size: ?*const fn (?*const EVP_PKEY) callconv(.c) c_int, pkey_bits: ?*const fn (?*const EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_private(ameth: ?*EVP_PKEY_ASN1_METHOD, priv_decode: ?*const fn (?*EVP_PKEY, ?*const PKCS8_PRIV_KEY_INFO) callconv(.c) c_int, priv_encode: ?*const fn (?*PKCS8_PRIV_KEY_INFO, ?*const EVP_PKEY) callconv(.c) c_int, priv_print: ?*const fn (?*BIO, ?*const EVP_PKEY, c_int, ?*ASN1_PCTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_param(ameth: ?*EVP_PKEY_ASN1_METHOD, param_decode: ?*const fn (?*EVP_PKEY, [*c][*c]const u8, c_int) callconv(.c) c_int, param_encode: ?*const fn (?*const EVP_PKEY, [*c][*c]u8) callconv(.c) c_int, param_missing: ?*const fn (?*const EVP_PKEY) callconv(.c) c_int, param_copy: ?*const fn (?*EVP_PKEY, ?*const EVP_PKEY) callconv(.c) c_int, param_cmp: ?*const fn (?*const EVP_PKEY, ?*const EVP_PKEY) callconv(.c) c_int, param_print: ?*const fn (?*BIO, ?*const EVP_PKEY, c_int, ?*ASN1_PCTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_free(ameth: ?*EVP_PKEY_ASN1_METHOD, pkey_free: ?*const fn (?*EVP_PKEY) callconv(.c) void) void;
pub extern fn EVP_PKEY_asn1_set_ctrl(ameth: ?*EVP_PKEY_ASN1_METHOD, pkey_ctrl: ?*const fn (?*EVP_PKEY, c_int, c_long, ?*anyopaque) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_item(ameth: ?*EVP_PKEY_ASN1_METHOD, item_verify: ?*const fn (?*EVP_MD_CTX, ?*const ASN1_ITEM, ?*const anyopaque, ?*const X509_ALGOR, [*c]const ASN1_BIT_STRING, ?*EVP_PKEY) callconv(.c) c_int, item_sign: ?*const fn (?*EVP_MD_CTX, ?*const ASN1_ITEM, ?*const anyopaque, ?*X509_ALGOR, ?*X509_ALGOR, [*c]ASN1_BIT_STRING) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_siginf(ameth: ?*EVP_PKEY_ASN1_METHOD, siginf_set: ?*const fn (?*X509_SIG_INFO, ?*const X509_ALGOR, [*c]const ASN1_STRING) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_check(ameth: ?*EVP_PKEY_ASN1_METHOD, pkey_check: ?*const fn (?*const EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_public_check(ameth: ?*EVP_PKEY_ASN1_METHOD, pkey_pub_check: ?*const fn (?*const EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_param_check(ameth: ?*EVP_PKEY_ASN1_METHOD, pkey_param_check: ?*const fn (?*const EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_set_priv_key(ameth: ?*EVP_PKEY_ASN1_METHOD, set_priv_key: ?*const fn (?*EVP_PKEY, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_set_pub_key(ameth: ?*EVP_PKEY_ASN1_METHOD, set_pub_key: ?*const fn (?*EVP_PKEY, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_get_priv_key(ameth: ?*EVP_PKEY_ASN1_METHOD, get_priv_key: ?*const fn (?*const EVP_PKEY, [*c]u8, [*c]usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_get_pub_key(ameth: ?*EVP_PKEY_ASN1_METHOD, get_pub_key: ?*const fn (?*const EVP_PKEY, [*c]u8, [*c]usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_asn1_set_security_bits(ameth: ?*EVP_PKEY_ASN1_METHOD, pkey_security_bits: ?*const fn (?*const EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_CTX_get_signature_md(ctx: ?*EVP_PKEY_CTX, md: [*c]?*const EVP_MD) c_int;
pub extern fn EVP_PKEY_CTX_set_signature_md(ctx: ?*EVP_PKEY_CTX, md: ?*const EVP_MD) c_int;
pub extern fn EVP_PKEY_CTX_set1_id(ctx: ?*EVP_PKEY_CTX, id: ?*const anyopaque, len: c_int) c_int;
pub extern fn EVP_PKEY_CTX_get1_id(ctx: ?*EVP_PKEY_CTX, id: ?*anyopaque) c_int;
pub extern fn EVP_PKEY_CTX_get1_id_len(ctx: ?*EVP_PKEY_CTX, id_len: [*c]usize) c_int;
pub extern fn EVP_PKEY_CTX_set_kem_op(ctx: ?*EVP_PKEY_CTX, op: [*c]const u8) c_int;
pub extern fn EVP_PKEY_get0_type_name(key: ?*const EVP_PKEY) [*c]const u8;
pub extern fn EVP_PKEY_CTX_set_mac_key(ctx: ?*EVP_PKEY_CTX, key: [*c]const u8, keylen: c_int) c_int;
pub extern fn EVP_PKEY_meth_find(@"type": c_int) ?*const EVP_PKEY_METHOD;
pub extern fn EVP_PKEY_meth_new(id: c_int, flags: c_int) ?*EVP_PKEY_METHOD;
pub extern fn EVP_PKEY_meth_get0_info(ppkey_id: [*c]c_int, pflags: [*c]c_int, meth: ?*const EVP_PKEY_METHOD) void;
pub extern fn EVP_PKEY_meth_copy(dst: ?*EVP_PKEY_METHOD, src: ?*const EVP_PKEY_METHOD) void;
pub extern fn EVP_PKEY_meth_free(pmeth: ?*EVP_PKEY_METHOD) void;
pub extern fn EVP_PKEY_meth_add0(pmeth: ?*const EVP_PKEY_METHOD) c_int;
pub extern fn EVP_PKEY_meth_remove(pmeth: ?*const EVP_PKEY_METHOD) c_int;
pub extern fn EVP_PKEY_meth_get_count() usize;
pub extern fn EVP_PKEY_meth_get0(idx: usize) ?*const EVP_PKEY_METHOD;
pub extern fn EVP_KEYMGMT_fetch(ctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_KEYMGMT;
pub extern fn EVP_KEYMGMT_up_ref(keymgmt: ?*EVP_KEYMGMT) c_int;
pub extern fn EVP_KEYMGMT_free(keymgmt: ?*EVP_KEYMGMT) void;
pub extern fn EVP_KEYMGMT_get0_provider(keymgmt: ?*const EVP_KEYMGMT) ?*const OSSL_PROVIDER;
pub extern fn EVP_KEYMGMT_get0_name(keymgmt: ?*const EVP_KEYMGMT) [*c]const u8;
pub extern fn EVP_KEYMGMT_get0_description(keymgmt: ?*const EVP_KEYMGMT) [*c]const u8;
pub extern fn EVP_KEYMGMT_is_a(keymgmt: ?*const EVP_KEYMGMT, name: [*c]const u8) c_int;
pub extern fn EVP_KEYMGMT_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_KEYMGMT, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_KEYMGMT_names_do_all(keymgmt: ?*const EVP_KEYMGMT, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_KEYMGMT_gettable_params(keymgmt: ?*const EVP_KEYMGMT) [*c]const OSSL_PARAM;
pub extern fn EVP_KEYMGMT_settable_params(keymgmt: ?*const EVP_KEYMGMT) [*c]const OSSL_PARAM;
pub extern fn EVP_KEYMGMT_gen_settable_params(keymgmt: ?*const EVP_KEYMGMT) [*c]const OSSL_PARAM;
pub extern fn EVP_PKEY_CTX_new(pkey: ?*EVP_PKEY, e: ?*ENGINE) ?*EVP_PKEY_CTX;
pub extern fn EVP_PKEY_CTX_new_id(id: c_int, e: ?*ENGINE) ?*EVP_PKEY_CTX;
pub extern fn EVP_PKEY_CTX_new_from_name(libctx: ?*OSSL_LIB_CTX, name: [*c]const u8, propquery: [*c]const u8) ?*EVP_PKEY_CTX;
pub extern fn EVP_PKEY_CTX_new_from_pkey(libctx: ?*OSSL_LIB_CTX, pkey: ?*EVP_PKEY, propquery: [*c]const u8) ?*EVP_PKEY_CTX;
pub extern fn EVP_PKEY_CTX_dup(ctx: ?*const EVP_PKEY_CTX) ?*EVP_PKEY_CTX;
pub extern fn EVP_PKEY_CTX_free(ctx: ?*EVP_PKEY_CTX) void;
pub extern fn EVP_PKEY_CTX_is_a(ctx: ?*EVP_PKEY_CTX, keytype: [*c]const u8) c_int;
pub extern fn EVP_PKEY_CTX_get_params(ctx: ?*EVP_PKEY_CTX, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_CTX_gettable_params(ctx: ?*const EVP_PKEY_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_PKEY_CTX_set_params(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_CTX_settable_params(ctx: ?*const EVP_PKEY_CTX) [*c]const OSSL_PARAM;
pub extern fn EVP_PKEY_CTX_ctrl(ctx: ?*EVP_PKEY_CTX, keytype: c_int, optype: c_int, cmd: c_int, p1: c_int, p2: ?*anyopaque) c_int;
pub extern fn EVP_PKEY_CTX_ctrl_str(ctx: ?*EVP_PKEY_CTX, @"type": [*c]const u8, value: [*c]const u8) c_int;
pub extern fn EVP_PKEY_CTX_ctrl_uint64(ctx: ?*EVP_PKEY_CTX, keytype: c_int, optype: c_int, cmd: c_int, value: u64) c_int;
pub extern fn EVP_PKEY_CTX_str2ctrl(ctx: ?*EVP_PKEY_CTX, cmd: c_int, str: [*c]const u8) c_int;
pub extern fn EVP_PKEY_CTX_hex2ctrl(ctx: ?*EVP_PKEY_CTX, cmd: c_int, hex: [*c]const u8) c_int;
pub extern fn EVP_PKEY_CTX_md(ctx: ?*EVP_PKEY_CTX, optype: c_int, cmd: c_int, md: [*c]const u8) c_int;
pub extern fn EVP_PKEY_CTX_get_operation(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_CTX_set0_keygen_info(ctx: ?*EVP_PKEY_CTX, dat: [*c]c_int, datlen: c_int) void;
pub extern fn EVP_PKEY_new_mac_key(@"type": c_int, e: ?*ENGINE, key: [*c]const u8, keylen: c_int) ?*EVP_PKEY;
pub extern fn EVP_PKEY_new_raw_private_key_ex(libctx: ?*OSSL_LIB_CTX, keytype: [*c]const u8, propq: [*c]const u8, priv: [*c]const u8, len: usize) ?*EVP_PKEY;
pub extern fn EVP_PKEY_new_raw_private_key(@"type": c_int, e: ?*ENGINE, priv: [*c]const u8, len: usize) ?*EVP_PKEY;
pub extern fn EVP_PKEY_new_raw_public_key_ex(libctx: ?*OSSL_LIB_CTX, keytype: [*c]const u8, propq: [*c]const u8, @"pub": [*c]const u8, len: usize) ?*EVP_PKEY;
pub extern fn EVP_PKEY_new_raw_public_key(@"type": c_int, e: ?*ENGINE, @"pub": [*c]const u8, len: usize) ?*EVP_PKEY;
pub extern fn EVP_PKEY_get_raw_private_key(pkey: ?*const EVP_PKEY, priv: [*c]u8, len: [*c]usize) c_int;
pub extern fn EVP_PKEY_get_raw_public_key(pkey: ?*const EVP_PKEY, @"pub": [*c]u8, len: [*c]usize) c_int;
pub extern fn EVP_PKEY_new_CMAC_key(e: ?*ENGINE, priv: [*c]const u8, len: usize, cipher: ?*const EVP_CIPHER) ?*EVP_PKEY;
pub extern fn EVP_PKEY_CTX_set_data(ctx: ?*EVP_PKEY_CTX, data: ?*anyopaque) void;
pub extern fn EVP_PKEY_CTX_get_data(ctx: ?*const EVP_PKEY_CTX) ?*anyopaque;
pub extern fn EVP_PKEY_CTX_get0_pkey(ctx: ?*EVP_PKEY_CTX) ?*EVP_PKEY;
pub extern fn EVP_PKEY_CTX_get0_peerkey(ctx: ?*EVP_PKEY_CTX) ?*EVP_PKEY;
pub extern fn EVP_PKEY_CTX_set_app_data(ctx: ?*EVP_PKEY_CTX, data: ?*anyopaque) void;
pub extern fn EVP_PKEY_CTX_get_app_data(ctx: ?*EVP_PKEY_CTX) ?*anyopaque;
pub extern fn EVP_SIGNATURE_free(signature: ?*EVP_SIGNATURE) void;
pub extern fn EVP_SIGNATURE_up_ref(signature: ?*EVP_SIGNATURE) c_int;
pub extern fn EVP_SIGNATURE_get0_provider(signature: ?*const EVP_SIGNATURE) ?*OSSL_PROVIDER;
pub extern fn EVP_SIGNATURE_fetch(ctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_SIGNATURE;
pub extern fn EVP_SIGNATURE_is_a(signature: ?*const EVP_SIGNATURE, name: [*c]const u8) c_int;
pub extern fn EVP_SIGNATURE_get0_name(signature: ?*const EVP_SIGNATURE) [*c]const u8;
pub extern fn EVP_SIGNATURE_get0_description(signature: ?*const EVP_SIGNATURE) [*c]const u8;
pub extern fn EVP_SIGNATURE_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_SIGNATURE, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) void;
pub extern fn EVP_SIGNATURE_names_do_all(signature: ?*const EVP_SIGNATURE, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_SIGNATURE_gettable_ctx_params(sig: ?*const EVP_SIGNATURE) [*c]const OSSL_PARAM;
pub extern fn EVP_SIGNATURE_settable_ctx_params(sig: ?*const EVP_SIGNATURE) [*c]const OSSL_PARAM;
pub extern fn EVP_ASYM_CIPHER_free(cipher: ?*EVP_ASYM_CIPHER) void;
pub extern fn EVP_ASYM_CIPHER_up_ref(cipher: ?*EVP_ASYM_CIPHER) c_int;
pub extern fn EVP_ASYM_CIPHER_get0_provider(cipher: ?*const EVP_ASYM_CIPHER) ?*OSSL_PROVIDER;
pub extern fn EVP_ASYM_CIPHER_fetch(ctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_ASYM_CIPHER;
pub extern fn EVP_ASYM_CIPHER_is_a(cipher: ?*const EVP_ASYM_CIPHER, name: [*c]const u8) c_int;
pub extern fn EVP_ASYM_CIPHER_get0_name(cipher: ?*const EVP_ASYM_CIPHER) [*c]const u8;
pub extern fn EVP_ASYM_CIPHER_get0_description(cipher: ?*const EVP_ASYM_CIPHER) [*c]const u8;
pub extern fn EVP_ASYM_CIPHER_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_ASYM_CIPHER, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_ASYM_CIPHER_names_do_all(cipher: ?*const EVP_ASYM_CIPHER, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_ASYM_CIPHER_gettable_ctx_params(ciph: ?*const EVP_ASYM_CIPHER) [*c]const OSSL_PARAM;
pub extern fn EVP_ASYM_CIPHER_settable_ctx_params(ciph: ?*const EVP_ASYM_CIPHER) [*c]const OSSL_PARAM;
pub extern fn EVP_KEM_free(wrap: ?*EVP_KEM) void;
pub extern fn EVP_KEM_up_ref(wrap: ?*EVP_KEM) c_int;
pub extern fn EVP_KEM_get0_provider(wrap: ?*const EVP_KEM) ?*OSSL_PROVIDER;
pub extern fn EVP_KEM_fetch(ctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_KEM;
pub extern fn EVP_KEM_is_a(wrap: ?*const EVP_KEM, name: [*c]const u8) c_int;
pub extern fn EVP_KEM_get0_name(wrap: ?*const EVP_KEM) [*c]const u8;
pub extern fn EVP_KEM_get0_description(wrap: ?*const EVP_KEM) [*c]const u8;
pub extern fn EVP_KEM_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_KEM, ?*anyopaque) callconv(.c) void, arg: ?*anyopaque) void;
pub extern fn EVP_KEM_names_do_all(wrap: ?*const EVP_KEM, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_KEM_gettable_ctx_params(kem: ?*const EVP_KEM) [*c]const OSSL_PARAM;
pub extern fn EVP_KEM_settable_ctx_params(kem: ?*const EVP_KEM) [*c]const OSSL_PARAM;
pub extern fn EVP_PKEY_sign_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_sign_init_ex(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_sign(ctx: ?*EVP_PKEY_CTX, sig: [*c]u8, siglen: [*c]usize, tbs: [*c]const u8, tbslen: usize) c_int;
pub extern fn EVP_PKEY_verify_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_verify_init_ex(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_verify(ctx: ?*EVP_PKEY_CTX, sig: [*c]const u8, siglen: usize, tbs: [*c]const u8, tbslen: usize) c_int;
pub extern fn EVP_PKEY_verify_recover_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_verify_recover_init_ex(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_verify_recover(ctx: ?*EVP_PKEY_CTX, rout: [*c]u8, routlen: [*c]usize, sig: [*c]const u8, siglen: usize) c_int;
pub extern fn EVP_PKEY_encrypt_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_encrypt_init_ex(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_encrypt(ctx: ?*EVP_PKEY_CTX, out: [*c]u8, outlen: [*c]usize, in: [*c]const u8, inlen: usize) c_int;
pub extern fn EVP_PKEY_decrypt_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_decrypt_init_ex(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_decrypt(ctx: ?*EVP_PKEY_CTX, out: [*c]u8, outlen: [*c]usize, in: [*c]const u8, inlen: usize) c_int;
pub extern fn EVP_PKEY_derive_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_derive_init_ex(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_derive_set_peer_ex(ctx: ?*EVP_PKEY_CTX, peer: ?*EVP_PKEY, validate_peer: c_int) c_int;
pub extern fn EVP_PKEY_derive_set_peer(ctx: ?*EVP_PKEY_CTX, peer: ?*EVP_PKEY) c_int;
pub extern fn EVP_PKEY_derive(ctx: ?*EVP_PKEY_CTX, key: [*c]u8, keylen: [*c]usize) c_int;
pub extern fn EVP_PKEY_encapsulate_init(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_encapsulate(ctx: ?*EVP_PKEY_CTX, wrappedkey: [*c]u8, wrappedkeylen: [*c]usize, genkey: [*c]u8, genkeylen: [*c]usize) c_int;
pub extern fn EVP_PKEY_decapsulate_init(ctx: ?*EVP_PKEY_CTX, params: [*c]const OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_decapsulate(ctx: ?*EVP_PKEY_CTX, unwrapped: [*c]u8, unwrappedlen: [*c]usize, wrapped: [*c]const u8, wrappedlen: usize) c_int;
pub const EVP_PKEY_gen_cb = fn (?*EVP_PKEY_CTX) callconv(.c) c_int;
pub extern fn EVP_PKEY_fromdata_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_fromdata(ctx: ?*EVP_PKEY_CTX, ppkey: [*c]?*EVP_PKEY, selection: c_int, param: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_fromdata_settable(ctx: ?*EVP_PKEY_CTX, selection: c_int) [*c]const OSSL_PARAM;
pub extern fn EVP_PKEY_todata(pkey: ?*const EVP_PKEY, selection: c_int, params: [*c][*c]OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_export(pkey: ?*const EVP_PKEY, selection: c_int, export_cb: ?*const OSSL_CALLBACK, export_cbarg: ?*anyopaque) c_int;
pub extern fn EVP_PKEY_gettable_params(pkey: ?*const EVP_PKEY) [*c]const OSSL_PARAM;
pub extern fn EVP_PKEY_get_params(pkey: ?*const EVP_PKEY, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_get_int_param(pkey: ?*const EVP_PKEY, key_name: [*c]const u8, out: [*c]c_int) c_int;
pub extern fn EVP_PKEY_get_size_t_param(pkey: ?*const EVP_PKEY, key_name: [*c]const u8, out: [*c]usize) c_int;
pub extern fn EVP_PKEY_get_bn_param(pkey: ?*const EVP_PKEY, key_name: [*c]const u8, bn: [*c]?*BIGNUM) c_int;
pub extern fn EVP_PKEY_get_utf8_string_param(pkey: ?*const EVP_PKEY, key_name: [*c]const u8, str: [*c]u8, max_buf_sz: usize, out_sz: [*c]usize) c_int;
pub extern fn EVP_PKEY_get_octet_string_param(pkey: ?*const EVP_PKEY, key_name: [*c]const u8, buf: [*c]u8, max_buf_sz: usize, out_sz: [*c]usize) c_int;
pub extern fn EVP_PKEY_settable_params(pkey: ?*const EVP_PKEY) [*c]const OSSL_PARAM;
pub extern fn EVP_PKEY_set_params(pkey: ?*EVP_PKEY, params: [*c]OSSL_PARAM) c_int;
pub extern fn EVP_PKEY_set_int_param(pkey: ?*EVP_PKEY, key_name: [*c]const u8, in: c_int) c_int;
pub extern fn EVP_PKEY_set_size_t_param(pkey: ?*EVP_PKEY, key_name: [*c]const u8, in: usize) c_int;
pub extern fn EVP_PKEY_set_bn_param(pkey: ?*EVP_PKEY, key_name: [*c]const u8, bn: ?*const BIGNUM) c_int;
pub extern fn EVP_PKEY_set_utf8_string_param(pkey: ?*EVP_PKEY, key_name: [*c]const u8, str: [*c]const u8) c_int;
pub extern fn EVP_PKEY_set_octet_string_param(pkey: ?*EVP_PKEY, key_name: [*c]const u8, buf: [*c]const u8, bsize: usize) c_int;
pub extern fn EVP_PKEY_get_ec_point_conv_form(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_get_field_type(pkey: ?*const EVP_PKEY) c_int;
pub extern fn EVP_PKEY_Q_keygen(libctx: ?*OSSL_LIB_CTX, propq: [*c]const u8, @"type": [*c]const u8, ...) ?*EVP_PKEY;
pub extern fn EVP_PKEY_paramgen_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_paramgen(ctx: ?*EVP_PKEY_CTX, ppkey: [*c]?*EVP_PKEY) c_int;
pub extern fn EVP_PKEY_keygen_init(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_keygen(ctx: ?*EVP_PKEY_CTX, ppkey: [*c]?*EVP_PKEY) c_int;
pub extern fn EVP_PKEY_generate(ctx: ?*EVP_PKEY_CTX, ppkey: [*c]?*EVP_PKEY) c_int;
pub extern fn EVP_PKEY_check(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_public_check(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_public_check_quick(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_param_check(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_param_check_quick(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_private_check(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_pairwise_check(ctx: ?*EVP_PKEY_CTX) c_int;
pub extern fn EVP_PKEY_set_ex_data(key: ?*EVP_PKEY, idx: c_int, arg: ?*anyopaque) c_int;
pub extern fn EVP_PKEY_get_ex_data(key: ?*const EVP_PKEY, idx: c_int) ?*anyopaque;
pub extern fn EVP_PKEY_CTX_set_cb(ctx: ?*EVP_PKEY_CTX, cb: ?*const EVP_PKEY_gen_cb) void;
pub extern fn EVP_PKEY_CTX_get_cb(ctx: ?*EVP_PKEY_CTX) ?*const EVP_PKEY_gen_cb;
pub extern fn EVP_PKEY_CTX_get_keygen_info(ctx: ?*EVP_PKEY_CTX, idx: c_int) c_int;
pub extern fn EVP_PKEY_meth_set_init(pmeth: ?*EVP_PKEY_METHOD, init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_copy(pmeth: ?*EVP_PKEY_METHOD, copy: ?*const fn (?*EVP_PKEY_CTX, ?*const EVP_PKEY_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_cleanup(pmeth: ?*EVP_PKEY_METHOD, cleanup: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) void) void;
pub extern fn EVP_PKEY_meth_set_paramgen(pmeth: ?*EVP_PKEY_METHOD, paramgen_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, paramgen: ?*const fn (?*EVP_PKEY_CTX, ?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_keygen(pmeth: ?*EVP_PKEY_METHOD, keygen_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, keygen: ?*const fn (?*EVP_PKEY_CTX, ?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_sign(pmeth: ?*EVP_PKEY_METHOD, sign_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, sign: ?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_verify(pmeth: ?*EVP_PKEY_METHOD, verify_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, verify: ?*const fn (?*EVP_PKEY_CTX, [*c]const u8, usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_verify_recover(pmeth: ?*EVP_PKEY_METHOD, verify_recover_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, verify_recover: ?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_signctx(pmeth: ?*EVP_PKEY_METHOD, signctx_init: ?*const fn (?*EVP_PKEY_CTX, ?*EVP_MD_CTX) callconv(.c) c_int, signctx: ?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, ?*EVP_MD_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_verifyctx(pmeth: ?*EVP_PKEY_METHOD, verifyctx_init: ?*const fn (?*EVP_PKEY_CTX, ?*EVP_MD_CTX) callconv(.c) c_int, verifyctx: ?*const fn (?*EVP_PKEY_CTX, [*c]const u8, c_int, ?*EVP_MD_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_encrypt(pmeth: ?*EVP_PKEY_METHOD, encrypt_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, encryptfn: ?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_decrypt(pmeth: ?*EVP_PKEY_METHOD, decrypt_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, decrypt: ?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_derive(pmeth: ?*EVP_PKEY_METHOD, derive_init: ?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, derive: ?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_ctrl(pmeth: ?*EVP_PKEY_METHOD, ctrl: ?*const fn (?*EVP_PKEY_CTX, c_int, c_int, ?*anyopaque) callconv(.c) c_int, ctrl_str: ?*const fn (?*EVP_PKEY_CTX, [*c]const u8, [*c]const u8) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_digestsign(pmeth: ?*EVP_PKEY_METHOD, digestsign: ?*const fn (?*EVP_MD_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_digestverify(pmeth: ?*EVP_PKEY_METHOD, digestverify: ?*const fn (?*EVP_MD_CTX, [*c]const u8, usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_check(pmeth: ?*EVP_PKEY_METHOD, check: ?*const fn (?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_public_check(pmeth: ?*EVP_PKEY_METHOD, check: ?*const fn (?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_param_check(pmeth: ?*EVP_PKEY_METHOD, check: ?*const fn (?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_set_digest_custom(pmeth: ?*EVP_PKEY_METHOD, digest_custom: ?*const fn (?*EVP_PKEY_CTX, ?*EVP_MD_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_init(pmeth: ?*const EVP_PKEY_METHOD, pinit: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_copy(pmeth: ?*const EVP_PKEY_METHOD, pcopy: [*c]?*const fn (?*EVP_PKEY_CTX, ?*const EVP_PKEY_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_cleanup(pmeth: ?*const EVP_PKEY_METHOD, pcleanup: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) void) void;
pub extern fn EVP_PKEY_meth_get_paramgen(pmeth: ?*const EVP_PKEY_METHOD, pparamgen_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, pparamgen: [*c]?*const fn (?*EVP_PKEY_CTX, ?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_keygen(pmeth: ?*const EVP_PKEY_METHOD, pkeygen_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, pkeygen: [*c]?*const fn (?*EVP_PKEY_CTX, ?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_sign(pmeth: ?*const EVP_PKEY_METHOD, psign_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, psign: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_verify(pmeth: ?*const EVP_PKEY_METHOD, pverify_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, pverify: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]const u8, usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_verify_recover(pmeth: ?*const EVP_PKEY_METHOD, pverify_recover_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, pverify_recover: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_signctx(pmeth: ?*const EVP_PKEY_METHOD, psignctx_init: [*c]?*const fn (?*EVP_PKEY_CTX, ?*EVP_MD_CTX) callconv(.c) c_int, psignctx: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, ?*EVP_MD_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_verifyctx(pmeth: ?*const EVP_PKEY_METHOD, pverifyctx_init: [*c]?*const fn (?*EVP_PKEY_CTX, ?*EVP_MD_CTX) callconv(.c) c_int, pverifyctx: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]const u8, c_int, ?*EVP_MD_CTX) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_encrypt(pmeth: ?*const EVP_PKEY_METHOD, pencrypt_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, pencryptfn: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_decrypt(pmeth: ?*const EVP_PKEY_METHOD, pdecrypt_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, pdecrypt: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_derive(pmeth: ?*const EVP_PKEY_METHOD, pderive_init: [*c]?*const fn (?*EVP_PKEY_CTX) callconv(.c) c_int, pderive: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]u8, [*c]usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_ctrl(pmeth: ?*const EVP_PKEY_METHOD, pctrl: [*c]?*const fn (?*EVP_PKEY_CTX, c_int, c_int, ?*anyopaque) callconv(.c) c_int, pctrl_str: [*c]?*const fn (?*EVP_PKEY_CTX, [*c]const u8, [*c]const u8) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_digestsign(pmeth: ?*const EVP_PKEY_METHOD, digestsign: [*c]?*const fn (?*EVP_MD_CTX, [*c]u8, [*c]usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_digestverify(pmeth: ?*const EVP_PKEY_METHOD, digestverify: [*c]?*const fn (?*EVP_MD_CTX, [*c]const u8, usize, [*c]const u8, usize) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_check(pmeth: ?*const EVP_PKEY_METHOD, pcheck: [*c]?*const fn (?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_public_check(pmeth: ?*const EVP_PKEY_METHOD, pcheck: [*c]?*const fn (?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_param_check(pmeth: ?*const EVP_PKEY_METHOD, pcheck: [*c]?*const fn (?*EVP_PKEY) callconv(.c) c_int) void;
pub extern fn EVP_PKEY_meth_get_digest_custom(pmeth: ?*const EVP_PKEY_METHOD, pdigest_custom: [*c]?*const fn (?*EVP_PKEY_CTX, ?*EVP_MD_CTX) callconv(.c) c_int) void;
pub extern fn EVP_KEYEXCH_free(exchange: ?*EVP_KEYEXCH) void;
pub extern fn EVP_KEYEXCH_up_ref(exchange: ?*EVP_KEYEXCH) c_int;
pub extern fn EVP_KEYEXCH_fetch(ctx: ?*OSSL_LIB_CTX, algorithm: [*c]const u8, properties: [*c]const u8) ?*EVP_KEYEXCH;
pub extern fn EVP_KEYEXCH_get0_provider(exchange: ?*const EVP_KEYEXCH) ?*OSSL_PROVIDER;
pub extern fn EVP_KEYEXCH_is_a(keyexch: ?*const EVP_KEYEXCH, name: [*c]const u8) c_int;
pub extern fn EVP_KEYEXCH_get0_name(keyexch: ?*const EVP_KEYEXCH) [*c]const u8;
pub extern fn EVP_KEYEXCH_get0_description(keyexch: ?*const EVP_KEYEXCH) [*c]const u8;
pub extern fn EVP_KEYEXCH_do_all_provided(libctx: ?*OSSL_LIB_CTX, @"fn": ?*const fn (?*EVP_KEYEXCH, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) void;
pub extern fn EVP_KEYEXCH_names_do_all(keyexch: ?*const EVP_KEYEXCH, @"fn": ?*const fn ([*c]const u8, ?*anyopaque) callconv(.c) void, data: ?*anyopaque) c_int;
pub extern fn EVP_KEYEXCH_gettable_ctx_params(keyexch: ?*const EVP_KEYEXCH) [*c]const OSSL_PARAM;
pub extern fn EVP_KEYEXCH_settable_ctx_params(keyexch: ?*const EVP_KEYEXCH) [*c]const OSSL_PARAM;
pub extern fn EVP_add_alg_module() void;
pub extern fn EVP_PKEY_CTX_set_group_name(ctx: ?*EVP_PKEY_CTX, name: [*c]const u8) c_int;
pub extern fn EVP_PKEY_CTX_get_group_name(ctx: ?*EVP_PKEY_CTX, name: [*c]u8, namelen: usize) c_int;
pub extern fn EVP_PKEY_get_group_name(pkey: ?*const EVP_PKEY, name: [*c]u8, name_sz: usize, gname_len: [*c]usize) c_int;
pub extern fn EVP_PKEY_CTX_get0_libctx(ctx: ?*EVP_PKEY_CTX) ?*OSSL_LIB_CTX;
pub extern fn EVP_PKEY_CTX_get0_propq(ctx: ?*const EVP_PKEY_CTX) [*c]const u8;
pub extern fn EVP_PKEY_CTX_get0_provider(ctx: ?*const EVP_PKEY_CTX) ?*const OSSL_PROVIDER;
pub const __llvm__ = @as(c_int, 1);
pub const __clang__ = @as(c_int, 1);
pub const __clang_major__ = @as(c_int, 20);
pub const __clang_minor__ = @as(c_int, 1);
pub const __clang_patchlevel__ = @as(c_int, 2);
pub const __clang_version__ = "20.1.2 (https://github.com/ziglang/zig-bootstrap c6bc9398c72c7a63fe9420a9055dcfd1845bc266)";
pub const __GNUC__ = @as(c_int, 4);
pub const __GNUC_MINOR__ = @as(c_int, 2);
pub const __GNUC_PATCHLEVEL__ = @as(c_int, 1);
pub const __GXX_ABI_VERSION = @as(c_int, 1002);
pub const __ATOMIC_RELAXED = @as(c_int, 0);
pub const __ATOMIC_CONSUME = @as(c_int, 1);
pub const __ATOMIC_ACQUIRE = @as(c_int, 2);
pub const __ATOMIC_RELEASE = @as(c_int, 3);
pub const __ATOMIC_ACQ_REL = @as(c_int, 4);
pub const __ATOMIC_SEQ_CST = @as(c_int, 5);
pub const __MEMORY_SCOPE_SYSTEM = @as(c_int, 0);
pub const __MEMORY_SCOPE_DEVICE = @as(c_int, 1);
pub const __MEMORY_SCOPE_WRKGRP = @as(c_int, 2);
pub const __MEMORY_SCOPE_WVFRNT = @as(c_int, 3);
pub const __MEMORY_SCOPE_SINGLE = @as(c_int, 4);
pub const __OPENCL_MEMORY_SCOPE_WORK_ITEM = @as(c_int, 0);
pub const __OPENCL_MEMORY_SCOPE_WORK_GROUP = @as(c_int, 1);
pub const __OPENCL_MEMORY_SCOPE_DEVICE = @as(c_int, 2);
pub const __OPENCL_MEMORY_SCOPE_ALL_SVM_DEVICES = @as(c_int, 3);
pub const __OPENCL_MEMORY_SCOPE_SUB_GROUP = @as(c_int, 4);
pub const __FPCLASS_SNAN = @as(c_int, 0x0001);
pub const __FPCLASS_QNAN = @as(c_int, 0x0002);
pub const __FPCLASS_NEGINF = @as(c_int, 0x0004);
pub const __FPCLASS_NEGNORMAL = @as(c_int, 0x0008);
pub const __FPCLASS_NEGSUBNORMAL = @as(c_int, 0x0010);
pub const __FPCLASS_NEGZERO = @as(c_int, 0x0020);
pub const __FPCLASS_POSZERO = @as(c_int, 0x0040);
pub const __FPCLASS_POSSUBNORMAL = @as(c_int, 0x0080);
pub const __FPCLASS_POSNORMAL = @as(c_int, 0x0100);
pub const __FPCLASS_POSINF = @as(c_int, 0x0200);
pub const __PRAGMA_REDEFINE_EXTNAME = @as(c_int, 1);
pub const __VERSION__ = "Clang 20.1.2 (https://github.com/ziglang/zig-bootstrap c6bc9398c72c7a63fe9420a9055dcfd1845bc266)";
pub const __OBJC_BOOL_IS_BOOL = @as(c_int, 0);
pub const __CONSTANT_CFSTRINGS__ = @as(c_int, 1);
pub const __clang_literal_encoding__ = "UTF-8";
pub const __clang_wide_literal_encoding__ = "UTF-32";
pub const __ORDER_LITTLE_ENDIAN__ = @as(c_int, 1234);
pub const __ORDER_BIG_ENDIAN__ = @as(c_int, 4321);
pub const __ORDER_PDP_ENDIAN__ = @as(c_int, 3412);
pub const __BYTE_ORDER__ = __ORDER_LITTLE_ENDIAN__;
pub const __LITTLE_ENDIAN__ = @as(c_int, 1);
pub const _LP64 = @as(c_int, 1);
pub const __LP64__ = @as(c_int, 1);
pub const __CHAR_BIT__ = @as(c_int, 8);
pub const __BOOL_WIDTH__ = @as(c_int, 1);
pub const __SHRT_WIDTH__ = @as(c_int, 16);
pub const __INT_WIDTH__ = @as(c_int, 32);
pub const __LONG_WIDTH__ = @as(c_int, 64);
pub const __LLONG_WIDTH__ = @as(c_int, 64);
pub const __BITINT_MAXWIDTH__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 8388608, .decimal);
pub const __SCHAR_MAX__ = @as(c_int, 127);
pub const __SHRT_MAX__ = @as(c_int, 32767);
pub const __INT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __LONG_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __LONG_LONG_MAX__ = @as(c_longlong, 9223372036854775807);
pub const __WCHAR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __WCHAR_WIDTH__ = @as(c_int, 32);
pub const __WINT_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __WINT_WIDTH__ = @as(c_int, 32);
pub const __INTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTMAX_WIDTH__ = @as(c_int, 64);
pub const __SIZE_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __SIZE_WIDTH__ = @as(c_int, 64);
pub const __UINTMAX_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTMAX_WIDTH__ = @as(c_int, 64);
pub const __PTRDIFF_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __PTRDIFF_WIDTH__ = @as(c_int, 64);
pub const __INTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INTPTR_WIDTH__ = @as(c_int, 64);
pub const __UINTPTR_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINTPTR_WIDTH__ = @as(c_int, 64);
pub const __SIZEOF_DOUBLE__ = @as(c_int, 8);
pub const __SIZEOF_FLOAT__ = @as(c_int, 4);
pub const __SIZEOF_INT__ = @as(c_int, 4);
pub const __SIZEOF_LONG__ = @as(c_int, 8);
pub const __SIZEOF_LONG_DOUBLE__ = @as(c_int, 16);
pub const __SIZEOF_LONG_LONG__ = @as(c_int, 8);
pub const __SIZEOF_POINTER__ = @as(c_int, 8);
pub const __SIZEOF_SHORT__ = @as(c_int, 2);
pub const __SIZEOF_PTRDIFF_T__ = @as(c_int, 8);
pub const __SIZEOF_SIZE_T__ = @as(c_int, 8);
pub const __SIZEOF_WCHAR_T__ = @as(c_int, 4);
pub const __SIZEOF_WINT_T__ = @as(c_int, 4);
pub const __SIZEOF_INT128__ = @as(c_int, 16);
pub const __INTMAX_TYPE__ = c_long;
pub const __INTMAX_FMTd__ = "ld";
pub const __INTMAX_FMTi__ = "li";
pub const __INTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// (no file):95:9
pub const __INTMAX_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const __UINTMAX_TYPE__ = c_ulong;
pub const __UINTMAX_FMTo__ = "lo";
pub const __UINTMAX_FMTu__ = "lu";
pub const __UINTMAX_FMTx__ = "lx";
pub const __UINTMAX_FMTX__ = "lX";
pub const __UINTMAX_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// (no file):102:9
pub const __UINTMAX_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const __PTRDIFF_TYPE__ = c_long;
pub const __PTRDIFF_FMTd__ = "ld";
pub const __PTRDIFF_FMTi__ = "li";
pub const __INTPTR_TYPE__ = c_long;
pub const __INTPTR_FMTd__ = "ld";
pub const __INTPTR_FMTi__ = "li";
pub const __SIZE_TYPE__ = c_ulong;
pub const __SIZE_FMTo__ = "lo";
pub const __SIZE_FMTu__ = "lu";
pub const __SIZE_FMTx__ = "lx";
pub const __SIZE_FMTX__ = "lX";
pub const __WCHAR_TYPE__ = c_int;
pub const __WINT_TYPE__ = c_uint;
pub const __SIG_ATOMIC_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __SIG_ATOMIC_WIDTH__ = @as(c_int, 32);
pub const __CHAR16_TYPE__ = c_ushort;
pub const __CHAR32_TYPE__ = c_uint;
pub const __UINTPTR_TYPE__ = c_ulong;
pub const __UINTPTR_FMTo__ = "lo";
pub const __UINTPTR_FMTu__ = "lu";
pub const __UINTPTR_FMTx__ = "lx";
pub const __UINTPTR_FMTX__ = "lX";
pub const __FLT16_DENORM_MIN__ = @as(f16, 5.9604644775390625e-8);
pub const __FLT16_NORM_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT16_DIG__ = @as(c_int, 3);
pub const __FLT16_DECIMAL_DIG__ = @as(c_int, 5);
pub const __FLT16_EPSILON__ = @as(f16, 9.765625e-4);
pub const __FLT16_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT16_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT16_MANT_DIG__ = @as(c_int, 11);
pub const __FLT16_MAX_10_EXP__ = @as(c_int, 4);
pub const __FLT16_MAX_EXP__ = @as(c_int, 16);
pub const __FLT16_MAX__ = @as(f16, 6.5504e+4);
pub const __FLT16_MIN_10_EXP__ = -@as(c_int, 4);
pub const __FLT16_MIN_EXP__ = -@as(c_int, 13);
pub const __FLT16_MIN__ = @as(f16, 6.103515625e-5);
pub const __FLT_DENORM_MIN__ = @as(f32, 1.40129846e-45);
pub const __FLT_NORM_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_HAS_DENORM__ = @as(c_int, 1);
pub const __FLT_DIG__ = @as(c_int, 6);
pub const __FLT_DECIMAL_DIG__ = @as(c_int, 9);
pub const __FLT_EPSILON__ = @as(f32, 1.19209290e-7);
pub const __FLT_HAS_INFINITY__ = @as(c_int, 1);
pub const __FLT_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __FLT_MANT_DIG__ = @as(c_int, 24);
pub const __FLT_MAX_10_EXP__ = @as(c_int, 38);
pub const __FLT_MAX_EXP__ = @as(c_int, 128);
pub const __FLT_MAX__ = @as(f32, 3.40282347e+38);
pub const __FLT_MIN_10_EXP__ = -@as(c_int, 37);
pub const __FLT_MIN_EXP__ = -@as(c_int, 125);
pub const __FLT_MIN__ = @as(f32, 1.17549435e-38);
pub const __DBL_DENORM_MIN__ = @as(f64, 4.9406564584124654e-324);
pub const __DBL_NORM_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_HAS_DENORM__ = @as(c_int, 1);
pub const __DBL_DIG__ = @as(c_int, 15);
pub const __DBL_DECIMAL_DIG__ = @as(c_int, 17);
pub const __DBL_EPSILON__ = @as(f64, 2.2204460492503131e-16);
pub const __DBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __DBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __DBL_MANT_DIG__ = @as(c_int, 53);
pub const __DBL_MAX_10_EXP__ = @as(c_int, 308);
pub const __DBL_MAX_EXP__ = @as(c_int, 1024);
pub const __DBL_MAX__ = @as(f64, 1.7976931348623157e+308);
pub const __DBL_MIN_10_EXP__ = -@as(c_int, 307);
pub const __DBL_MIN_EXP__ = -@as(c_int, 1021);
pub const __DBL_MIN__ = @as(f64, 2.2250738585072014e-308);
pub const __LDBL_DENORM_MIN__ = @as(c_longdouble, 3.64519953188247460253e-4951);
pub const __LDBL_NORM_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_HAS_DENORM__ = @as(c_int, 1);
pub const __LDBL_DIG__ = @as(c_int, 18);
pub const __LDBL_DECIMAL_DIG__ = @as(c_int, 21);
pub const __LDBL_EPSILON__ = @as(c_longdouble, 1.08420217248550443401e-19);
pub const __LDBL_HAS_INFINITY__ = @as(c_int, 1);
pub const __LDBL_HAS_QUIET_NAN__ = @as(c_int, 1);
pub const __LDBL_MANT_DIG__ = @as(c_int, 64);
pub const __LDBL_MAX_10_EXP__ = @as(c_int, 4932);
pub const __LDBL_MAX_EXP__ = @as(c_int, 16384);
pub const __LDBL_MAX__ = @as(c_longdouble, 1.18973149535723176502e+4932);
pub const __LDBL_MIN_10_EXP__ = -@as(c_int, 4931);
pub const __LDBL_MIN_EXP__ = -@as(c_int, 16381);
pub const __LDBL_MIN__ = @as(c_longdouble, 3.36210314311209350626e-4932);
pub const __POINTER_WIDTH__ = @as(c_int, 64);
pub const __BIGGEST_ALIGNMENT__ = @as(c_int, 16);
pub const __WINT_UNSIGNED__ = @as(c_int, 1);
pub const __INT8_TYPE__ = i8;
pub const __INT8_FMTd__ = "hhd";
pub const __INT8_FMTi__ = "hhi";
pub const __INT8_C_SUFFIX__ = "";
pub inline fn __INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT16_TYPE__ = c_short;
pub const __INT16_FMTd__ = "hd";
pub const __INT16_FMTi__ = "hi";
pub const __INT16_C_SUFFIX__ = "";
pub inline fn __INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT32_TYPE__ = c_int;
pub const __INT32_FMTd__ = "d";
pub const __INT32_FMTi__ = "i";
pub const __INT32_C_SUFFIX__ = "";
pub inline fn __INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __INT64_TYPE__ = c_long;
pub const __INT64_FMTd__ = "ld";
pub const __INT64_FMTi__ = "li";
pub const __INT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `L`");
// (no file):207:9
pub const __INT64_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const __UINT8_TYPE__ = u8;
pub const __UINT8_FMTo__ = "hho";
pub const __UINT8_FMTu__ = "hhu";
pub const __UINT8_FMTx__ = "hhx";
pub const __UINT8_FMTX__ = "hhX";
pub const __UINT8_C_SUFFIX__ = "";
pub inline fn __UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT8_MAX__ = @as(c_int, 255);
pub const __INT8_MAX__ = @as(c_int, 127);
pub const __UINT16_TYPE__ = c_ushort;
pub const __UINT16_FMTo__ = "ho";
pub const __UINT16_FMTu__ = "hu";
pub const __UINT16_FMTx__ = "hx";
pub const __UINT16_FMTX__ = "hX";
pub const __UINT16_C_SUFFIX__ = "";
pub inline fn __UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const __UINT16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __INT16_MAX__ = @as(c_int, 32767);
pub const __UINT32_TYPE__ = c_uint;
pub const __UINT32_FMTo__ = "o";
pub const __UINT32_FMTu__ = "u";
pub const __UINT32_FMTx__ = "x";
pub const __UINT32_FMTX__ = "X";
pub const __UINT32_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `U`");
// (no file):232:9
pub const __UINT32_C = @import("std").zig.c_translation.Macros.U_SUFFIX;
pub const __UINT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __INT32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __UINT64_TYPE__ = c_ulong;
pub const __UINT64_FMTo__ = "lo";
pub const __UINT64_FMTu__ = "lu";
pub const __UINT64_FMTx__ = "lx";
pub const __UINT64_FMTX__ = "lX";
pub const __UINT64_C_SUFFIX__ = @compileError("unable to translate macro: undefined identifier `UL`");
// (no file):241:9
pub const __UINT64_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const __UINT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __INT64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST8_TYPE__ = i8;
pub const __INT_LEAST8_MAX__ = @as(c_int, 127);
pub const __INT_LEAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_LEAST8_FMTd__ = "hhd";
pub const __INT_LEAST8_FMTi__ = "hhi";
pub const __UINT_LEAST8_TYPE__ = u8;
pub const __UINT_LEAST8_MAX__ = @as(c_int, 255);
pub const __UINT_LEAST8_FMTo__ = "hho";
pub const __UINT_LEAST8_FMTu__ = "hhu";
pub const __UINT_LEAST8_FMTx__ = "hhx";
pub const __UINT_LEAST8_FMTX__ = "hhX";
pub const __INT_LEAST16_TYPE__ = c_short;
pub const __INT_LEAST16_MAX__ = @as(c_int, 32767);
pub const __INT_LEAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_LEAST16_FMTd__ = "hd";
pub const __INT_LEAST16_FMTi__ = "hi";
pub const __UINT_LEAST16_TYPE__ = c_ushort;
pub const __UINT_LEAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_LEAST16_FMTo__ = "ho";
pub const __UINT_LEAST16_FMTu__ = "hu";
pub const __UINT_LEAST16_FMTx__ = "hx";
pub const __UINT_LEAST16_FMTX__ = "hX";
pub const __INT_LEAST32_TYPE__ = c_int;
pub const __INT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_LEAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_LEAST32_FMTd__ = "d";
pub const __INT_LEAST32_FMTi__ = "i";
pub const __UINT_LEAST32_TYPE__ = c_uint;
pub const __UINT_LEAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_LEAST32_FMTo__ = "o";
pub const __UINT_LEAST32_FMTu__ = "u";
pub const __UINT_LEAST32_FMTx__ = "x";
pub const __UINT_LEAST32_FMTX__ = "X";
pub const __INT_LEAST64_TYPE__ = c_long;
pub const __INT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_LEAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_LEAST64_FMTd__ = "ld";
pub const __INT_LEAST64_FMTi__ = "li";
pub const __UINT_LEAST64_TYPE__ = c_ulong;
pub const __UINT_LEAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_LEAST64_FMTo__ = "lo";
pub const __UINT_LEAST64_FMTu__ = "lu";
pub const __UINT_LEAST64_FMTx__ = "lx";
pub const __UINT_LEAST64_FMTX__ = "lX";
pub const __INT_FAST8_TYPE__ = i8;
pub const __INT_FAST8_MAX__ = @as(c_int, 127);
pub const __INT_FAST8_WIDTH__ = @as(c_int, 8);
pub const __INT_FAST8_FMTd__ = "hhd";
pub const __INT_FAST8_FMTi__ = "hhi";
pub const __UINT_FAST8_TYPE__ = u8;
pub const __UINT_FAST8_MAX__ = @as(c_int, 255);
pub const __UINT_FAST8_FMTo__ = "hho";
pub const __UINT_FAST8_FMTu__ = "hhu";
pub const __UINT_FAST8_FMTx__ = "hhx";
pub const __UINT_FAST8_FMTX__ = "hhX";
pub const __INT_FAST16_TYPE__ = c_short;
pub const __INT_FAST16_MAX__ = @as(c_int, 32767);
pub const __INT_FAST16_WIDTH__ = @as(c_int, 16);
pub const __INT_FAST16_FMTd__ = "hd";
pub const __INT_FAST16_FMTi__ = "hi";
pub const __UINT_FAST16_TYPE__ = c_ushort;
pub const __UINT_FAST16_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const __UINT_FAST16_FMTo__ = "ho";
pub const __UINT_FAST16_FMTu__ = "hu";
pub const __UINT_FAST16_FMTx__ = "hx";
pub const __UINT_FAST16_FMTX__ = "hX";
pub const __INT_FAST32_TYPE__ = c_int;
pub const __INT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const __INT_FAST32_WIDTH__ = @as(c_int, 32);
pub const __INT_FAST32_FMTd__ = "d";
pub const __INT_FAST32_FMTi__ = "i";
pub const __UINT_FAST32_TYPE__ = c_uint;
pub const __UINT_FAST32_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const __UINT_FAST32_FMTo__ = "o";
pub const __UINT_FAST32_FMTu__ = "u";
pub const __UINT_FAST32_FMTx__ = "x";
pub const __UINT_FAST32_FMTX__ = "X";
pub const __INT_FAST64_TYPE__ = c_long;
pub const __INT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const __INT_FAST64_WIDTH__ = @as(c_int, 64);
pub const __INT_FAST64_FMTd__ = "ld";
pub const __INT_FAST64_FMTi__ = "li";
pub const __UINT_FAST64_TYPE__ = c_ulong;
pub const __UINT_FAST64_MAX__ = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const __UINT_FAST64_FMTo__ = "lo";
pub const __UINT_FAST64_FMTu__ = "lu";
pub const __UINT_FAST64_FMTx__ = "lx";
pub const __UINT_FAST64_FMTX__ = "lX";
pub const __USER_LABEL_PREFIX__ = "";
pub const __FINITE_MATH_ONLY__ = @as(c_int, 0);
pub const __GNUC_STDC_INLINE__ = @as(c_int, 1);
pub const __GCC_ATOMIC_TEST_AND_SET_TRUEVAL = @as(c_int, 1);
pub const __GCC_DESTRUCTIVE_SIZE = @as(c_int, 64);
pub const __GCC_CONSTRUCTIVE_SIZE = @as(c_int, 64);
pub const __CLANG_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __CLANG_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_BOOL_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR16_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_CHAR32_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_WCHAR_T_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_SHORT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_INT_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_LLONG_LOCK_FREE = @as(c_int, 2);
pub const __GCC_ATOMIC_POINTER_LOCK_FREE = @as(c_int, 2);
pub const __NO_INLINE__ = @as(c_int, 1);
pub const __PIC__ = @as(c_int, 2);
pub const __pic__ = @as(c_int, 2);
pub const __FLT_RADIX__ = @as(c_int, 2);
pub const __DECIMAL_DIG__ = __LDBL_DECIMAL_DIG__;
pub const __ELF__ = @as(c_int, 1);
pub const __GCC_ASM_FLAG_OUTPUTS__ = @as(c_int, 1);
pub const __code_model_small__ = @as(c_int, 1);
pub const __amd64__ = @as(c_int, 1);
pub const __amd64 = @as(c_int, 1);
pub const __x86_64 = @as(c_int, 1);
pub const __x86_64__ = @as(c_int, 1);
pub const __SEG_GS = @as(c_int, 1);
pub const __SEG_FS = @as(c_int, 1);
pub const __seg_gs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):375:9
pub const __seg_fs = @compileError("unable to translate macro: undefined identifier `address_space`");
// (no file):376:9
pub const __znver2 = @as(c_int, 1);
pub const __znver2__ = @as(c_int, 1);
pub const __tune_znver2__ = @as(c_int, 1);
pub const __REGISTER_PREFIX__ = "";
pub const __NO_MATH_INLINES = @as(c_int, 1);
pub const __AES__ = @as(c_int, 1);
pub const __PCLMUL__ = @as(c_int, 1);
pub const __LAHF_SAHF__ = @as(c_int, 1);
pub const __LZCNT__ = @as(c_int, 1);
pub const __RDRND__ = @as(c_int, 1);
pub const __FSGSBASE__ = @as(c_int, 1);
pub const __BMI__ = @as(c_int, 1);
pub const __BMI2__ = @as(c_int, 1);
pub const __POPCNT__ = @as(c_int, 1);
pub const __PRFCHW__ = @as(c_int, 1);
pub const __RDSEED__ = @as(c_int, 1);
pub const __ADX__ = @as(c_int, 1);
pub const __MWAITX__ = @as(c_int, 1);
pub const __MOVBE__ = @as(c_int, 1);
pub const __SSE4A__ = @as(c_int, 1);
pub const __FMA__ = @as(c_int, 1);
pub const __F16C__ = @as(c_int, 1);
pub const __SHA__ = @as(c_int, 1);
pub const __FXSR__ = @as(c_int, 1);
pub const __XSAVE__ = @as(c_int, 1);
pub const __XSAVEOPT__ = @as(c_int, 1);
pub const __XSAVEC__ = @as(c_int, 1);
pub const __XSAVES__ = @as(c_int, 1);
pub const __CLFLUSHOPT__ = @as(c_int, 1);
pub const __CLWB__ = @as(c_int, 1);
pub const __WBNOINVD__ = @as(c_int, 1);
pub const __CLZERO__ = @as(c_int, 1);
pub const __RDPID__ = @as(c_int, 1);
pub const __RDPRU__ = @as(c_int, 1);
pub const __CRC32__ = @as(c_int, 1);
pub const __AVX2__ = @as(c_int, 1);
pub const __AVX__ = @as(c_int, 1);
pub const __SSE4_2__ = @as(c_int, 1);
pub const __SSE4_1__ = @as(c_int, 1);
pub const __SSSE3__ = @as(c_int, 1);
pub const __SSE3__ = @as(c_int, 1);
pub const __SSE2__ = @as(c_int, 1);
pub const __SSE2_MATH__ = @as(c_int, 1);
pub const __SSE__ = @as(c_int, 1);
pub const __SSE_MATH__ = @as(c_int, 1);
pub const __MMX__ = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 = @as(c_int, 1);
pub const __GCC_HAVE_SYNC_COMPARE_AND_SWAP_16 = @as(c_int, 1);
pub const __SIZEOF_FLOAT128__ = @as(c_int, 16);
pub const unix = @as(c_int, 1);
pub const __unix = @as(c_int, 1);
pub const __unix__ = @as(c_int, 1);
pub const linux = @as(c_int, 1);
pub const __linux = @as(c_int, 1);
pub const __linux__ = @as(c_int, 1);
pub const __gnu_linux__ = @as(c_int, 1);
pub const __FLOAT128__ = @as(c_int, 1);
pub const __STDC__ = @as(c_int, 1);
pub const __STDC_HOSTED__ = @as(c_int, 1);
pub const __STDC_VERSION__ = @as(c_long, 201710);
pub const __STDC_UTF_16__ = @as(c_int, 1);
pub const __STDC_UTF_32__ = @as(c_int, 1);
pub const __STDC_EMBED_NOT_FOUND__ = @as(c_int, 0);
pub const __STDC_EMBED_FOUND__ = @as(c_int, 1);
pub const __STDC_EMBED_EMPTY__ = @as(c_int, 2);
pub const __GLIBC_MINOR__ = @as(c_int, 39);
pub const __GCC_HAVE_DWARF2_CFI_ASM = @as(c_int, 1);
pub const OPENSSL_SHA_H = "";
pub const OPENSSL_MACROS_H = "";
pub const OPENSSL_OPENSSLCONF_H = "";
pub const OPENSSL_CONFIGURATION_H = "";
pub const OPENSSL_CONFIGURED_API = @as(c_int, 30000);
pub const OPENSSL_RAND_SEED_OS = "";
pub const OPENSSL_THREADS = "";
pub const OPENSSL_NO_ACVP_TESTS = "";
pub const OPENSSL_NO_ASAN = "";
pub const OPENSSL_NO_CAPIENG = "";
pub const OPENSSL_NO_CRYPTO_MDEBUG = "";
pub const OPENSSL_NO_CRYPTO_MDEBUG_BACKTRACE = "";
pub const OPENSSL_NO_DEVCRYPTOENG = "";
pub const OPENSSL_NO_EGD = "";
pub const OPENSSL_NO_EXTERNAL_TESTS = "";
pub const OPENSSL_NO_FIPS_SECURITYCHECKS = "";
pub const OPENSSL_NO_FUZZ_AFL = "";
pub const OPENSSL_NO_FUZZ_LIBFUZZER = "";
pub const OPENSSL_NO_HEARTBEATS = "";
pub const OPENSSL_NO_IDEA = "";
pub const OPENSSL_NO_MD2 = "";
pub const OPENSSL_NO_MDC2 = "";
pub const OPENSSL_NO_MSAN = "";
pub const OPENSSL_NO_RC5 = "";
pub const OPENSSL_NO_RDRAND = "";
pub const OPENSSL_NO_SCTP = "";
pub const OPENSSL_NO_SSL3 = "";
pub const OPENSSL_NO_SSL3_METHOD = "";
pub const OPENSSL_NO_TRACE = "";
pub const OPENSSL_NO_UBSAN = "";
pub const OPENSSL_NO_UPLINK = "";
pub const OPENSSL_NO_WEAK_SSL_CIPHERS = "";
pub const OPENSSL_NO_STATIC_ENGINE = "";
pub const SIXTY_FOUR_BIT_LONG = "";
pub const RC4_INT = c_uint;
pub const OPENSSL_OPENSSLV_H = "";
pub const OPENSSL_VERSION_MAJOR = @as(c_int, 3);
pub const OPENSSL_VERSION_MINOR = @as(c_int, 0);
pub const OPENSSL_VERSION_PATCH = @as(c_int, 13);
pub const OPENSSL_VERSION_PRE_RELEASE = "";
pub const OPENSSL_VERSION_BUILD_METADATA = "";
pub const OPENSSL_SHLIB_VERSION = @as(c_int, 3);
pub inline fn OPENSSL_VERSION_PREREQ(maj: anytype, min: anytype) @TypeOf(((OPENSSL_VERSION_MAJOR << @as(c_int, 16)) + OPENSSL_VERSION_MINOR) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((OPENSSL_VERSION_MAJOR << @as(c_int, 16)) + OPENSSL_VERSION_MINOR) >= ((maj << @as(c_int, 16)) + min);
}
pub const OPENSSL_VERSION_STR = "3.0.13";
pub const OPENSSL_FULL_VERSION_STR = "3.0.13";
pub const OPENSSL_RELEASE_DATE = "30 Jan 2024";
pub const OPENSSL_VERSION_TEXT = "OpenSSL 3.0.13 30 Jan 2024";
pub const _OPENSSL_VERSION_PRE_RELEASE = @as(c_long, 0x0);
pub const OPENSSL_VERSION_NUMBER = (((OPENSSL_VERSION_MAJOR << @as(c_int, 28)) | (OPENSSL_VERSION_MINOR << @as(c_int, 20))) | (OPENSSL_VERSION_PATCH << @as(c_int, 4))) | _OPENSSL_VERSION_PRE_RELEASE;
pub const HEADER_OPENSSLV_H = "";
pub const OPENSSL_MSTR_HELPER = @compileError("unable to translate C expr: unexpected token '#'");
// /usr/include/openssl/macros.h:19:10
pub inline fn OPENSSL_MSTR(x: anytype) @TypeOf(OPENSSL_MSTR_HELPER(x)) {
    _ = &x;
    return OPENSSL_MSTR_HELPER(x);
}
pub const NON_EMPTY_TRANSLATION_UNIT = @compileError("unable to translate macro: undefined identifier `dummy`");
// /usr/include/openssl/macros.h:26:10
pub const OSSL_DEPRECATED = @compileError("unable to translate macro: undefined identifier `deprecated`");
// /usr/include/openssl/macros.h:62:14
pub const OSSL_DEPRECATED_FOR = @compileError("unable to translate macro: undefined identifier `deprecated`");
// /usr/include/openssl/macros.h:63:14
pub const OPENSSL_API_LEVEL = OPENSSL_CONFIGURED_API;
pub const OSSL_DEPRECATEDIN_3_0 = OSSL_DEPRECATED(@as(f64, 3.0));
pub inline fn OSSL_DEPRECATEDIN_3_0_FOR(msg: anytype) @TypeOf(OSSL_DEPRECATED_FOR(@as(f64, 3.0), msg)) {
    _ = &msg;
    return OSSL_DEPRECATED_FOR(@as(f64, 3.0), msg);
}
pub const OSSL_DEPRECATEDIN_1_1_1 = @compileError("invalid number suffix: '.1'");
// /usr/include/openssl/macros.h:193:12
pub const OSSL_DEPRECATEDIN_1_1_1_FOR = @compileError("invalid number suffix: '.1'");
// /usr/include/openssl/macros.h:194:12
pub const OSSL_DEPRECATEDIN_1_1_0 = @compileError("invalid number suffix: '.0'");
// /usr/include/openssl/macros.h:204:12
pub const OSSL_DEPRECATEDIN_1_1_0_FOR = @compileError("invalid number suffix: '.0'");
// /usr/include/openssl/macros.h:205:12
pub const OSSL_DEPRECATEDIN_1_0_2 = @compileError("invalid number suffix: '.2'");
// /usr/include/openssl/macros.h:215:12
pub const OSSL_DEPRECATEDIN_1_0_2_FOR = @compileError("invalid number suffix: '.2'");
// /usr/include/openssl/macros.h:216:12
pub const OSSL_DEPRECATEDIN_1_0_1 = @compileError("invalid number suffix: '.1'");
// /usr/include/openssl/macros.h:226:12
pub const OSSL_DEPRECATEDIN_1_0_1_FOR = @compileError("invalid number suffix: '.1'");
// /usr/include/openssl/macros.h:227:12
pub const OSSL_DEPRECATEDIN_1_0_0 = @compileError("invalid number suffix: '.0'");
// /usr/include/openssl/macros.h:237:12
pub const OSSL_DEPRECATEDIN_1_0_0_FOR = @compileError("invalid number suffix: '.0'");
// /usr/include/openssl/macros.h:238:12
pub const OSSL_DEPRECATEDIN_0_9_8 = @compileError("invalid number suffix: '.8'");
// /usr/include/openssl/macros.h:248:12
pub const OSSL_DEPRECATEDIN_0_9_8_FOR = @compileError("invalid number suffix: '.8'");
// /usr/include/openssl/macros.h:249:12
pub const OPENSSL_FILE = @compileError("unable to translate macro: undefined identifier `__FILE__`");
// /usr/include/openssl/macros.h:267:12
pub const OPENSSL_LINE = @compileError("unable to translate macro: undefined identifier `__LINE__`");
// /usr/include/openssl/macros.h:268:12
pub const OPENSSL_FUNC = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /usr/include/openssl/macros.h:288:13
pub const HEADER_SHA_H = "";
pub const OPENSSL_E_OS2_H = "";
pub const HEADER_E_OS2_H = "";
pub const OPENSSL_SYS_UNIX = "";
pub const OPENSSL_SYS_LINUX = "";
pub const OPENSSL_EXPORT = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/e_os2.h:183:11
pub const OPENSSL_EXTERN = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/e_os2.h:184:11
pub const ossl_ssize_t = isize;
pub const OSSL_SSIZE_MAX = @import("std").zig.c_translation.cast(isize, SIZE_MAX >> @as(c_int, 1));
pub const __owur = "";
pub const OPENSSL_NO_INTTYPES_H = "";
pub const OPENSSL_NO_STDINT_H = "";
pub const __CLANG_INTTYPES_H = "";
pub const _INTTYPES_H = @as(c_int, 1);
pub const _FEATURES_H = @as(c_int, 1);
pub const __KERNEL_STRICT_NAMES = "";
pub inline fn __GNUC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GNUC__ << @as(c_int, 16)) + __GNUC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub inline fn __glibc_clang_prereq(maj: anytype, min: anytype) @TypeOf(((__clang_major__ << @as(c_int, 16)) + __clang_minor__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__clang_major__ << @as(c_int, 16)) + __clang_minor__) >= ((maj << @as(c_int, 16)) + min);
}
pub const __GLIBC_USE = @compileError("unable to translate macro: undefined identifier `__GLIBC_USE_`");
// /usr/include/features.h:188:9
pub const _DEFAULT_SOURCE = @as(c_int, 1);
pub const __GLIBC_USE_ISOC2X = @as(c_int, 0);
pub const __USE_ISOC11 = @as(c_int, 1);
pub const __USE_ISOC99 = @as(c_int, 1);
pub const __USE_ISOC95 = @as(c_int, 1);
pub const __USE_POSIX_IMPLICITLY = @as(c_int, 1);
pub const _POSIX_SOURCE = @as(c_int, 1);
pub const _POSIX_C_SOURCE = @as(c_long, 200809);
pub const __USE_POSIX = @as(c_int, 1);
pub const __USE_POSIX2 = @as(c_int, 1);
pub const __USE_POSIX199309 = @as(c_int, 1);
pub const __USE_POSIX199506 = @as(c_int, 1);
pub const __USE_XOPEN2K = @as(c_int, 1);
pub const __USE_XOPEN2K8 = @as(c_int, 1);
pub const _ATFILE_SOURCE = @as(c_int, 1);
pub const __WORDSIZE = @as(c_int, 64);
pub const __WORDSIZE_TIME64_COMPAT32 = @as(c_int, 1);
pub const __SYSCALL_WORDSIZE = @as(c_int, 64);
pub const __TIMESIZE = __WORDSIZE;
pub const __USE_MISC = @as(c_int, 1);
pub const __USE_ATFILE = @as(c_int, 1);
pub const __USE_FORTIFY_LEVEL = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_GETS = @as(c_int, 0);
pub const __GLIBC_USE_DEPRECATED_SCANF = @as(c_int, 0);
pub const __GLIBC_USE_C2X_STRTOL = @as(c_int, 0);
pub const _STDC_PREDEF_H = @as(c_int, 1);
pub const __STDC_IEC_559__ = @as(c_int, 1);
pub const __STDC_IEC_60559_BFP__ = @as(c_long, 201404);
pub const __STDC_IEC_559_COMPLEX__ = @as(c_int, 1);
pub const __STDC_IEC_60559_COMPLEX__ = @as(c_long, 201404);
pub const __STDC_ISO_10646__ = @as(c_long, 201706);
pub const __GNU_LIBRARY__ = @as(c_int, 6);
pub const __GLIBC__ = @as(c_int, 2);
pub inline fn __GLIBC_PREREQ(maj: anytype, min: anytype) @TypeOf(((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min)) {
    _ = &maj;
    _ = &min;
    return ((__GLIBC__ << @as(c_int, 16)) + __GLIBC_MINOR__) >= ((maj << @as(c_int, 16)) + min);
}
pub const _SYS_CDEFS_H = @as(c_int, 1);
pub const __glibc_has_attribute = @compileError("unable to translate macro: undefined identifier `__has_attribute`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:45:10
pub inline fn __glibc_has_builtin(name: anytype) @TypeOf(__has_builtin(name)) {
    _ = &name;
    return __has_builtin(name);
}
pub const __glibc_has_extension = @compileError("unable to translate macro: undefined identifier `__has_extension`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:55:10
pub const __LEAF = "";
pub const __LEAF_ATTR = "";
pub const __THROW = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:79:11
pub const __THROWNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:80:11
pub const __NTH = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:81:11
pub const __NTHNL = @compileError("unable to translate macro: undefined identifier `__nothrow__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:82:11
pub const __COLD = @compileError("unable to translate macro: undefined identifier `__cold__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:102:11
pub inline fn __P(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub inline fn __PMT(args: anytype) @TypeOf(args) {
    _ = &args;
    return args;
}
pub const __CONCAT = @compileError("unable to translate C expr: unexpected token '##'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:131:9
pub const __STRING = @compileError("unable to translate C expr: unexpected token '#'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:132:9
pub const __ptr_t = ?*anyopaque;
pub const __BEGIN_DECLS = "";
pub const __END_DECLS = "";
pub inline fn __bos(ptr: anytype) @TypeOf(__builtin_object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1))) {
    _ = &ptr;
    return __builtin_object_size(ptr, __USE_FORTIFY_LEVEL > @as(c_int, 1));
}
pub inline fn __bos0(ptr: anytype) @TypeOf(__builtin_object_size(ptr, @as(c_int, 0))) {
    _ = &ptr;
    return __builtin_object_size(ptr, @as(c_int, 0));
}
pub inline fn __glibc_objsize0(__o: anytype) @TypeOf(__bos0(__o)) {
    _ = &__o;
    return __bos0(__o);
}
pub inline fn __glibc_objsize(__o: anytype) @TypeOf(__bos(__o)) {
    _ = &__o;
    return __bos(__o);
}
pub const __warnattr = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:216:10
pub const __errordecl = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:217:10
pub const __flexarr = @compileError("unable to translate C expr: unexpected token '['");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:225:10
pub const __glibc_c99_flexarr_available = @as(c_int, 1);
pub const __REDIRECT = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:256:10
pub const __REDIRECT_NTH = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:263:11
pub const __REDIRECT_NTHNL = @compileError("unable to translate C expr: unexpected token '__asm__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:265:11
pub const __ASMNAME = @compileError("unable to translate C expr: unexpected token ','");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:268:10
pub inline fn __ASMNAME2(prefix: anytype, cname: anytype) @TypeOf(__STRING(prefix) ++ cname) {
    _ = &prefix;
    _ = &cname;
    return __STRING(prefix) ++ cname;
}
pub const __REDIRECT_FORTIFY = __REDIRECT;
pub const __REDIRECT_FORTIFY_NTH = __REDIRECT_NTH;
pub const __attribute_malloc__ = @compileError("unable to translate macro: undefined identifier `__malloc__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:298:10
pub const __attribute_alloc_size__ = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:309:10
pub const __attribute_alloc_align__ = @compileError("unable to translate macro: undefined identifier `__alloc_align__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:315:10
pub const __attribute_pure__ = @compileError("unable to translate macro: undefined identifier `__pure__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:325:10
pub const __attribute_const__ = @compileError("unable to translate C expr: unexpected token '__attribute__'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:332:10
pub const __attribute_maybe_unused__ = @compileError("unable to translate macro: undefined identifier `__unused__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:338:10
pub const __attribute_used__ = @compileError("unable to translate macro: undefined identifier `__used__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:347:10
pub const __attribute_noinline__ = @compileError("unable to translate macro: undefined identifier `__noinline__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:348:10
pub const __attribute_deprecated__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:356:10
pub const __attribute_deprecated_msg__ = @compileError("unable to translate macro: undefined identifier `__deprecated__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:366:10
pub const __attribute_format_arg__ = @compileError("unable to translate macro: undefined identifier `__format_arg__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:379:10
pub const __attribute_format_strfmon__ = @compileError("unable to translate macro: undefined identifier `__format__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:389:10
pub const __attribute_nonnull__ = @compileError("unable to translate macro: undefined identifier `__nonnull__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:401:11
pub inline fn __nonnull(params: anytype) @TypeOf(__attribute_nonnull__(params)) {
    _ = &params;
    return __attribute_nonnull__(params);
}
pub const __returns_nonnull = @compileError("unable to translate macro: undefined identifier `__returns_nonnull__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:414:10
pub const __attribute_warn_unused_result__ = @compileError("unable to translate macro: undefined identifier `__warn_unused_result__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:423:10
pub const __wur = "";
pub const __always_inline = @compileError("unable to translate macro: undefined identifier `__always_inline__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:441:10
pub const __attribute_artificial__ = @compileError("unable to translate macro: undefined identifier `__artificial__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:450:10
pub const __extern_inline = @compileError("unable to translate macro: undefined identifier `__gnu_inline__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:468:11
pub const __extern_always_inline = @compileError("unable to translate macro: undefined identifier `__gnu_inline__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:469:11
pub const __fortify_function = __extern_always_inline ++ __attribute_artificial__;
pub const __restrict_arr = @compileError("unable to translate C expr: unexpected token '__restrict'");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:512:10
pub inline fn __glibc_unlikely(cond: anytype) @TypeOf(__builtin_expect(cond, @as(c_int, 0))) {
    _ = &cond;
    return __builtin_expect(cond, @as(c_int, 0));
}
pub inline fn __glibc_likely(cond: anytype) @TypeOf(__builtin_expect(cond, @as(c_int, 1))) {
    _ = &cond;
    return __builtin_expect(cond, @as(c_int, 1));
}
pub const __attribute_nonstring__ = "";
pub const __attribute_copy__ = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:561:10
pub const __LDOUBLE_REDIRECTS_TO_FLOAT128_ABI = @as(c_int, 0);
pub inline fn __LDBL_REDIR1(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR(name: anytype, proto: anytype) @TypeOf(name ++ proto) {
    _ = &name;
    _ = &proto;
    return name ++ proto;
}
pub inline fn __LDBL_REDIR1_NTH(name: anytype, proto: anytype, alias: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return name ++ proto ++ __THROW;
}
pub inline fn __LDBL_REDIR_NTH(name: anytype, proto: anytype) @TypeOf(name ++ proto ++ __THROW) {
    _ = &name;
    _ = &proto;
    return name ++ proto ++ __THROW;
}
pub const __LDBL_REDIR2_DECL = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:638:10
pub const __LDBL_REDIR_DECL = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:639:10
pub inline fn __REDIRECT_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT(name, proto, alias);
}
pub inline fn __REDIRECT_NTH_LDBL(name: anytype, proto: anytype, alias: anytype) @TypeOf(__REDIRECT_NTH(name, proto, alias)) {
    _ = &name;
    _ = &proto;
    _ = &alias;
    return __REDIRECT_NTH(name, proto, alias);
}
pub const __glibc_macro_warning1 = @compileError("unable to translate macro: undefined identifier `_Pragma`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:653:10
pub const __glibc_macro_warning = @compileError("unable to translate macro: undefined identifier `GCC`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:654:10
pub const __HAVE_GENERIC_SELECTION = @as(c_int, 1);
pub const __fortified_attr_access = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:699:11
pub const __attr_access = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:700:11
pub const __attr_access_none = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:701:11
pub const __attr_dealloc = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:711:10
pub const __attr_dealloc_free = "";
pub const __attribute_returns_twice__ = @compileError("unable to translate macro: undefined identifier `__returns_twice__`");
// /usr/include/x86_64-linux-gnu/sys/cdefs.h:718:10
pub const __stub___compat_bdflush = "";
pub const __stub_chflags = "";
pub const __stub_fchflags = "";
pub const __stub_gtty = "";
pub const __stub_revoke = "";
pub const __stub_setlogin = "";
pub const __stub_sigreturn = "";
pub const __stub_stty = "";
pub const __CLANG_STDINT_H = "";
pub const _STDINT_H = @as(c_int, 1);
pub const __GLIBC_INTERNAL_STARTING_HEADER_IMPLEMENTATION = "";
pub const __GLIBC_USE_LIB_EXT2 = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_BFP_EXT_C2X = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_FUNCS_EXT_C2X = @as(c_int, 0);
pub const __GLIBC_USE_IEC_60559_TYPES_EXT = @as(c_int, 0);
pub const _BITS_TYPES_H = @as(c_int, 1);
pub const __S16_TYPE = c_short;
pub const __U16_TYPE = c_ushort;
pub const __S32_TYPE = c_int;
pub const __U32_TYPE = c_uint;
pub const __SLONGWORD_TYPE = c_long;
pub const __ULONGWORD_TYPE = c_ulong;
pub const __SQUAD_TYPE = c_long;
pub const __UQUAD_TYPE = c_ulong;
pub const __SWORD_TYPE = c_long;
pub const __UWORD_TYPE = c_ulong;
pub const __SLONG32_TYPE = c_int;
pub const __ULONG32_TYPE = c_uint;
pub const __S64_TYPE = c_long;
pub const __U64_TYPE = c_ulong;
pub const __STD_TYPE = @compileError("unable to translate C expr: unexpected token 'typedef'");
// /usr/include/x86_64-linux-gnu/bits/types.h:137:10
pub const _BITS_TYPESIZES_H = @as(c_int, 1);
pub const __SYSCALL_SLONG_TYPE = __SLONGWORD_TYPE;
pub const __SYSCALL_ULONG_TYPE = __ULONGWORD_TYPE;
pub const __DEV_T_TYPE = __UQUAD_TYPE;
pub const __UID_T_TYPE = __U32_TYPE;
pub const __GID_T_TYPE = __U32_TYPE;
pub const __INO_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __INO64_T_TYPE = __UQUAD_TYPE;
pub const __MODE_T_TYPE = __U32_TYPE;
pub const __NLINK_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSWORD_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __OFF64_T_TYPE = __SQUAD_TYPE;
pub const __PID_T_TYPE = __S32_TYPE;
pub const __RLIM_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __RLIM64_T_TYPE = __UQUAD_TYPE;
pub const __BLKCNT_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __BLKCNT64_T_TYPE = __SQUAD_TYPE;
pub const __FSBLKCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSBLKCNT64_T_TYPE = __UQUAD_TYPE;
pub const __FSFILCNT_T_TYPE = __SYSCALL_ULONG_TYPE;
pub const __FSFILCNT64_T_TYPE = __UQUAD_TYPE;
pub const __ID_T_TYPE = __U32_TYPE;
pub const __CLOCK_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __TIME_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __USECONDS_T_TYPE = __U32_TYPE;
pub const __SUSECONDS_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __SUSECONDS64_T_TYPE = __SQUAD_TYPE;
pub const __DADDR_T_TYPE = __S32_TYPE;
pub const __KEY_T_TYPE = __S32_TYPE;
pub const __CLOCKID_T_TYPE = __S32_TYPE;
pub const __TIMER_T_TYPE = ?*anyopaque;
pub const __BLKSIZE_T_TYPE = __SYSCALL_SLONG_TYPE;
pub const __FSID_T_TYPE = @compileError("unable to translate macro: undefined identifier `__val`");
// /usr/include/x86_64-linux-gnu/bits/typesizes.h:73:9
pub const __SSIZE_T_TYPE = __SWORD_TYPE;
pub const __CPU_MASK_TYPE = __SYSCALL_ULONG_TYPE;
pub const __OFF_T_MATCHES_OFF64_T = @as(c_int, 1);
pub const __INO_T_MATCHES_INO64_T = @as(c_int, 1);
pub const __RLIM_T_MATCHES_RLIM64_T = @as(c_int, 1);
pub const __STATFS_MATCHES_STATFS64 = @as(c_int, 1);
pub const __KERNEL_OLD_TIMEVAL_MATCHES_TIMEVAL64 = @as(c_int, 1);
pub const __FD_SETSIZE = @as(c_int, 1024);
pub const _BITS_TIME64_H = @as(c_int, 1);
pub const __TIME64_T_TYPE = __TIME_T_TYPE;
pub const _BITS_WCHAR_H = @as(c_int, 1);
pub const __WCHAR_MAX = __WCHAR_MAX__;
pub const __WCHAR_MIN = -__WCHAR_MAX - @as(c_int, 1);
pub const _BITS_STDINT_INTN_H = @as(c_int, 1);
pub const _BITS_STDINT_UINTN_H = @as(c_int, 1);
pub const _BITS_STDINT_LEAST_H = @as(c_int, 1);
pub const __intptr_t_defined = "";
pub const INT8_MIN = -@as(c_int, 128);
pub const INT16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT8_MAX = @as(c_int, 127);
pub const INT16_MAX = @as(c_int, 32767);
pub const INT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT8_MAX = @as(c_int, 255);
pub const UINT16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_LEAST8_MIN = -@as(c_int, 128);
pub const INT_LEAST16_MIN = -@as(c_int, 32767) - @as(c_int, 1);
pub const INT_LEAST32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const INT_LEAST64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_LEAST8_MAX = @as(c_int, 127);
pub const INT_LEAST16_MAX = @as(c_int, 32767);
pub const INT_LEAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const INT_LEAST64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_LEAST8_MAX = @as(c_int, 255);
pub const UINT_LEAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65535, .decimal);
pub const UINT_LEAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub const UINT_LEAST64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INT_FAST8_MIN = -@as(c_int, 128);
pub const INT_FAST16_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST32_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INT_FAST64_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INT_FAST8_MAX = @as(c_int, 127);
pub const INT_FAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const INT_FAST64_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINT_FAST8_MAX = @as(c_int, 255);
pub const UINT_FAST16_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST32_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const UINT_FAST64_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const INTPTR_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const INTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const UINTPTR_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const INTMAX_MIN = -__INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal)) - @as(c_int, 1);
pub const INTMAX_MAX = __INT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 9223372036854775807, .decimal));
pub const UINTMAX_MAX = __UINT64_C(@import("std").zig.c_translation.promoteIntLiteral(c_int, 18446744073709551615, .decimal));
pub const PTRDIFF_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal) - @as(c_int, 1);
pub const PTRDIFF_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_long, 9223372036854775807, .decimal);
pub const SIG_ATOMIC_MIN = -@import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal) - @as(c_int, 1);
pub const SIG_ATOMIC_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SIZE_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_ulong, 18446744073709551615, .decimal);
pub const WCHAR_MIN = __WCHAR_MIN;
pub const WCHAR_MAX = __WCHAR_MAX;
pub const WINT_MIN = @as(c_uint, 0);
pub const WINT_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_uint, 4294967295, .decimal);
pub inline fn INT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn INT32_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const INT64_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub inline fn UINT8_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub inline fn UINT16_C(c: anytype) @TypeOf(c) {
    _ = &c;
    return c;
}
pub const UINT32_C = @import("std").zig.c_translation.Macros.U_SUFFIX;
pub const UINT64_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const INTMAX_C = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const UINTMAX_C = @import("std").zig.c_translation.Macros.UL_SUFFIX;
pub const ____gwchar_t_defined = @as(c_int, 1);
pub const __PRI64_PREFIX = "l";
pub const __PRIPTR_PREFIX = "l";
pub const PRId8 = "d";
pub const PRId16 = "d";
pub const PRId32 = "d";
pub const PRId64 = __PRI64_PREFIX ++ "d";
pub const PRIdLEAST8 = "d";
pub const PRIdLEAST16 = "d";
pub const PRIdLEAST32 = "d";
pub const PRIdLEAST64 = __PRI64_PREFIX ++ "d";
pub const PRIdFAST8 = "d";
pub const PRIdFAST16 = __PRIPTR_PREFIX ++ "d";
pub const PRIdFAST32 = __PRIPTR_PREFIX ++ "d";
pub const PRIdFAST64 = __PRI64_PREFIX ++ "d";
pub const PRIi8 = "i";
pub const PRIi16 = "i";
pub const PRIi32 = "i";
pub const PRIi64 = __PRI64_PREFIX ++ "i";
pub const PRIiLEAST8 = "i";
pub const PRIiLEAST16 = "i";
pub const PRIiLEAST32 = "i";
pub const PRIiLEAST64 = __PRI64_PREFIX ++ "i";
pub const PRIiFAST8 = "i";
pub const PRIiFAST16 = __PRIPTR_PREFIX ++ "i";
pub const PRIiFAST32 = __PRIPTR_PREFIX ++ "i";
pub const PRIiFAST64 = __PRI64_PREFIX ++ "i";
pub const PRIo8 = "o";
pub const PRIo16 = "o";
pub const PRIo32 = "o";
pub const PRIo64 = __PRI64_PREFIX ++ "o";
pub const PRIoLEAST8 = "o";
pub const PRIoLEAST16 = "o";
pub const PRIoLEAST32 = "o";
pub const PRIoLEAST64 = __PRI64_PREFIX ++ "o";
pub const PRIoFAST8 = "o";
pub const PRIoFAST16 = __PRIPTR_PREFIX ++ "o";
pub const PRIoFAST32 = __PRIPTR_PREFIX ++ "o";
pub const PRIoFAST64 = __PRI64_PREFIX ++ "o";
pub const PRIu8 = "u";
pub const PRIu16 = "u";
pub const PRIu32 = "u";
pub const PRIu64 = __PRI64_PREFIX ++ "u";
pub const PRIuLEAST8 = "u";
pub const PRIuLEAST16 = "u";
pub const PRIuLEAST32 = "u";
pub const PRIuLEAST64 = __PRI64_PREFIX ++ "u";
pub const PRIuFAST8 = "u";
pub const PRIuFAST16 = __PRIPTR_PREFIX ++ "u";
pub const PRIuFAST32 = __PRIPTR_PREFIX ++ "u";
pub const PRIuFAST64 = __PRI64_PREFIX ++ "u";
pub const PRIx8 = "x";
pub const PRIx16 = "x";
pub const PRIx32 = "x";
pub const PRIx64 = __PRI64_PREFIX ++ "x";
pub const PRIxLEAST8 = "x";
pub const PRIxLEAST16 = "x";
pub const PRIxLEAST32 = "x";
pub const PRIxLEAST64 = __PRI64_PREFIX ++ "x";
pub const PRIxFAST8 = "x";
pub const PRIxFAST16 = __PRIPTR_PREFIX ++ "x";
pub const PRIxFAST32 = __PRIPTR_PREFIX ++ "x";
pub const PRIxFAST64 = __PRI64_PREFIX ++ "x";
pub const PRIX8 = "X";
pub const PRIX16 = "X";
pub const PRIX32 = "X";
pub const PRIX64 = __PRI64_PREFIX ++ "X";
pub const PRIXLEAST8 = "X";
pub const PRIXLEAST16 = "X";
pub const PRIXLEAST32 = "X";
pub const PRIXLEAST64 = __PRI64_PREFIX ++ "X";
pub const PRIXFAST8 = "X";
pub const PRIXFAST16 = __PRIPTR_PREFIX ++ "X";
pub const PRIXFAST32 = __PRIPTR_PREFIX ++ "X";
pub const PRIXFAST64 = __PRI64_PREFIX ++ "X";
pub const PRIdMAX = __PRI64_PREFIX ++ "d";
pub const PRIiMAX = __PRI64_PREFIX ++ "i";
pub const PRIoMAX = __PRI64_PREFIX ++ "o";
pub const PRIuMAX = __PRI64_PREFIX ++ "u";
pub const PRIxMAX = __PRI64_PREFIX ++ "x";
pub const PRIXMAX = __PRI64_PREFIX ++ "X";
pub const PRIdPTR = __PRIPTR_PREFIX ++ "d";
pub const PRIiPTR = __PRIPTR_PREFIX ++ "i";
pub const PRIoPTR = __PRIPTR_PREFIX ++ "o";
pub const PRIuPTR = __PRIPTR_PREFIX ++ "u";
pub const PRIxPTR = __PRIPTR_PREFIX ++ "x";
pub const PRIXPTR = __PRIPTR_PREFIX ++ "X";
pub const SCNd8 = "hhd";
pub const SCNd16 = "hd";
pub const SCNd32 = "d";
pub const SCNd64 = __PRI64_PREFIX ++ "d";
pub const SCNdLEAST8 = "hhd";
pub const SCNdLEAST16 = "hd";
pub const SCNdLEAST32 = "d";
pub const SCNdLEAST64 = __PRI64_PREFIX ++ "d";
pub const SCNdFAST8 = "hhd";
pub const SCNdFAST16 = __PRIPTR_PREFIX ++ "d";
pub const SCNdFAST32 = __PRIPTR_PREFIX ++ "d";
pub const SCNdFAST64 = __PRI64_PREFIX ++ "d";
pub const SCNi8 = "hhi";
pub const SCNi16 = "hi";
pub const SCNi32 = "i";
pub const SCNi64 = __PRI64_PREFIX ++ "i";
pub const SCNiLEAST8 = "hhi";
pub const SCNiLEAST16 = "hi";
pub const SCNiLEAST32 = "i";
pub const SCNiLEAST64 = __PRI64_PREFIX ++ "i";
pub const SCNiFAST8 = "hhi";
pub const SCNiFAST16 = __PRIPTR_PREFIX ++ "i";
pub const SCNiFAST32 = __PRIPTR_PREFIX ++ "i";
pub const SCNiFAST64 = __PRI64_PREFIX ++ "i";
pub const SCNu8 = "hhu";
pub const SCNu16 = "hu";
pub const SCNu32 = "u";
pub const SCNu64 = __PRI64_PREFIX ++ "u";
pub const SCNuLEAST8 = "hhu";
pub const SCNuLEAST16 = "hu";
pub const SCNuLEAST32 = "u";
pub const SCNuLEAST64 = __PRI64_PREFIX ++ "u";
pub const SCNuFAST8 = "hhu";
pub const SCNuFAST16 = __PRIPTR_PREFIX ++ "u";
pub const SCNuFAST32 = __PRIPTR_PREFIX ++ "u";
pub const SCNuFAST64 = __PRI64_PREFIX ++ "u";
pub const SCNo8 = "hho";
pub const SCNo16 = "ho";
pub const SCNo32 = "o";
pub const SCNo64 = __PRI64_PREFIX ++ "o";
pub const SCNoLEAST8 = "hho";
pub const SCNoLEAST16 = "ho";
pub const SCNoLEAST32 = "o";
pub const SCNoLEAST64 = __PRI64_PREFIX ++ "o";
pub const SCNoFAST8 = "hho";
pub const SCNoFAST16 = __PRIPTR_PREFIX ++ "o";
pub const SCNoFAST32 = __PRIPTR_PREFIX ++ "o";
pub const SCNoFAST64 = __PRI64_PREFIX ++ "o";
pub const SCNx8 = "hhx";
pub const SCNx16 = "hx";
pub const SCNx32 = "x";
pub const SCNx64 = __PRI64_PREFIX ++ "x";
pub const SCNxLEAST8 = "hhx";
pub const SCNxLEAST16 = "hx";
pub const SCNxLEAST32 = "x";
pub const SCNxLEAST64 = __PRI64_PREFIX ++ "x";
pub const SCNxFAST8 = "hhx";
pub const SCNxFAST16 = __PRIPTR_PREFIX ++ "x";
pub const SCNxFAST32 = __PRIPTR_PREFIX ++ "x";
pub const SCNxFAST64 = __PRI64_PREFIX ++ "x";
pub const SCNdMAX = __PRI64_PREFIX ++ "d";
pub const SCNiMAX = __PRI64_PREFIX ++ "i";
pub const SCNoMAX = __PRI64_PREFIX ++ "o";
pub const SCNuMAX = __PRI64_PREFIX ++ "u";
pub const SCNxMAX = __PRI64_PREFIX ++ "x";
pub const SCNdPTR = __PRIPTR_PREFIX ++ "d";
pub const SCNiPTR = __PRIPTR_PREFIX ++ "i";
pub const SCNoPTR = __PRIPTR_PREFIX ++ "o";
pub const SCNuPTR = __PRIPTR_PREFIX ++ "u";
pub const SCNxPTR = __PRIPTR_PREFIX ++ "x";
pub const ossl_inline = @compileError("unable to translate C expr: unexpected token 'inline'");
// /usr/include/openssl/e_os2.h:269:12
pub const ossl_noreturn = @compileError("unable to translate C expr: unexpected token '_Noreturn'");
// /usr/include/openssl/e_os2.h:288:11
pub const ossl_unused = @compileError("unable to translate macro: undefined identifier `unused`");
// /usr/include/openssl/e_os2.h:297:11
pub const __need_ptrdiff_t = "";
pub const __need_size_t = "";
pub const __need_wchar_t = "";
pub const __need_NULL = "";
pub const __need_max_align_t = "";
pub const __need_offsetof = "";
pub const __STDDEF_H = "";
pub const _PTRDIFF_T = "";
pub const _SIZE_T = "";
pub const _WCHAR_T = "";
pub const NULL = @import("std").zig.c_translation.cast(?*anyopaque, @as(c_int, 0));
pub const __CLANG_MAX_ALIGN_T_DEFINED = "";
pub const offsetof = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /home/benji/.local/zig-x86_64-linux-0.15.1/lib/include/__stddef_offsetof.h:16:9
pub const SHA_DIGEST_LENGTH = @as(c_int, 20);
pub const SHA_LONG = c_uint;
pub const SHA_LBLOCK = @as(c_int, 16);
pub const SHA_CBLOCK = SHA_LBLOCK * @as(c_int, 4);
pub const SHA_LAST_BLOCK = SHA_CBLOCK - @as(c_int, 8);
pub const SHA256_CBLOCK = SHA_LBLOCK * @as(c_int, 4);
pub const SHA224_DIGEST_LENGTH = @as(c_int, 28);
pub const SHA256_DIGEST_LENGTH = @as(c_int, 32);
pub const SHA384_DIGEST_LENGTH = @as(c_int, 48);
pub const SHA512_DIGEST_LENGTH = @as(c_int, 64);
pub const SHA512_CBLOCK = SHA_LBLOCK * @as(c_int, 8);
pub const SHA_LONG64 = c_ulonglong;
pub const OPENSSL_EVP_H = "";
pub const HEADER_ENVELOPE_H = "";
pub const __need___va_list = "";
pub const __need_va_list = "";
pub const __need_va_arg = "";
pub const __need___va_copy = "";
pub const __need_va_copy = "";
pub const __STDARG_H = "";
pub const __GNUC_VA_LIST = "";
pub const _VA_LIST = "";
pub const va_start = @compileError("unable to translate macro: undefined identifier `__builtin_va_start`");
// /home/benji/.local/zig-x86_64-linux-0.15.1/lib/include/__stdarg_va_arg.h:17:9
pub const va_end = @compileError("unable to translate macro: undefined identifier `__builtin_va_end`");
// /home/benji/.local/zig-x86_64-linux-0.15.1/lib/include/__stdarg_va_arg.h:19:9
pub const va_arg = @compileError("unable to translate C expr: unexpected token 'an identifier'");
// /home/benji/.local/zig-x86_64-linux-0.15.1/lib/include/__stdarg_va_arg.h:20:9
pub const __va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`");
// /home/benji/.local/zig-x86_64-linux-0.15.1/lib/include/__stdarg___va_copy.h:11:9
pub const va_copy = @compileError("unable to translate macro: undefined identifier `__builtin_va_copy`");
// /home/benji/.local/zig-x86_64-linux-0.15.1/lib/include/__stdarg_va_copy.h:11:9
pub const _STDIO_H = @as(c_int, 1);
pub const _____fpos_t_defined = @as(c_int, 1);
pub const ____mbstate_t_defined = @as(c_int, 1);
pub const _____fpos64_t_defined = @as(c_int, 1);
pub const ____FILE_defined = @as(c_int, 1);
pub const __FILE_defined = @as(c_int, 1);
pub const __struct_FILE_defined = @as(c_int, 1);
pub const __getc_unlocked_body = @compileError("TODO postfix inc/dec expr");
// /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h:102:9
pub const __putc_unlocked_body = @compileError("TODO postfix inc/dec expr");
// /usr/include/x86_64-linux-gnu/bits/types/struct_FILE.h:106:9
pub const _IO_EOF_SEEN = @as(c_int, 0x0010);
pub inline fn __feof_unlocked_body(_fp: anytype) @TypeOf((_fp.*._flags & _IO_EOF_SEEN) != @as(c_int, 0)) {
    _ = &_fp;
    return (_fp.*._flags & _IO_EOF_SEEN) != @as(c_int, 0);
}
pub const _IO_ERR_SEEN = @as(c_int, 0x0020);
pub inline fn __ferror_unlocked_body(_fp: anytype) @TypeOf((_fp.*._flags & _IO_ERR_SEEN) != @as(c_int, 0)) {
    _ = &_fp;
    return (_fp.*._flags & _IO_ERR_SEEN) != @as(c_int, 0);
}
pub const _IO_USER_LOCK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hex);
pub const __cookie_io_functions_t_defined = @as(c_int, 1);
pub const _VA_LIST_DEFINED = "";
pub const __off_t_defined = "";
pub const __ssize_t_defined = "";
pub const _IOFBF = @as(c_int, 0);
pub const _IOLBF = @as(c_int, 1);
pub const _IONBF = @as(c_int, 2);
pub const BUFSIZ = @as(c_int, 8192);
pub const EOF = -@as(c_int, 1);
pub const SEEK_SET = @as(c_int, 0);
pub const SEEK_CUR = @as(c_int, 1);
pub const SEEK_END = @as(c_int, 2);
pub const P_tmpdir = "/tmp";
pub const L_tmpnam = @as(c_int, 20);
pub const TMP_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 238328, .decimal);
pub const _BITS_STDIO_LIM_H = @as(c_int, 1);
pub const FILENAME_MAX = @as(c_int, 4096);
pub const L_ctermid = @as(c_int, 9);
pub const FOPEN_MAX = @as(c_int, 16);
pub const __attr_dealloc_fclose = __attr_dealloc(fclose, @as(c_int, 1));
pub const _BITS_FLOATN_H = "";
pub const __HAVE_FLOAT128 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT128 = @as(c_int, 0);
pub const __HAVE_FLOAT64X = @as(c_int, 1);
pub const __HAVE_FLOAT64X_LONG_DOUBLE = @as(c_int, 1);
pub const _BITS_FLOATN_COMMON_H = "";
pub const __HAVE_FLOAT16 = @as(c_int, 0);
pub const __HAVE_FLOAT32 = @as(c_int, 1);
pub const __HAVE_FLOAT64 = @as(c_int, 1);
pub const __HAVE_FLOAT32X = @as(c_int, 1);
pub const __HAVE_FLOAT128X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT16 = __HAVE_FLOAT16;
pub const __HAVE_DISTINCT_FLOAT32 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64 = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT32X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT64X = @as(c_int, 0);
pub const __HAVE_DISTINCT_FLOAT128X = __HAVE_FLOAT128X;
pub const __HAVE_FLOAT128_UNLIKE_LDBL = (__HAVE_DISTINCT_FLOAT128 != 0) and (__LDBL_MANT_DIG__ != @as(c_int, 113));
pub const __HAVE_FLOATN_NOT_TYPEDEF = @as(c_int, 0);
pub const __f32 = @import("std").zig.c_translation.Macros.F_SUFFIX;
pub inline fn __f64(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub inline fn __f32x(x: anytype) @TypeOf(x) {
    _ = &x;
    return x;
}
pub const __f64x = @import("std").zig.c_translation.Macros.L_SUFFIX;
pub const __CFLOAT32 = @compileError("unable to translate: TODO _Complex");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:149:12
pub const __CFLOAT64 = @compileError("unable to translate: TODO _Complex");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:160:13
pub const __CFLOAT32X = @compileError("unable to translate: TODO _Complex");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:169:12
pub const __CFLOAT64X = @compileError("unable to translate: TODO _Complex");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:178:13
pub inline fn __builtin_huge_valf32() @TypeOf(__builtin_huge_valf()) {
    return __builtin_huge_valf();
}
pub inline fn __builtin_inff32() @TypeOf(__builtin_inff()) {
    return __builtin_inff();
}
pub inline fn __builtin_nanf32(x: anytype) @TypeOf(__builtin_nanf(x)) {
    _ = &x;
    return __builtin_nanf(x);
}
pub const __builtin_nansf32 = @compileError("unable to translate macro: undefined identifier `__builtin_nansf`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:221:12
pub const __builtin_huge_valf64 = @compileError("unable to translate macro: undefined identifier `__builtin_huge_val`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:255:13
pub const __builtin_inff64 = @compileError("unable to translate macro: undefined identifier `__builtin_inf`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:256:13
pub const __builtin_nanf64 = @compileError("unable to translate macro: undefined identifier `__builtin_nan`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:257:13
pub const __builtin_nansf64 = @compileError("unable to translate macro: undefined identifier `__builtin_nans`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:258:13
pub const __builtin_huge_valf32x = @compileError("unable to translate macro: undefined identifier `__builtin_huge_val`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:272:12
pub const __builtin_inff32x = @compileError("unable to translate macro: undefined identifier `__builtin_inf`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:273:12
pub const __builtin_nanf32x = @compileError("unable to translate macro: undefined identifier `__builtin_nan`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:274:12
pub const __builtin_nansf32x = @compileError("unable to translate macro: undefined identifier `__builtin_nans`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:275:12
pub const __builtin_huge_valf64x = @compileError("unable to translate macro: undefined identifier `__builtin_huge_vall`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:289:13
pub const __builtin_inff64x = @compileError("unable to translate macro: undefined identifier `__builtin_infl`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:290:13
pub const __builtin_nanf64x = @compileError("unable to translate macro: undefined identifier `__builtin_nanl`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:291:13
pub const __builtin_nansf64x = @compileError("unable to translate macro: undefined identifier `__builtin_nansl`");
// /usr/include/x86_64-linux-gnu/bits/floatn-common.h:292:13
pub const OPENSSL_TYPES_H = "";
pub const __CLANG_LIMITS_H = "";
pub const _GCC_LIMITS_H_ = "";
pub const _LIBC_LIMITS_H_ = @as(c_int, 1);
pub const MB_LEN_MAX = @as(c_int, 16);
pub const LLONG_MIN = -LLONG_MAX - @as(c_int, 1);
pub const LLONG_MAX = __LONG_LONG_MAX__;
pub const ULLONG_MAX = (LLONG_MAX * @as(c_ulonglong, 2)) + @as(c_int, 1);
pub const _BITS_POSIX1_LIM_H = @as(c_int, 1);
pub const _POSIX_AIO_LISTIO_MAX = @as(c_int, 2);
pub const _POSIX_AIO_MAX = @as(c_int, 1);
pub const _POSIX_ARG_MAX = @as(c_int, 4096);
pub const _POSIX_CHILD_MAX = @as(c_int, 25);
pub const _POSIX_DELAYTIMER_MAX = @as(c_int, 32);
pub const _POSIX_HOST_NAME_MAX = @as(c_int, 255);
pub const _POSIX_LINK_MAX = @as(c_int, 8);
pub const _POSIX_LOGIN_NAME_MAX = @as(c_int, 9);
pub const _POSIX_MAX_CANON = @as(c_int, 255);
pub const _POSIX_MAX_INPUT = @as(c_int, 255);
pub const _POSIX_MQ_OPEN_MAX = @as(c_int, 8);
pub const _POSIX_MQ_PRIO_MAX = @as(c_int, 32);
pub const _POSIX_NAME_MAX = @as(c_int, 14);
pub const _POSIX_NGROUPS_MAX = @as(c_int, 8);
pub const _POSIX_OPEN_MAX = @as(c_int, 20);
pub const _POSIX_PATH_MAX = @as(c_int, 256);
pub const _POSIX_PIPE_BUF = @as(c_int, 512);
pub const _POSIX_RE_DUP_MAX = @as(c_int, 255);
pub const _POSIX_RTSIG_MAX = @as(c_int, 8);
pub const _POSIX_SEM_NSEMS_MAX = @as(c_int, 256);
pub const _POSIX_SEM_VALUE_MAX = @as(c_int, 32767);
pub const _POSIX_SIGQUEUE_MAX = @as(c_int, 32);
pub const _POSIX_SSIZE_MAX = @as(c_int, 32767);
pub const _POSIX_STREAM_MAX = @as(c_int, 8);
pub const _POSIX_SYMLINK_MAX = @as(c_int, 255);
pub const _POSIX_SYMLOOP_MAX = @as(c_int, 8);
pub const _POSIX_TIMER_MAX = @as(c_int, 32);
pub const _POSIX_TTY_NAME_MAX = @as(c_int, 9);
pub const _POSIX_TZNAME_MAX = @as(c_int, 6);
pub const _POSIX_CLOCKRES_MIN = @import("std").zig.c_translation.promoteIntLiteral(c_int, 20000000, .decimal);
pub const __undef_NR_OPEN = "";
pub const __undef_LINK_MAX = "";
pub const __undef_OPEN_MAX = "";
pub const __undef_ARG_MAX = "";
pub const _LINUX_LIMITS_H = "";
pub const NR_OPEN = @as(c_int, 1024);
pub const NGROUPS_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub const ARG_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 131072, .decimal);
pub const LINK_MAX = @as(c_int, 127);
pub const MAX_CANON = @as(c_int, 255);
pub const MAX_INPUT = @as(c_int, 255);
pub const NAME_MAX = @as(c_int, 255);
pub const PATH_MAX = @as(c_int, 4096);
pub const PIPE_BUF = @as(c_int, 4096);
pub const XATTR_NAME_MAX = @as(c_int, 255);
pub const XATTR_SIZE_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub const XATTR_LIST_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 65536, .decimal);
pub const RTSIG_MAX = @as(c_int, 32);
pub const _POSIX_THREAD_KEYS_MAX = @as(c_int, 128);
pub const PTHREAD_KEYS_MAX = @as(c_int, 1024);
pub const _POSIX_THREAD_DESTRUCTOR_ITERATIONS = @as(c_int, 4);
pub const PTHREAD_DESTRUCTOR_ITERATIONS = _POSIX_THREAD_DESTRUCTOR_ITERATIONS;
pub const _POSIX_THREAD_THREADS_MAX = @as(c_int, 64);
pub const AIO_PRIO_DELTA_MAX = @as(c_int, 20);
pub const PTHREAD_STACK_MIN = @as(c_int, 16384);
pub const DELAYTIMER_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const TTY_NAME_MAX = @as(c_int, 32);
pub const LOGIN_NAME_MAX = @as(c_int, 256);
pub const HOST_NAME_MAX = @as(c_int, 64);
pub const MQ_PRIO_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 32768, .decimal);
pub const SEM_VALUE_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const SSIZE_MAX = LONG_MAX;
pub const _BITS_POSIX2_LIM_H = @as(c_int, 1);
pub const _POSIX2_BC_BASE_MAX = @as(c_int, 99);
pub const _POSIX2_BC_DIM_MAX = @as(c_int, 2048);
pub const _POSIX2_BC_SCALE_MAX = @as(c_int, 99);
pub const _POSIX2_BC_STRING_MAX = @as(c_int, 1000);
pub const _POSIX2_COLL_WEIGHTS_MAX = @as(c_int, 2);
pub const _POSIX2_EXPR_NEST_MAX = @as(c_int, 32);
pub const _POSIX2_LINE_MAX = @as(c_int, 2048);
pub const _POSIX2_RE_DUP_MAX = @as(c_int, 255);
pub const _POSIX2_CHARCLASS_NAME_MAX = @as(c_int, 14);
pub const BC_BASE_MAX = _POSIX2_BC_BASE_MAX;
pub const BC_DIM_MAX = _POSIX2_BC_DIM_MAX;
pub const BC_SCALE_MAX = _POSIX2_BC_SCALE_MAX;
pub const BC_STRING_MAX = _POSIX2_BC_STRING_MAX;
pub const COLL_WEIGHTS_MAX = @as(c_int, 255);
pub const EXPR_NEST_MAX = _POSIX2_EXPR_NEST_MAX;
pub const LINE_MAX = _POSIX2_LINE_MAX;
pub const CHARCLASS_NAME_MAX = @as(c_int, 2048);
pub const RE_DUP_MAX = @as(c_int, 0x7fff);
pub const SCHAR_MAX = __SCHAR_MAX__;
pub const SHRT_MAX = __SHRT_MAX__;
pub const INT_MAX = __INT_MAX__;
pub const LONG_MAX = __LONG_MAX__;
pub const SCHAR_MIN = -__SCHAR_MAX__ - @as(c_int, 1);
pub const SHRT_MIN = -__SHRT_MAX__ - @as(c_int, 1);
pub const INT_MIN = -__INT_MAX__ - @as(c_int, 1);
pub const LONG_MIN = -__LONG_MAX__ - @as(c_long, 1);
pub const UCHAR_MAX = (__SCHAR_MAX__ * @as(c_int, 2)) + @as(c_int, 1);
pub const USHRT_MAX = (__SHRT_MAX__ * @as(c_int, 2)) + @as(c_int, 1);
pub const UINT_MAX = (__INT_MAX__ * @as(c_uint, 2)) + @as(c_uint, 1);
pub const ULONG_MAX = (__LONG_MAX__ * @as(c_ulong, 2)) + @as(c_ulong, 1);
pub const CHAR_BIT = __CHAR_BIT__;
pub const CHAR_MIN = SCHAR_MIN;
pub const CHAR_MAX = __SCHAR_MAX__;
pub const OPENSSL_SAFESTACK_H = "";
pub const HEADER_SAFESTACK_H = "";
pub const OPENSSL_STACK_H = "";
pub const HEADER_STACK_H = "";
pub const _STACK = OPENSSL_STACK;
pub const sk_num = OPENSSL_sk_num;
pub const sk_value = OPENSSL_sk_value;
pub const sk_set = OPENSSL_sk_set;
pub const sk_new = OPENSSL_sk_new;
pub const sk_new_null = OPENSSL_sk_new_null;
pub const sk_free = OPENSSL_sk_free;
pub const sk_pop_free = OPENSSL_sk_pop_free;
pub const sk_deep_copy = OPENSSL_sk_deep_copy;
pub const sk_insert = OPENSSL_sk_insert;
pub const sk_delete = OPENSSL_sk_delete;
pub const sk_delete_ptr = OPENSSL_sk_delete_ptr;
pub const sk_find = OPENSSL_sk_find;
pub const sk_find_ex = OPENSSL_sk_find_ex;
pub const sk_push = OPENSSL_sk_push;
pub const sk_unshift = OPENSSL_sk_unshift;
pub const sk_shift = OPENSSL_sk_shift;
pub const sk_pop = OPENSSL_sk_pop;
pub const sk_zero = OPENSSL_sk_zero;
pub const sk_set_cmp_func = OPENSSL_sk_set_cmp_func;
pub const sk_dup = OPENSSL_sk_dup;
pub const sk_sort = OPENSSL_sk_sort;
pub const sk_is_sorted = OPENSSL_sk_is_sorted;
pub const STACK_OF = @compileError("unable to translate macro: undefined identifier `stack_st_`");
// /usr/include/openssl/safestack.h:31:10
pub const SKM_DEFINE_STACK_OF_INTERNAL = @compileError("unable to translate macro: undefined identifier `sk_`");
// /usr/include/openssl/safestack.h:34:10
pub const SKM_DEFINE_STACK_OF = @compileError("unable to translate macro: undefined identifier `sk_`");
// /usr/include/openssl/safestack.h:64:10
pub inline fn DEFINE_STACK_OF(t: anytype) @TypeOf(SKM_DEFINE_STACK_OF(t, t, t)) {
    _ = &t;
    return SKM_DEFINE_STACK_OF(t, t, t);
}
pub const DEFINE_STACK_OF_CONST = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:176:10
pub inline fn DEFINE_SPECIAL_STACK_OF(t1: anytype, t2: anytype) @TypeOf(SKM_DEFINE_STACK_OF(t1, t2, t2)) {
    _ = &t1;
    _ = &t2;
    return SKM_DEFINE_STACK_OF(t1, t2, t2);
}
pub const DEFINE_SPECIAL_STACK_OF_CONST = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:178:10
pub inline fn sk_OPENSSL_STRING_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_OPENSSL_STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_OPENSSL_STRING_sk_type(sk));
}
pub inline fn sk_OPENSSL_STRING_value(sk: anytype, idx: anytype) [*c]u8 {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]u8, OPENSSL_sk_value(ossl_check_const_OPENSSL_STRING_sk_type(sk), idx));
}
pub const sk_OPENSSL_STRING_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:208:9
pub const sk_OPENSSL_STRING_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:209:9
pub const sk_OPENSSL_STRING_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:210:9
pub inline fn sk_OPENSSL_STRING_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_OPENSSL_STRING_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_OPENSSL_STRING_sk_type(sk), n);
}
pub inline fn sk_OPENSSL_STRING_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_OPENSSL_STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_OPENSSL_STRING_sk_type(sk));
}
pub inline fn sk_OPENSSL_STRING_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_OPENSSL_STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_OPENSSL_STRING_sk_type(sk));
}
pub inline fn sk_OPENSSL_STRING_delete(sk: anytype, i: anytype) [*c]u8 {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]u8, OPENSSL_sk_delete(ossl_check_OPENSSL_STRING_sk_type(sk), i));
}
pub inline fn sk_OPENSSL_STRING_delete_ptr(sk: anytype, ptr: anytype) [*c]u8 {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]u8, OPENSSL_sk_delete_ptr(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr)));
}
pub inline fn sk_OPENSSL_STRING_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr));
}
pub inline fn sk_OPENSSL_STRING_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr));
}
pub inline fn sk_OPENSSL_STRING_pop(sk: anytype) [*c]u8 {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]u8, OPENSSL_sk_pop(ossl_check_OPENSSL_STRING_sk_type(sk)));
}
pub inline fn sk_OPENSSL_STRING_shift(sk: anytype) [*c]u8 {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]u8, OPENSSL_sk_shift(ossl_check_OPENSSL_STRING_sk_type(sk)));
}
pub inline fn sk_OPENSSL_STRING_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_freefunc_type(freefunc));
}
pub inline fn sk_OPENSSL_STRING_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr), idx);
}
pub inline fn sk_OPENSSL_STRING_set(sk: anytype, idx: anytype, ptr: anytype) [*c]u8 {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]u8, OPENSSL_sk_set(ossl_check_OPENSSL_STRING_sk_type(sk), idx, ossl_check_OPENSSL_STRING_type(ptr)));
}
pub inline fn sk_OPENSSL_STRING_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr));
}
pub inline fn sk_OPENSSL_STRING_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr));
}
pub inline fn sk_OPENSSL_STRING_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_type(ptr), pnum);
}
pub inline fn sk_OPENSSL_STRING_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_OPENSSL_STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_OPENSSL_STRING_sk_type(sk));
}
pub inline fn sk_OPENSSL_STRING_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_OPENSSL_STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_OPENSSL_STRING_sk_type(sk));
}
pub const sk_OPENSSL_STRING_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:228:9
pub const sk_OPENSSL_STRING_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:229:9
pub inline fn sk_OPENSSL_STRING_set_cmp_func(sk: anytype, cmp: anytype) sk_OPENSSL_STRING_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_OPENSSL_STRING_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_OPENSSL_STRING_sk_type(sk), ossl_check_OPENSSL_STRING_compfunc_type(cmp)));
}
pub inline fn sk_OPENSSL_CSTRING_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_OPENSSL_CSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_OPENSSL_CSTRING_sk_type(sk));
}
pub const sk_OPENSSL_CSTRING_value = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:233:9
pub const sk_OPENSSL_CSTRING_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:234:9
pub const sk_OPENSSL_CSTRING_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:235:9
pub const sk_OPENSSL_CSTRING_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:236:9
pub inline fn sk_OPENSSL_CSTRING_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_OPENSSL_CSTRING_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_OPENSSL_CSTRING_sk_type(sk), n);
}
pub inline fn sk_OPENSSL_CSTRING_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_OPENSSL_CSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_OPENSSL_CSTRING_sk_type(sk));
}
pub inline fn sk_OPENSSL_CSTRING_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_OPENSSL_CSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_OPENSSL_CSTRING_sk_type(sk));
}
pub const sk_OPENSSL_CSTRING_delete = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:240:9
pub const sk_OPENSSL_CSTRING_delete_ptr = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:241:9
pub inline fn sk_OPENSSL_CSTRING_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr));
}
pub inline fn sk_OPENSSL_CSTRING_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr));
}
pub const sk_OPENSSL_CSTRING_pop = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:244:9
pub const sk_OPENSSL_CSTRING_shift = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:245:9
pub inline fn sk_OPENSSL_CSTRING_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_freefunc_type(freefunc));
}
pub inline fn sk_OPENSSL_CSTRING_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr), idx);
}
pub const sk_OPENSSL_CSTRING_set = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/safestack.h:248:9
pub inline fn sk_OPENSSL_CSTRING_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr));
}
pub inline fn sk_OPENSSL_CSTRING_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr));
}
pub inline fn sk_OPENSSL_CSTRING_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_type(ptr), pnum);
}
pub inline fn sk_OPENSSL_CSTRING_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_OPENSSL_CSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_OPENSSL_CSTRING_sk_type(sk));
}
pub inline fn sk_OPENSSL_CSTRING_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_OPENSSL_CSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_OPENSSL_CSTRING_sk_type(sk));
}
pub const sk_OPENSSL_CSTRING_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:254:9
pub const sk_OPENSSL_CSTRING_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:255:9
pub inline fn sk_OPENSSL_CSTRING_set_cmp_func(sk: anytype, cmp: anytype) sk_OPENSSL_CSTRING_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_OPENSSL_CSTRING_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_OPENSSL_CSTRING_sk_type(sk), ossl_check_OPENSSL_CSTRING_compfunc_type(cmp)));
}
pub inline fn sk_OPENSSL_BLOCK_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_OPENSSL_BLOCK_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_OPENSSL_BLOCK_sk_type(sk));
}
pub inline fn sk_OPENSSL_BLOCK_value(sk: anytype, idx: anytype) ?*anyopaque {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_value(ossl_check_const_OPENSSL_BLOCK_sk_type(sk), idx));
}
pub const sk_OPENSSL_BLOCK_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:268:9
pub const sk_OPENSSL_BLOCK_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:269:9
pub const sk_OPENSSL_BLOCK_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:270:9
pub inline fn sk_OPENSSL_BLOCK_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_OPENSSL_BLOCK_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_OPENSSL_BLOCK_sk_type(sk), n);
}
pub inline fn sk_OPENSSL_BLOCK_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_OPENSSL_BLOCK_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_OPENSSL_BLOCK_sk_type(sk));
}
pub inline fn sk_OPENSSL_BLOCK_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_OPENSSL_BLOCK_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_OPENSSL_BLOCK_sk_type(sk));
}
pub inline fn sk_OPENSSL_BLOCK_delete(sk: anytype, i: anytype) ?*anyopaque {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_delete(ossl_check_OPENSSL_BLOCK_sk_type(sk), i));
}
pub inline fn sk_OPENSSL_BLOCK_delete_ptr(sk: anytype, ptr: anytype) ?*anyopaque {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_delete_ptr(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr)));
}
pub inline fn sk_OPENSSL_BLOCK_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr));
}
pub inline fn sk_OPENSSL_BLOCK_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr));
}
pub inline fn sk_OPENSSL_BLOCK_pop(sk: anytype) ?*anyopaque {
    _ = &sk;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_pop(ossl_check_OPENSSL_BLOCK_sk_type(sk)));
}
pub inline fn sk_OPENSSL_BLOCK_shift(sk: anytype) ?*anyopaque {
    _ = &sk;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_shift(ossl_check_OPENSSL_BLOCK_sk_type(sk)));
}
pub inline fn sk_OPENSSL_BLOCK_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_freefunc_type(freefunc));
}
pub inline fn sk_OPENSSL_BLOCK_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr), idx);
}
pub inline fn sk_OPENSSL_BLOCK_set(sk: anytype, idx: anytype, ptr: anytype) ?*anyopaque {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_set(ossl_check_OPENSSL_BLOCK_sk_type(sk), idx, ossl_check_OPENSSL_BLOCK_type(ptr)));
}
pub inline fn sk_OPENSSL_BLOCK_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr));
}
pub inline fn sk_OPENSSL_BLOCK_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr));
}
pub inline fn sk_OPENSSL_BLOCK_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_type(ptr), pnum);
}
pub inline fn sk_OPENSSL_BLOCK_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_OPENSSL_BLOCK_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_OPENSSL_BLOCK_sk_type(sk));
}
pub inline fn sk_OPENSSL_BLOCK_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_OPENSSL_BLOCK_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_OPENSSL_BLOCK_sk_type(sk));
}
pub const sk_OPENSSL_BLOCK_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:288:9
pub const sk_OPENSSL_BLOCK_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/safestack.h:289:9
pub inline fn sk_OPENSSL_BLOCK_set_cmp_func(sk: anytype, cmp: anytype) sk_OPENSSL_BLOCK_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_OPENSSL_BLOCK_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_OPENSSL_BLOCK_sk_type(sk), ossl_check_OPENSSL_BLOCK_compfunc_type(cmp)));
}
pub const OPENSSL_CORE_H = "";
pub const OSSL_PARAM_INTEGER = @as(c_int, 1);
pub const OSSL_PARAM_UNSIGNED_INTEGER = @as(c_int, 2);
pub const OSSL_PARAM_REAL = @as(c_int, 3);
pub const OSSL_PARAM_UTF8_STRING = @as(c_int, 4);
pub const OSSL_PARAM_OCTET_STRING = @as(c_int, 5);
pub const OSSL_PARAM_UTF8_PTR = @as(c_int, 6);
pub const OSSL_PARAM_OCTET_PTR = @as(c_int, 7);
pub const OPENSSL_CORE_NUMBERS_H = "";
pub const OSSL_CORE_MAKE_FUNC = @compileError("unable to translate macro: undefined identifier `OSSL_FUNC_`");
// /usr/include/openssl/core_dispatch.h:47:9
pub const OSSL_FUNC_CORE_GETTABLE_PARAMS = @as(c_int, 1);
pub const OSSL_FUNC_CORE_GET_PARAMS = @as(c_int, 2);
pub const OSSL_FUNC_CORE_THREAD_START = @as(c_int, 3);
pub const OSSL_FUNC_CORE_GET_LIBCTX = @as(c_int, 4);
pub const OSSL_FUNC_CORE_NEW_ERROR = @as(c_int, 5);
pub const OSSL_FUNC_CORE_SET_ERROR_DEBUG = @as(c_int, 6);
pub const OSSL_FUNC_CORE_VSET_ERROR = @as(c_int, 7);
pub const OSSL_FUNC_CORE_SET_ERROR_MARK = @as(c_int, 8);
pub const OSSL_FUNC_CORE_CLEAR_LAST_ERROR_MARK = @as(c_int, 9);
pub const OSSL_FUNC_CORE_POP_ERROR_TO_MARK = @as(c_int, 10);
pub const OSSL_FUNC_CORE_OBJ_ADD_SIGID = @as(c_int, 11);
pub const OSSL_FUNC_CORE_OBJ_CREATE = @as(c_int, 12);
pub const OSSL_FUNC_CRYPTO_MALLOC = @as(c_int, 20);
pub const OSSL_FUNC_CRYPTO_ZALLOC = @as(c_int, 21);
pub const OSSL_FUNC_CRYPTO_FREE = @as(c_int, 22);
pub const OSSL_FUNC_CRYPTO_CLEAR_FREE = @as(c_int, 23);
pub const OSSL_FUNC_CRYPTO_REALLOC = @as(c_int, 24);
pub const OSSL_FUNC_CRYPTO_CLEAR_REALLOC = @as(c_int, 25);
pub const OSSL_FUNC_CRYPTO_SECURE_MALLOC = @as(c_int, 26);
pub const OSSL_FUNC_CRYPTO_SECURE_ZALLOC = @as(c_int, 27);
pub const OSSL_FUNC_CRYPTO_SECURE_FREE = @as(c_int, 28);
pub const OSSL_FUNC_CRYPTO_SECURE_CLEAR_FREE = @as(c_int, 29);
pub const OSSL_FUNC_CRYPTO_SECURE_ALLOCATED = @as(c_int, 30);
pub const OSSL_FUNC_OPENSSL_CLEANSE = @as(c_int, 31);
pub const OSSL_FUNC_BIO_NEW_FILE = @as(c_int, 40);
pub const OSSL_FUNC_BIO_NEW_MEMBUF = @as(c_int, 41);
pub const OSSL_FUNC_BIO_READ_EX = @as(c_int, 42);
pub const OSSL_FUNC_BIO_WRITE_EX = @as(c_int, 43);
pub const OSSL_FUNC_BIO_UP_REF = @as(c_int, 44);
pub const OSSL_FUNC_BIO_FREE = @as(c_int, 45);
pub const OSSL_FUNC_BIO_VPRINTF = @as(c_int, 46);
pub const OSSL_FUNC_BIO_VSNPRINTF = @as(c_int, 47);
pub const OSSL_FUNC_BIO_PUTS = @as(c_int, 48);
pub const OSSL_FUNC_BIO_GETS = @as(c_int, 49);
pub const OSSL_FUNC_BIO_CTRL = @as(c_int, 50);
pub const OSSL_FUNC_SELF_TEST_CB = @as(c_int, 100);
pub const OSSL_FUNC_GET_ENTROPY = @as(c_int, 101);
pub const OSSL_FUNC_CLEANUP_ENTROPY = @as(c_int, 102);
pub const OSSL_FUNC_GET_NONCE = @as(c_int, 103);
pub const OSSL_FUNC_CLEANUP_NONCE = @as(c_int, 104);
pub const OSSL_FUNC_PROVIDER_REGISTER_CHILD_CB = @as(c_int, 105);
pub const OSSL_FUNC_PROVIDER_DEREGISTER_CHILD_CB = @as(c_int, 106);
pub const OSSL_FUNC_PROVIDER_NAME = @as(c_int, 107);
pub const OSSL_FUNC_PROVIDER_GET0_PROVIDER_CTX = @as(c_int, 108);
pub const OSSL_FUNC_PROVIDER_GET0_DISPATCH = @as(c_int, 109);
pub const OSSL_FUNC_PROVIDER_UP_REF = @as(c_int, 110);
pub const OSSL_FUNC_PROVIDER_FREE = @as(c_int, 111);
pub const OSSL_FUNC_PROVIDER_TEARDOWN = @as(c_int, 1024);
pub const OSSL_FUNC_PROVIDER_GETTABLE_PARAMS = @as(c_int, 1025);
pub const OSSL_FUNC_PROVIDER_GET_PARAMS = @as(c_int, 1026);
pub const OSSL_FUNC_PROVIDER_QUERY_OPERATION = @as(c_int, 1027);
pub const OSSL_FUNC_PROVIDER_UNQUERY_OPERATION = @as(c_int, 1028);
pub const OSSL_FUNC_PROVIDER_GET_REASON_STRINGS = @as(c_int, 1029);
pub const OSSL_FUNC_PROVIDER_GET_CAPABILITIES = @as(c_int, 1030);
pub const OSSL_FUNC_PROVIDER_SELF_TEST = @as(c_int, 1031);
pub const OSSL_OP_DIGEST = @as(c_int, 1);
pub const OSSL_OP_CIPHER = @as(c_int, 2);
pub const OSSL_OP_MAC = @as(c_int, 3);
pub const OSSL_OP_KDF = @as(c_int, 4);
pub const OSSL_OP_RAND = @as(c_int, 5);
pub const OSSL_OP_KEYMGMT = @as(c_int, 10);
pub const OSSL_OP_KEYEXCH = @as(c_int, 11);
pub const OSSL_OP_SIGNATURE = @as(c_int, 12);
pub const OSSL_OP_ASYM_CIPHER = @as(c_int, 13);
pub const OSSL_OP_KEM = @as(c_int, 14);
pub const OSSL_OP_ENCODER = @as(c_int, 20);
pub const OSSL_OP_DECODER = @as(c_int, 21);
pub const OSSL_OP_STORE = @as(c_int, 22);
pub const OSSL_OP__HIGHEST = @as(c_int, 22);
pub const OSSL_FUNC_DIGEST_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_DIGEST_INIT = @as(c_int, 2);
pub const OSSL_FUNC_DIGEST_UPDATE = @as(c_int, 3);
pub const OSSL_FUNC_DIGEST_FINAL = @as(c_int, 4);
pub const OSSL_FUNC_DIGEST_DIGEST = @as(c_int, 5);
pub const OSSL_FUNC_DIGEST_FREECTX = @as(c_int, 6);
pub const OSSL_FUNC_DIGEST_DUPCTX = @as(c_int, 7);
pub const OSSL_FUNC_DIGEST_GET_PARAMS = @as(c_int, 8);
pub const OSSL_FUNC_DIGEST_SET_CTX_PARAMS = @as(c_int, 9);
pub const OSSL_FUNC_DIGEST_GET_CTX_PARAMS = @as(c_int, 10);
pub const OSSL_FUNC_DIGEST_GETTABLE_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_DIGEST_SETTABLE_CTX_PARAMS = @as(c_int, 12);
pub const OSSL_FUNC_DIGEST_GETTABLE_CTX_PARAMS = @as(c_int, 13);
pub const OSSL_FUNC_CIPHER_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_CIPHER_ENCRYPT_INIT = @as(c_int, 2);
pub const OSSL_FUNC_CIPHER_DECRYPT_INIT = @as(c_int, 3);
pub const OSSL_FUNC_CIPHER_UPDATE = @as(c_int, 4);
pub const OSSL_FUNC_CIPHER_FINAL = @as(c_int, 5);
pub const OSSL_FUNC_CIPHER_CIPHER = @as(c_int, 6);
pub const OSSL_FUNC_CIPHER_FREECTX = @as(c_int, 7);
pub const OSSL_FUNC_CIPHER_DUPCTX = @as(c_int, 8);
pub const OSSL_FUNC_CIPHER_GET_PARAMS = @as(c_int, 9);
pub const OSSL_FUNC_CIPHER_GET_CTX_PARAMS = @as(c_int, 10);
pub const OSSL_FUNC_CIPHER_SET_CTX_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_CIPHER_GETTABLE_PARAMS = @as(c_int, 12);
pub const OSSL_FUNC_CIPHER_GETTABLE_CTX_PARAMS = @as(c_int, 13);
pub const OSSL_FUNC_CIPHER_SETTABLE_CTX_PARAMS = @as(c_int, 14);
pub const OSSL_FUNC_MAC_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_MAC_DUPCTX = @as(c_int, 2);
pub const OSSL_FUNC_MAC_FREECTX = @as(c_int, 3);
pub const OSSL_FUNC_MAC_INIT = @as(c_int, 4);
pub const OSSL_FUNC_MAC_UPDATE = @as(c_int, 5);
pub const OSSL_FUNC_MAC_FINAL = @as(c_int, 6);
pub const OSSL_FUNC_MAC_GET_PARAMS = @as(c_int, 7);
pub const OSSL_FUNC_MAC_GET_CTX_PARAMS = @as(c_int, 8);
pub const OSSL_FUNC_MAC_SET_CTX_PARAMS = @as(c_int, 9);
pub const OSSL_FUNC_MAC_GETTABLE_PARAMS = @as(c_int, 10);
pub const OSSL_FUNC_MAC_GETTABLE_CTX_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_MAC_SETTABLE_CTX_PARAMS = @as(c_int, 12);
pub const OSSL_FUNC_KDF_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_KDF_DUPCTX = @as(c_int, 2);
pub const OSSL_FUNC_KDF_FREECTX = @as(c_int, 3);
pub const OSSL_FUNC_KDF_RESET = @as(c_int, 4);
pub const OSSL_FUNC_KDF_DERIVE = @as(c_int, 5);
pub const OSSL_FUNC_KDF_GETTABLE_PARAMS = @as(c_int, 6);
pub const OSSL_FUNC_KDF_GETTABLE_CTX_PARAMS = @as(c_int, 7);
pub const OSSL_FUNC_KDF_SETTABLE_CTX_PARAMS = @as(c_int, 8);
pub const OSSL_FUNC_KDF_GET_PARAMS = @as(c_int, 9);
pub const OSSL_FUNC_KDF_GET_CTX_PARAMS = @as(c_int, 10);
pub const OSSL_FUNC_KDF_SET_CTX_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_RAND_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_RAND_FREECTX = @as(c_int, 2);
pub const OSSL_FUNC_RAND_INSTANTIATE = @as(c_int, 3);
pub const OSSL_FUNC_RAND_UNINSTANTIATE = @as(c_int, 4);
pub const OSSL_FUNC_RAND_GENERATE = @as(c_int, 5);
pub const OSSL_FUNC_RAND_RESEED = @as(c_int, 6);
pub const OSSL_FUNC_RAND_NONCE = @as(c_int, 7);
pub const OSSL_FUNC_RAND_ENABLE_LOCKING = @as(c_int, 8);
pub const OSSL_FUNC_RAND_LOCK = @as(c_int, 9);
pub const OSSL_FUNC_RAND_UNLOCK = @as(c_int, 10);
pub const OSSL_FUNC_RAND_GETTABLE_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_RAND_GETTABLE_CTX_PARAMS = @as(c_int, 12);
pub const OSSL_FUNC_RAND_SETTABLE_CTX_PARAMS = @as(c_int, 13);
pub const OSSL_FUNC_RAND_GET_PARAMS = @as(c_int, 14);
pub const OSSL_FUNC_RAND_GET_CTX_PARAMS = @as(c_int, 15);
pub const OSSL_FUNC_RAND_SET_CTX_PARAMS = @as(c_int, 16);
pub const OSSL_FUNC_RAND_VERIFY_ZEROIZATION = @as(c_int, 17);
pub const OSSL_FUNC_RAND_GET_SEED = @as(c_int, 18);
pub const OSSL_FUNC_RAND_CLEAR_SEED = @as(c_int, 19);
pub const OSSL_KEYMGMT_SELECT_PRIVATE_KEY = @as(c_int, 0x01);
pub const OSSL_KEYMGMT_SELECT_PUBLIC_KEY = @as(c_int, 0x02);
pub const OSSL_KEYMGMT_SELECT_DOMAIN_PARAMETERS = @as(c_int, 0x04);
pub const OSSL_KEYMGMT_SELECT_OTHER_PARAMETERS = @as(c_int, 0x80);
pub const OSSL_KEYMGMT_SELECT_ALL_PARAMETERS = OSSL_KEYMGMT_SELECT_DOMAIN_PARAMETERS | OSSL_KEYMGMT_SELECT_OTHER_PARAMETERS;
pub const OSSL_KEYMGMT_SELECT_KEYPAIR = OSSL_KEYMGMT_SELECT_PRIVATE_KEY | OSSL_KEYMGMT_SELECT_PUBLIC_KEY;
pub const OSSL_KEYMGMT_SELECT_ALL = OSSL_KEYMGMT_SELECT_KEYPAIR | OSSL_KEYMGMT_SELECT_ALL_PARAMETERS;
pub const OSSL_KEYMGMT_VALIDATE_FULL_CHECK = @as(c_int, 0);
pub const OSSL_KEYMGMT_VALIDATE_QUICK_CHECK = @as(c_int, 1);
pub const OSSL_FUNC_KEYMGMT_NEW = @as(c_int, 1);
pub const OSSL_FUNC_KEYMGMT_GEN_INIT = @as(c_int, 2);
pub const OSSL_FUNC_KEYMGMT_GEN_SET_TEMPLATE = @as(c_int, 3);
pub const OSSL_FUNC_KEYMGMT_GEN_SET_PARAMS = @as(c_int, 4);
pub const OSSL_FUNC_KEYMGMT_GEN_SETTABLE_PARAMS = @as(c_int, 5);
pub const OSSL_FUNC_KEYMGMT_GEN = @as(c_int, 6);
pub const OSSL_FUNC_KEYMGMT_GEN_CLEANUP = @as(c_int, 7);
pub const OSSL_FUNC_KEYMGMT_LOAD = @as(c_int, 8);
pub const OSSL_FUNC_KEYMGMT_FREE = @as(c_int, 10);
pub const OSSL_FUNC_KEYMGMT_GET_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_KEYMGMT_GETTABLE_PARAMS = @as(c_int, 12);
pub const OSSL_FUNC_KEYMGMT_SET_PARAMS = @as(c_int, 13);
pub const OSSL_FUNC_KEYMGMT_SETTABLE_PARAMS = @as(c_int, 14);
pub const OSSL_FUNC_KEYMGMT_QUERY_OPERATION_NAME = @as(c_int, 20);
pub const OSSL_FUNC_KEYMGMT_HAS = @as(c_int, 21);
pub const OSSL_FUNC_KEYMGMT_VALIDATE = @as(c_int, 22);
pub const OSSL_FUNC_KEYMGMT_MATCH = @as(c_int, 23);
pub const OSSL_FUNC_KEYMGMT_IMPORT = @as(c_int, 40);
pub const OSSL_FUNC_KEYMGMT_IMPORT_TYPES = @as(c_int, 41);
pub const OSSL_FUNC_KEYMGMT_EXPORT = @as(c_int, 42);
pub const OSSL_FUNC_KEYMGMT_EXPORT_TYPES = @as(c_int, 43);
pub const OSSL_FUNC_KEYMGMT_DUP = @as(c_int, 44);
pub const OSSL_FUNC_KEYEXCH_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_KEYEXCH_INIT = @as(c_int, 2);
pub const OSSL_FUNC_KEYEXCH_DERIVE = @as(c_int, 3);
pub const OSSL_FUNC_KEYEXCH_SET_PEER = @as(c_int, 4);
pub const OSSL_FUNC_KEYEXCH_FREECTX = @as(c_int, 5);
pub const OSSL_FUNC_KEYEXCH_DUPCTX = @as(c_int, 6);
pub const OSSL_FUNC_KEYEXCH_SET_CTX_PARAMS = @as(c_int, 7);
pub const OSSL_FUNC_KEYEXCH_SETTABLE_CTX_PARAMS = @as(c_int, 8);
pub const OSSL_FUNC_KEYEXCH_GET_CTX_PARAMS = @as(c_int, 9);
pub const OSSL_FUNC_KEYEXCH_GETTABLE_CTX_PARAMS = @as(c_int, 10);
pub const OSSL_FUNC_SIGNATURE_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_SIGNATURE_SIGN_INIT = @as(c_int, 2);
pub const OSSL_FUNC_SIGNATURE_SIGN = @as(c_int, 3);
pub const OSSL_FUNC_SIGNATURE_VERIFY_INIT = @as(c_int, 4);
pub const OSSL_FUNC_SIGNATURE_VERIFY = @as(c_int, 5);
pub const OSSL_FUNC_SIGNATURE_VERIFY_RECOVER_INIT = @as(c_int, 6);
pub const OSSL_FUNC_SIGNATURE_VERIFY_RECOVER = @as(c_int, 7);
pub const OSSL_FUNC_SIGNATURE_DIGEST_SIGN_INIT = @as(c_int, 8);
pub const OSSL_FUNC_SIGNATURE_DIGEST_SIGN_UPDATE = @as(c_int, 9);
pub const OSSL_FUNC_SIGNATURE_DIGEST_SIGN_FINAL = @as(c_int, 10);
pub const OSSL_FUNC_SIGNATURE_DIGEST_SIGN = @as(c_int, 11);
pub const OSSL_FUNC_SIGNATURE_DIGEST_VERIFY_INIT = @as(c_int, 12);
pub const OSSL_FUNC_SIGNATURE_DIGEST_VERIFY_UPDATE = @as(c_int, 13);
pub const OSSL_FUNC_SIGNATURE_DIGEST_VERIFY_FINAL = @as(c_int, 14);
pub const OSSL_FUNC_SIGNATURE_DIGEST_VERIFY = @as(c_int, 15);
pub const OSSL_FUNC_SIGNATURE_FREECTX = @as(c_int, 16);
pub const OSSL_FUNC_SIGNATURE_DUPCTX = @as(c_int, 17);
pub const OSSL_FUNC_SIGNATURE_GET_CTX_PARAMS = @as(c_int, 18);
pub const OSSL_FUNC_SIGNATURE_GETTABLE_CTX_PARAMS = @as(c_int, 19);
pub const OSSL_FUNC_SIGNATURE_SET_CTX_PARAMS = @as(c_int, 20);
pub const OSSL_FUNC_SIGNATURE_SETTABLE_CTX_PARAMS = @as(c_int, 21);
pub const OSSL_FUNC_SIGNATURE_GET_CTX_MD_PARAMS = @as(c_int, 22);
pub const OSSL_FUNC_SIGNATURE_GETTABLE_CTX_MD_PARAMS = @as(c_int, 23);
pub const OSSL_FUNC_SIGNATURE_SET_CTX_MD_PARAMS = @as(c_int, 24);
pub const OSSL_FUNC_SIGNATURE_SETTABLE_CTX_MD_PARAMS = @as(c_int, 25);
pub const OSSL_FUNC_ASYM_CIPHER_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_ASYM_CIPHER_ENCRYPT_INIT = @as(c_int, 2);
pub const OSSL_FUNC_ASYM_CIPHER_ENCRYPT = @as(c_int, 3);
pub const OSSL_FUNC_ASYM_CIPHER_DECRYPT_INIT = @as(c_int, 4);
pub const OSSL_FUNC_ASYM_CIPHER_DECRYPT = @as(c_int, 5);
pub const OSSL_FUNC_ASYM_CIPHER_FREECTX = @as(c_int, 6);
pub const OSSL_FUNC_ASYM_CIPHER_DUPCTX = @as(c_int, 7);
pub const OSSL_FUNC_ASYM_CIPHER_GET_CTX_PARAMS = @as(c_int, 8);
pub const OSSL_FUNC_ASYM_CIPHER_GETTABLE_CTX_PARAMS = @as(c_int, 9);
pub const OSSL_FUNC_ASYM_CIPHER_SET_CTX_PARAMS = @as(c_int, 10);
pub const OSSL_FUNC_ASYM_CIPHER_SETTABLE_CTX_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_KEM_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_KEM_ENCAPSULATE_INIT = @as(c_int, 2);
pub const OSSL_FUNC_KEM_ENCAPSULATE = @as(c_int, 3);
pub const OSSL_FUNC_KEM_DECAPSULATE_INIT = @as(c_int, 4);
pub const OSSL_FUNC_KEM_DECAPSULATE = @as(c_int, 5);
pub const OSSL_FUNC_KEM_FREECTX = @as(c_int, 6);
pub const OSSL_FUNC_KEM_DUPCTX = @as(c_int, 7);
pub const OSSL_FUNC_KEM_GET_CTX_PARAMS = @as(c_int, 8);
pub const OSSL_FUNC_KEM_GETTABLE_CTX_PARAMS = @as(c_int, 9);
pub const OSSL_FUNC_KEM_SET_CTX_PARAMS = @as(c_int, 10);
pub const OSSL_FUNC_KEM_SETTABLE_CTX_PARAMS = @as(c_int, 11);
pub const OSSL_FUNC_ENCODER_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_ENCODER_FREECTX = @as(c_int, 2);
pub const OSSL_FUNC_ENCODER_GET_PARAMS = @as(c_int, 3);
pub const OSSL_FUNC_ENCODER_GETTABLE_PARAMS = @as(c_int, 4);
pub const OSSL_FUNC_ENCODER_SET_CTX_PARAMS = @as(c_int, 5);
pub const OSSL_FUNC_ENCODER_SETTABLE_CTX_PARAMS = @as(c_int, 6);
pub const OSSL_FUNC_ENCODER_DOES_SELECTION = @as(c_int, 10);
pub const OSSL_FUNC_ENCODER_ENCODE = @as(c_int, 11);
pub const OSSL_FUNC_ENCODER_IMPORT_OBJECT = @as(c_int, 20);
pub const OSSL_FUNC_ENCODER_FREE_OBJECT = @as(c_int, 21);
pub const OSSL_FUNC_DECODER_NEWCTX = @as(c_int, 1);
pub const OSSL_FUNC_DECODER_FREECTX = @as(c_int, 2);
pub const OSSL_FUNC_DECODER_GET_PARAMS = @as(c_int, 3);
pub const OSSL_FUNC_DECODER_GETTABLE_PARAMS = @as(c_int, 4);
pub const OSSL_FUNC_DECODER_SET_CTX_PARAMS = @as(c_int, 5);
pub const OSSL_FUNC_DECODER_SETTABLE_CTX_PARAMS = @as(c_int, 6);
pub const OSSL_FUNC_DECODER_DOES_SELECTION = @as(c_int, 10);
pub const OSSL_FUNC_DECODER_DECODE = @as(c_int, 11);
pub const OSSL_FUNC_DECODER_EXPORT_OBJECT = @as(c_int, 20);
pub const OSSL_FUNC_STORE_OPEN = @as(c_int, 1);
pub const OSSL_FUNC_STORE_ATTACH = @as(c_int, 2);
pub const OSSL_FUNC_STORE_SETTABLE_CTX_PARAMS = @as(c_int, 3);
pub const OSSL_FUNC_STORE_SET_CTX_PARAMS = @as(c_int, 4);
pub const OSSL_FUNC_STORE_LOAD = @as(c_int, 5);
pub const OSSL_FUNC_STORE_EOF = @as(c_int, 6);
pub const OSSL_FUNC_STORE_CLOSE = @as(c_int, 7);
pub const OSSL_FUNC_STORE_EXPORT_OBJECT = @as(c_int, 8);
pub const OPENSSL_SYMHACKS_H = "";
pub const HEADER_SYMHACKS_H = "";
pub const OPENSSL_BIO_H = "";
pub const HEADER_BIO_H = "";
pub const OPENSSL_CRYPTO_H = "";
pub const HEADER_CRYPTO_H = "";
pub const _STDLIB_H = @as(c_int, 1);
pub const WNOHANG = @as(c_int, 1);
pub const WUNTRACED = @as(c_int, 2);
pub const WSTOPPED = @as(c_int, 2);
pub const WEXITED = @as(c_int, 4);
pub const WCONTINUED = @as(c_int, 8);
pub const WNOWAIT = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x01000000, .hex);
pub const __WNOTHREAD = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x20000000, .hex);
pub const __WALL = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x40000000, .hex);
pub const __WCLONE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x80000000, .hex);
pub inline fn __WEXITSTATUS(status: anytype) @TypeOf((status & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff00, .hex)) >> @as(c_int, 8)) {
    _ = &status;
    return (status & @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xff00, .hex)) >> @as(c_int, 8);
}
pub inline fn __WTERMSIG(status: anytype) @TypeOf(status & @as(c_int, 0x7f)) {
    _ = &status;
    return status & @as(c_int, 0x7f);
}
pub inline fn __WSTOPSIG(status: anytype) @TypeOf(__WEXITSTATUS(status)) {
    _ = &status;
    return __WEXITSTATUS(status);
}
pub inline fn __WIFEXITED(status: anytype) @TypeOf(__WTERMSIG(status) == @as(c_int, 0)) {
    _ = &status;
    return __WTERMSIG(status) == @as(c_int, 0);
}
pub inline fn __WIFSIGNALED(status: anytype) @TypeOf((@import("std").zig.c_translation.cast(i8, (status & @as(c_int, 0x7f)) + @as(c_int, 1)) >> @as(c_int, 1)) > @as(c_int, 0)) {
    _ = &status;
    return (@import("std").zig.c_translation.cast(i8, (status & @as(c_int, 0x7f)) + @as(c_int, 1)) >> @as(c_int, 1)) > @as(c_int, 0);
}
pub inline fn __WIFSTOPPED(status: anytype) @TypeOf((status & @as(c_int, 0xff)) == @as(c_int, 0x7f)) {
    _ = &status;
    return (status & @as(c_int, 0xff)) == @as(c_int, 0x7f);
}
pub inline fn __WIFCONTINUED(status: anytype) @TypeOf(status == __W_CONTINUED) {
    _ = &status;
    return status == __W_CONTINUED;
}
pub inline fn __WCOREDUMP(status: anytype) @TypeOf(status & __WCOREFLAG) {
    _ = &status;
    return status & __WCOREFLAG;
}
pub inline fn __W_EXITCODE(ret: anytype, sig: anytype) @TypeOf((ret << @as(c_int, 8)) | sig) {
    _ = &ret;
    _ = &sig;
    return (ret << @as(c_int, 8)) | sig;
}
pub inline fn __W_STOPCODE(sig: anytype) @TypeOf((sig << @as(c_int, 8)) | @as(c_int, 0x7f)) {
    _ = &sig;
    return (sig << @as(c_int, 8)) | @as(c_int, 0x7f);
}
pub const __W_CONTINUED = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xffff, .hex);
pub const __WCOREFLAG = @as(c_int, 0x80);
pub inline fn WEXITSTATUS(status: anytype) @TypeOf(__WEXITSTATUS(status)) {
    _ = &status;
    return __WEXITSTATUS(status);
}
pub inline fn WTERMSIG(status: anytype) @TypeOf(__WTERMSIG(status)) {
    _ = &status;
    return __WTERMSIG(status);
}
pub inline fn WSTOPSIG(status: anytype) @TypeOf(__WSTOPSIG(status)) {
    _ = &status;
    return __WSTOPSIG(status);
}
pub inline fn WIFEXITED(status: anytype) @TypeOf(__WIFEXITED(status)) {
    _ = &status;
    return __WIFEXITED(status);
}
pub inline fn WIFSIGNALED(status: anytype) @TypeOf(__WIFSIGNALED(status)) {
    _ = &status;
    return __WIFSIGNALED(status);
}
pub inline fn WIFSTOPPED(status: anytype) @TypeOf(__WIFSTOPPED(status)) {
    _ = &status;
    return __WIFSTOPPED(status);
}
pub inline fn WIFCONTINUED(status: anytype) @TypeOf(__WIFCONTINUED(status)) {
    _ = &status;
    return __WIFCONTINUED(status);
}
pub const __ldiv_t_defined = @as(c_int, 1);
pub const __lldiv_t_defined = @as(c_int, 1);
pub const RAND_MAX = @import("std").zig.c_translation.promoteIntLiteral(c_int, 2147483647, .decimal);
pub const EXIT_FAILURE = @as(c_int, 1);
pub const EXIT_SUCCESS = @as(c_int, 0);
pub const MB_CUR_MAX = __ctype_get_mb_cur_max();
pub const _SYS_TYPES_H = @as(c_int, 1);
pub const __u_char_defined = "";
pub const __ino_t_defined = "";
pub const __dev_t_defined = "";
pub const __gid_t_defined = "";
pub const __mode_t_defined = "";
pub const __nlink_t_defined = "";
pub const __uid_t_defined = "";
pub const __pid_t_defined = "";
pub const __id_t_defined = "";
pub const __daddr_t_defined = "";
pub const __key_t_defined = "";
pub const __clock_t_defined = @as(c_int, 1);
pub const __clockid_t_defined = @as(c_int, 1);
pub const __time_t_defined = @as(c_int, 1);
pub const __timer_t_defined = @as(c_int, 1);
pub const __BIT_TYPES_DEFINED__ = @as(c_int, 1);
pub const _ENDIAN_H = @as(c_int, 1);
pub const _BITS_ENDIAN_H = @as(c_int, 1);
pub const __LITTLE_ENDIAN = @as(c_int, 1234);
pub const __BIG_ENDIAN = @as(c_int, 4321);
pub const __PDP_ENDIAN = @as(c_int, 3412);
pub const _BITS_ENDIANNESS_H = @as(c_int, 1);
pub const __BYTE_ORDER = __LITTLE_ENDIAN;
pub const __FLOAT_WORD_ORDER = __BYTE_ORDER;
pub inline fn __LONG_LONG_PAIR(HI: anytype, LO: anytype) @TypeOf(HI) {
    _ = &HI;
    _ = &LO;
    return blk: {
        _ = &LO;
        break :blk HI;
    };
}
pub const LITTLE_ENDIAN = __LITTLE_ENDIAN;
pub const BIG_ENDIAN = __BIG_ENDIAN;
pub const PDP_ENDIAN = __PDP_ENDIAN;
pub const BYTE_ORDER = __BYTE_ORDER;
pub const _BITS_BYTESWAP_H = @as(c_int, 1);
pub inline fn __bswap_constant_16(x: anytype) __uint16_t {
    _ = &x;
    return @import("std").zig.c_translation.cast(__uint16_t, ((x >> @as(c_int, 8)) & @as(c_int, 0xff)) | ((x & @as(c_int, 0xff)) << @as(c_int, 8)));
}
pub inline fn __bswap_constant_32(x: anytype) @TypeOf(((((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24))) {
    _ = &x;
    return ((((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0xff000000, .hex)) >> @as(c_int, 24)) | ((x & @import("std").zig.c_translation.promoteIntLiteral(c_uint, 0x00ff0000, .hex)) >> @as(c_int, 8))) | ((x & @as(c_uint, 0x0000ff00)) << @as(c_int, 8))) | ((x & @as(c_uint, 0x000000ff)) << @as(c_int, 24));
}
pub inline fn __bswap_constant_64(x: anytype) @TypeOf(((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56))) {
    _ = &x;
    return ((((((((x & @as(c_ulonglong, 0xff00000000000000)) >> @as(c_int, 56)) | ((x & @as(c_ulonglong, 0x00ff000000000000)) >> @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x0000ff0000000000)) >> @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000ff00000000)) >> @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x00000000ff000000)) << @as(c_int, 8))) | ((x & @as(c_ulonglong, 0x0000000000ff0000)) << @as(c_int, 24))) | ((x & @as(c_ulonglong, 0x000000000000ff00)) << @as(c_int, 40))) | ((x & @as(c_ulonglong, 0x00000000000000ff)) << @as(c_int, 56));
}
pub const _BITS_UINTN_IDENTITY_H = @as(c_int, 1);
pub inline fn htobe16(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn htole16(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn be16toh(x: anytype) @TypeOf(__bswap_16(x)) {
    _ = &x;
    return __bswap_16(x);
}
pub inline fn le16toh(x: anytype) @TypeOf(__uint16_identity(x)) {
    _ = &x;
    return __uint16_identity(x);
}
pub inline fn htobe32(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn htole32(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn be32toh(x: anytype) @TypeOf(__bswap_32(x)) {
    _ = &x;
    return __bswap_32(x);
}
pub inline fn le32toh(x: anytype) @TypeOf(__uint32_identity(x)) {
    _ = &x;
    return __uint32_identity(x);
}
pub inline fn htobe64(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn htole64(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub inline fn be64toh(x: anytype) @TypeOf(__bswap_64(x)) {
    _ = &x;
    return __bswap_64(x);
}
pub inline fn le64toh(x: anytype) @TypeOf(__uint64_identity(x)) {
    _ = &x;
    return __uint64_identity(x);
}
pub const _SYS_SELECT_H = @as(c_int, 1);
pub const __FD_ZERO = @compileError("unable to translate macro: undefined identifier `__i`");
// /usr/include/x86_64-linux-gnu/bits/select.h:25:9
pub const __FD_SET = @compileError("unable to translate C expr: expected ')' instead got '|='");
// /usr/include/x86_64-linux-gnu/bits/select.h:32:9
pub const __FD_CLR = @compileError("unable to translate C expr: expected ')' instead got '&='");
// /usr/include/x86_64-linux-gnu/bits/select.h:34:9
pub inline fn __FD_ISSET(d: anytype, s: anytype) @TypeOf((__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0)) {
    _ = &d;
    _ = &s;
    return (__FDS_BITS(s)[@as(usize, @intCast(__FD_ELT(d)))] & __FD_MASK(d)) != @as(c_int, 0);
}
pub const __sigset_t_defined = @as(c_int, 1);
pub const ____sigset_t_defined = "";
pub const _SIGSET_NWORDS = @import("std").zig.c_translation.MacroArithmetic.div(@as(c_int, 1024), @as(c_int, 8) * @import("std").zig.c_translation.sizeof(c_ulong));
pub const __timeval_defined = @as(c_int, 1);
pub const _STRUCT_TIMESPEC = @as(c_int, 1);
pub const __suseconds_t_defined = "";
pub const __NFDBITS = @as(c_int, 8) * @import("std").zig.c_translation.cast(c_int, @import("std").zig.c_translation.sizeof(__fd_mask));
pub inline fn __FD_ELT(d: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(d, __NFDBITS)) {
    _ = &d;
    return @import("std").zig.c_translation.MacroArithmetic.div(d, __NFDBITS);
}
pub inline fn __FD_MASK(d: anytype) __fd_mask {
    _ = &d;
    return @import("std").zig.c_translation.cast(__fd_mask, @as(c_ulong, 1) << @import("std").zig.c_translation.MacroArithmetic.rem(d, __NFDBITS));
}
pub inline fn __FDS_BITS(set: anytype) @TypeOf(set.*.__fds_bits) {
    _ = &set;
    return set.*.__fds_bits;
}
pub const FD_SETSIZE = __FD_SETSIZE;
pub const NFDBITS = __NFDBITS;
pub inline fn FD_SET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_SET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_SET(fd, fdsetp);
}
pub inline fn FD_CLR(fd: anytype, fdsetp: anytype) @TypeOf(__FD_CLR(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_CLR(fd, fdsetp);
}
pub inline fn FD_ISSET(fd: anytype, fdsetp: anytype) @TypeOf(__FD_ISSET(fd, fdsetp)) {
    _ = &fd;
    _ = &fdsetp;
    return __FD_ISSET(fd, fdsetp);
}
pub inline fn FD_ZERO(fdsetp: anytype) @TypeOf(__FD_ZERO(fdsetp)) {
    _ = &fdsetp;
    return __FD_ZERO(fdsetp);
}
pub const __blksize_t_defined = "";
pub const __blkcnt_t_defined = "";
pub const __fsblkcnt_t_defined = "";
pub const __fsfilcnt_t_defined = "";
pub const _BITS_PTHREADTYPES_COMMON_H = @as(c_int, 1);
pub const _THREAD_SHARED_TYPES_H = @as(c_int, 1);
pub const _BITS_PTHREADTYPES_ARCH_H = @as(c_int, 1);
pub const __SIZEOF_PTHREAD_MUTEX_T = @as(c_int, 40);
pub const __SIZEOF_PTHREAD_ATTR_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_RWLOCK_T = @as(c_int, 56);
pub const __SIZEOF_PTHREAD_BARRIER_T = @as(c_int, 32);
pub const __SIZEOF_PTHREAD_MUTEXATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_COND_T = @as(c_int, 48);
pub const __SIZEOF_PTHREAD_CONDATTR_T = @as(c_int, 4);
pub const __SIZEOF_PTHREAD_RWLOCKATTR_T = @as(c_int, 8);
pub const __SIZEOF_PTHREAD_BARRIERATTR_T = @as(c_int, 4);
pub const __LOCK_ALIGNMENT = "";
pub const __ONCE_ALIGNMENT = "";
pub const _BITS_ATOMIC_WIDE_COUNTER_H = "";
pub const _THREAD_MUTEX_INTERNAL_H = @as(c_int, 1);
pub const __PTHREAD_MUTEX_HAVE_PREV = @as(c_int, 1);
pub const __PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/x86_64-linux-gnu/bits/struct_mutex.h:56:10
pub const _RWLOCK_INTERNAL_H = "";
pub const __PTHREAD_RWLOCK_ELISION_EXTRA = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/x86_64-linux-gnu/bits/struct_rwlock.h:40:11
pub inline fn __PTHREAD_RWLOCK_INITIALIZER(__flags: anytype) @TypeOf(__flags) {
    _ = &__flags;
    return blk: {
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = @as(c_int, 0);
        _ = &__PTHREAD_RWLOCK_ELISION_EXTRA;
        _ = @as(c_int, 0);
        break :blk __flags;
    };
}
pub const __ONCE_FLAG_INIT = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/x86_64-linux-gnu/bits/thread-shared-types.h:113:9
pub const __have_pthread_attr_t = @as(c_int, 1);
pub const _ALLOCA_H = @as(c_int, 1);
pub const __COMPAR_FN_T = "";
pub const _TIME_H = @as(c_int, 1);
pub const _BITS_TIME_H = @as(c_int, 1);
pub const CLOCKS_PER_SEC = @import("std").zig.c_translation.cast(__clock_t, @import("std").zig.c_translation.promoteIntLiteral(c_int, 1000000, .decimal));
pub const CLOCK_REALTIME = @as(c_int, 0);
pub const CLOCK_MONOTONIC = @as(c_int, 1);
pub const CLOCK_PROCESS_CPUTIME_ID = @as(c_int, 2);
pub const CLOCK_THREAD_CPUTIME_ID = @as(c_int, 3);
pub const CLOCK_MONOTONIC_RAW = @as(c_int, 4);
pub const CLOCK_REALTIME_COARSE = @as(c_int, 5);
pub const CLOCK_MONOTONIC_COARSE = @as(c_int, 6);
pub const CLOCK_BOOTTIME = @as(c_int, 7);
pub const CLOCK_REALTIME_ALARM = @as(c_int, 8);
pub const CLOCK_BOOTTIME_ALARM = @as(c_int, 9);
pub const CLOCK_TAI = @as(c_int, 11);
pub const TIMER_ABSTIME = @as(c_int, 1);
pub const __struct_tm_defined = @as(c_int, 1);
pub const __itimerspec_defined = @as(c_int, 1);
pub const _BITS_TYPES_LOCALE_T_H = @as(c_int, 1);
pub const _BITS_TYPES___LOCALE_T_H = @as(c_int, 1);
pub const TIME_UTC = @as(c_int, 1);
pub inline fn __isleap(year: anytype) @TypeOf((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 400)) == @as(c_int, 0)))) {
    _ = &year;
    return (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 4)) == @as(c_int, 0)) and ((@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 100)) != @as(c_int, 0)) or (@import("std").zig.c_translation.MacroArithmetic.rem(year, @as(c_int, 400)) == @as(c_int, 0)));
}
pub const OPENSSL_CRYPTOERR_H = "";
pub const OPENSSL_CRYPTOERR_LEGACY_H = "";
pub const ASN1_F_A2D_ASN1_OBJECT = @as(c_int, 0);
pub const ASN1_F_A2I_ASN1_INTEGER = @as(c_int, 0);
pub const ASN1_F_A2I_ASN1_STRING = @as(c_int, 0);
pub const ASN1_F_APPEND_EXP = @as(c_int, 0);
pub const ASN1_F_ASN1_BIO_INIT = @as(c_int, 0);
pub const ASN1_F_ASN1_BIT_STRING_SET_BIT = @as(c_int, 0);
pub const ASN1_F_ASN1_CB = @as(c_int, 0);
pub const ASN1_F_ASN1_CHECK_TLEN = @as(c_int, 0);
pub const ASN1_F_ASN1_COLLECT = @as(c_int, 0);
pub const ASN1_F_ASN1_D2I_EX_PRIMITIVE = @as(c_int, 0);
pub const ASN1_F_ASN1_D2I_FP = @as(c_int, 0);
pub const ASN1_F_ASN1_D2I_READ_BIO = @as(c_int, 0);
pub const ASN1_F_ASN1_DIGEST = @as(c_int, 0);
pub const ASN1_F_ASN1_DO_ADB = @as(c_int, 0);
pub const ASN1_F_ASN1_DO_LOCK = @as(c_int, 0);
pub const ASN1_F_ASN1_DUP = @as(c_int, 0);
pub const ASN1_F_ASN1_ENC_SAVE = @as(c_int, 0);
pub const ASN1_F_ASN1_EX_C2I = @as(c_int, 0);
pub const ASN1_F_ASN1_FIND_END = @as(c_int, 0);
pub const ASN1_F_ASN1_GENERALIZEDTIME_ADJ = @as(c_int, 0);
pub const ASN1_F_ASN1_GENERATE_V3 = @as(c_int, 0);
pub const ASN1_F_ASN1_GET_INT64 = @as(c_int, 0);
pub const ASN1_F_ASN1_GET_OBJECT = @as(c_int, 0);
pub const ASN1_F_ASN1_GET_UINT64 = @as(c_int, 0);
pub const ASN1_F_ASN1_I2D_BIO = @as(c_int, 0);
pub const ASN1_F_ASN1_I2D_FP = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_D2I_FP = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_DUP = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_EMBED_D2I = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_EMBED_NEW = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_FLAGS_I2D = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_I2D_BIO = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_I2D_FP = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_PACK = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_SIGN = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_SIGN_CTX = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_UNPACK = @as(c_int, 0);
pub const ASN1_F_ASN1_ITEM_VERIFY = @as(c_int, 0);
pub const ASN1_F_ASN1_MBSTRING_NCOPY = @as(c_int, 0);
pub const ASN1_F_ASN1_OBJECT_NEW = @as(c_int, 0);
pub const ASN1_F_ASN1_OUTPUT_DATA = @as(c_int, 0);
pub const ASN1_F_ASN1_PCTX_NEW = @as(c_int, 0);
pub const ASN1_F_ASN1_PRIMITIVE_NEW = @as(c_int, 0);
pub const ASN1_F_ASN1_SCTX_NEW = @as(c_int, 0);
pub const ASN1_F_ASN1_SIGN = @as(c_int, 0);
pub const ASN1_F_ASN1_STR2TYPE = @as(c_int, 0);
pub const ASN1_F_ASN1_STRING_GET_INT64 = @as(c_int, 0);
pub const ASN1_F_ASN1_STRING_GET_UINT64 = @as(c_int, 0);
pub const ASN1_F_ASN1_STRING_SET = @as(c_int, 0);
pub const ASN1_F_ASN1_STRING_TABLE_ADD = @as(c_int, 0);
pub const ASN1_F_ASN1_STRING_TO_BN = @as(c_int, 0);
pub const ASN1_F_ASN1_STRING_TYPE_NEW = @as(c_int, 0);
pub const ASN1_F_ASN1_TEMPLATE_EX_D2I = @as(c_int, 0);
pub const ASN1_F_ASN1_TEMPLATE_NEW = @as(c_int, 0);
pub const ASN1_F_ASN1_TEMPLATE_NOEXP_D2I = @as(c_int, 0);
pub const ASN1_F_ASN1_TIME_ADJ = @as(c_int, 0);
pub const ASN1_F_ASN1_TYPE_GET_INT_OCTETSTRING = @as(c_int, 0);
pub const ASN1_F_ASN1_TYPE_GET_OCTETSTRING = @as(c_int, 0);
pub const ASN1_F_ASN1_UTCTIME_ADJ = @as(c_int, 0);
pub const ASN1_F_ASN1_VERIFY = @as(c_int, 0);
pub const ASN1_F_B64_READ_ASN1 = @as(c_int, 0);
pub const ASN1_F_B64_WRITE_ASN1 = @as(c_int, 0);
pub const ASN1_F_BIO_NEW_NDEF = @as(c_int, 0);
pub const ASN1_F_BITSTR_CB = @as(c_int, 0);
pub const ASN1_F_BN_TO_ASN1_STRING = @as(c_int, 0);
pub const ASN1_F_C2I_ASN1_BIT_STRING = @as(c_int, 0);
pub const ASN1_F_C2I_ASN1_INTEGER = @as(c_int, 0);
pub const ASN1_F_C2I_ASN1_OBJECT = @as(c_int, 0);
pub const ASN1_F_C2I_IBUF = @as(c_int, 0);
pub const ASN1_F_C2I_UINT64_INT = @as(c_int, 0);
pub const ASN1_F_COLLECT_DATA = @as(c_int, 0);
pub const ASN1_F_D2I_ASN1_OBJECT = @as(c_int, 0);
pub const ASN1_F_D2I_ASN1_UINTEGER = @as(c_int, 0);
pub const ASN1_F_D2I_AUTOPRIVATEKEY = @as(c_int, 0);
pub const ASN1_F_D2I_PRIVATEKEY = @as(c_int, 0);
pub const ASN1_F_D2I_PUBLICKEY = @as(c_int, 0);
pub const ASN1_F_DO_BUF = @as(c_int, 0);
pub const ASN1_F_DO_CREATE = @as(c_int, 0);
pub const ASN1_F_DO_DUMP = @as(c_int, 0);
pub const ASN1_F_DO_TCREATE = @as(c_int, 0);
pub const ASN1_F_I2A_ASN1_OBJECT = @as(c_int, 0);
pub const ASN1_F_I2D_ASN1_BIO_STREAM = @as(c_int, 0);
pub const ASN1_F_I2D_ASN1_OBJECT = @as(c_int, 0);
pub const ASN1_F_I2D_DSA_PUBKEY = @as(c_int, 0);
pub const ASN1_F_I2D_EC_PUBKEY = @as(c_int, 0);
pub const ASN1_F_I2D_PRIVATEKEY = @as(c_int, 0);
pub const ASN1_F_I2D_PUBLICKEY = @as(c_int, 0);
pub const ASN1_F_I2D_RSA_PUBKEY = @as(c_int, 0);
pub const ASN1_F_LONG_C2I = @as(c_int, 0);
pub const ASN1_F_NDEF_PREFIX = @as(c_int, 0);
pub const ASN1_F_NDEF_SUFFIX = @as(c_int, 0);
pub const ASN1_F_OID_MODULE_INIT = @as(c_int, 0);
pub const ASN1_F_PARSE_TAGGING = @as(c_int, 0);
pub const ASN1_F_PKCS5_PBE2_SET_IV = @as(c_int, 0);
pub const ASN1_F_PKCS5_PBE2_SET_SCRYPT = @as(c_int, 0);
pub const ASN1_F_PKCS5_PBE_SET = @as(c_int, 0);
pub const ASN1_F_PKCS5_PBE_SET0_ALGOR = @as(c_int, 0);
pub const ASN1_F_PKCS5_PBKDF2_SET = @as(c_int, 0);
pub const ASN1_F_PKCS5_SCRYPT_SET = @as(c_int, 0);
pub const ASN1_F_SMIME_READ_ASN1 = @as(c_int, 0);
pub const ASN1_F_SMIME_TEXT = @as(c_int, 0);
pub const ASN1_F_STABLE_GET = @as(c_int, 0);
pub const ASN1_F_STBL_MODULE_INIT = @as(c_int, 0);
pub const ASN1_F_UINT32_C2I = @as(c_int, 0);
pub const ASN1_F_UINT32_NEW = @as(c_int, 0);
pub const ASN1_F_UINT64_C2I = @as(c_int, 0);
pub const ASN1_F_UINT64_NEW = @as(c_int, 0);
pub const ASN1_F_X509_CRL_ADD0_REVOKED = @as(c_int, 0);
pub const ASN1_F_X509_INFO_NEW = @as(c_int, 0);
pub const ASN1_F_X509_NAME_ENCODE = @as(c_int, 0);
pub const ASN1_F_X509_NAME_EX_D2I = @as(c_int, 0);
pub const ASN1_F_X509_NAME_EX_NEW = @as(c_int, 0);
pub const ASN1_F_X509_PKEY_NEW = @as(c_int, 0);
pub const ASYNC_F_ASYNC_CTX_NEW = @as(c_int, 0);
pub const ASYNC_F_ASYNC_INIT_THREAD = @as(c_int, 0);
pub const ASYNC_F_ASYNC_JOB_NEW = @as(c_int, 0);
pub const ASYNC_F_ASYNC_PAUSE_JOB = @as(c_int, 0);
pub const ASYNC_F_ASYNC_START_FUNC = @as(c_int, 0);
pub const ASYNC_F_ASYNC_START_JOB = @as(c_int, 0);
pub const ASYNC_F_ASYNC_WAIT_CTX_SET_WAIT_FD = @as(c_int, 0);
pub const BIO_F_ACPT_STATE = @as(c_int, 0);
pub const BIO_F_ADDRINFO_WRAP = @as(c_int, 0);
pub const BIO_F_ADDR_STRINGS = @as(c_int, 0);
pub const BIO_F_BIO_ACCEPT = @as(c_int, 0);
pub const BIO_F_BIO_ACCEPT_EX = @as(c_int, 0);
pub const BIO_F_BIO_ACCEPT_NEW = @as(c_int, 0);
pub const BIO_F_BIO_ADDR_NEW = @as(c_int, 0);
pub const BIO_F_BIO_BIND = @as(c_int, 0);
pub const BIO_F_BIO_CALLBACK_CTRL = @as(c_int, 0);
pub const BIO_F_BIO_CONNECT = @as(c_int, 0);
pub const BIO_F_BIO_CONNECT_NEW = @as(c_int, 0);
pub const BIO_F_BIO_CTRL = @as(c_int, 0);
pub const BIO_F_BIO_GETS = @as(c_int, 0);
pub const BIO_F_BIO_GET_HOST_IP = @as(c_int, 0);
pub const BIO_F_BIO_GET_NEW_INDEX = @as(c_int, 0);
pub const BIO_F_BIO_GET_PORT = @as(c_int, 0);
pub const BIO_F_BIO_LISTEN = @as(c_int, 0);
pub const BIO_F_BIO_LOOKUP = @as(c_int, 0);
pub const BIO_F_BIO_LOOKUP_EX = @as(c_int, 0);
pub const BIO_F_BIO_MAKE_PAIR = @as(c_int, 0);
pub const BIO_F_BIO_METH_NEW = @as(c_int, 0);
pub const BIO_F_BIO_NEW = @as(c_int, 0);
pub const BIO_F_BIO_NEW_DGRAM_SCTP = @as(c_int, 0);
pub const BIO_F_BIO_NEW_FILE = @as(c_int, 0);
pub const BIO_F_BIO_NEW_MEM_BUF = @as(c_int, 0);
pub const BIO_F_BIO_NREAD = @as(c_int, 0);
pub const BIO_F_BIO_NREAD0 = @as(c_int, 0);
pub const BIO_F_BIO_NWRITE = @as(c_int, 0);
pub const BIO_F_BIO_NWRITE0 = @as(c_int, 0);
pub const BIO_F_BIO_PARSE_HOSTSERV = @as(c_int, 0);
pub const BIO_F_BIO_PUTS = @as(c_int, 0);
pub const BIO_F_BIO_READ = @as(c_int, 0);
pub const BIO_F_BIO_READ_EX = @as(c_int, 0);
pub const BIO_F_BIO_READ_INTERN = @as(c_int, 0);
pub const BIO_F_BIO_SOCKET = @as(c_int, 0);
pub const BIO_F_BIO_SOCKET_NBIO = @as(c_int, 0);
pub const BIO_F_BIO_SOCK_INFO = @as(c_int, 0);
pub const BIO_F_BIO_SOCK_INIT = @as(c_int, 0);
pub const BIO_F_BIO_WRITE = @as(c_int, 0);
pub const BIO_F_BIO_WRITE_EX = @as(c_int, 0);
pub const BIO_F_BIO_WRITE_INTERN = @as(c_int, 0);
pub const BIO_F_BUFFER_CTRL = @as(c_int, 0);
pub const BIO_F_CONN_CTRL = @as(c_int, 0);
pub const BIO_F_CONN_STATE = @as(c_int, 0);
pub const BIO_F_DGRAM_SCTP_NEW = @as(c_int, 0);
pub const BIO_F_DGRAM_SCTP_READ = @as(c_int, 0);
pub const BIO_F_DGRAM_SCTP_WRITE = @as(c_int, 0);
pub const BIO_F_DOAPR_OUTCH = @as(c_int, 0);
pub const BIO_F_FILE_CTRL = @as(c_int, 0);
pub const BIO_F_FILE_READ = @as(c_int, 0);
pub const BIO_F_LINEBUFFER_CTRL = @as(c_int, 0);
pub const BIO_F_LINEBUFFER_NEW = @as(c_int, 0);
pub const BIO_F_MEM_WRITE = @as(c_int, 0);
pub const BIO_F_NBIOF_NEW = @as(c_int, 0);
pub const BIO_F_SLG_WRITE = @as(c_int, 0);
pub const BIO_F_SSL_NEW = @as(c_int, 0);
pub const BN_F_BNRAND = @as(c_int, 0);
pub const BN_F_BNRAND_RANGE = @as(c_int, 0);
pub const BN_F_BN_BLINDING_CONVERT_EX = @as(c_int, 0);
pub const BN_F_BN_BLINDING_CREATE_PARAM = @as(c_int, 0);
pub const BN_F_BN_BLINDING_INVERT_EX = @as(c_int, 0);
pub const BN_F_BN_BLINDING_NEW = @as(c_int, 0);
pub const BN_F_BN_BLINDING_UPDATE = @as(c_int, 0);
pub const BN_F_BN_BN2DEC = @as(c_int, 0);
pub const BN_F_BN_BN2HEX = @as(c_int, 0);
pub const BN_F_BN_COMPUTE_WNAF = @as(c_int, 0);
pub const BN_F_BN_CTX_GET = @as(c_int, 0);
pub const BN_F_BN_CTX_NEW = @as(c_int, 0);
pub const BN_F_BN_CTX_START = @as(c_int, 0);
pub const BN_F_BN_DIV = @as(c_int, 0);
pub const BN_F_BN_DIV_RECP = @as(c_int, 0);
pub const BN_F_BN_EXP = @as(c_int, 0);
pub const BN_F_BN_EXPAND_INTERNAL = @as(c_int, 0);
pub const BN_F_BN_GENCB_NEW = @as(c_int, 0);
pub const BN_F_BN_GENERATE_DSA_NONCE = @as(c_int, 0);
pub const BN_F_BN_GENERATE_PRIME_EX = @as(c_int, 0);
pub const BN_F_BN_GF2M_MOD = @as(c_int, 0);
pub const BN_F_BN_GF2M_MOD_EXP = @as(c_int, 0);
pub const BN_F_BN_GF2M_MOD_MUL = @as(c_int, 0);
pub const BN_F_BN_GF2M_MOD_SOLVE_QUAD = @as(c_int, 0);
pub const BN_F_BN_GF2M_MOD_SOLVE_QUAD_ARR = @as(c_int, 0);
pub const BN_F_BN_GF2M_MOD_SQR = @as(c_int, 0);
pub const BN_F_BN_GF2M_MOD_SQRT = @as(c_int, 0);
pub const BN_F_BN_LSHIFT = @as(c_int, 0);
pub const BN_F_BN_MOD_EXP2_MONT = @as(c_int, 0);
pub const BN_F_BN_MOD_EXP_MONT = @as(c_int, 0);
pub const BN_F_BN_MOD_EXP_MONT_CONSTTIME = @as(c_int, 0);
pub const BN_F_BN_MOD_EXP_MONT_WORD = @as(c_int, 0);
pub const BN_F_BN_MOD_EXP_RECP = @as(c_int, 0);
pub const BN_F_BN_MOD_EXP_SIMPLE = @as(c_int, 0);
pub const BN_F_BN_MOD_INVERSE = @as(c_int, 0);
pub const BN_F_BN_MOD_INVERSE_NO_BRANCH = @as(c_int, 0);
pub const BN_F_BN_MOD_LSHIFT_QUICK = @as(c_int, 0);
pub const BN_F_BN_MOD_SQRT = @as(c_int, 0);
pub const BN_F_BN_MONT_CTX_NEW = @as(c_int, 0);
pub const BN_F_BN_MPI2BN = @as(c_int, 0);
pub const BN_F_BN_NEW = @as(c_int, 0);
pub const BN_F_BN_POOL_GET = @as(c_int, 0);
pub const BN_F_BN_RAND = @as(c_int, 0);
pub const BN_F_BN_RAND_RANGE = @as(c_int, 0);
pub const BN_F_BN_RECP_CTX_NEW = @as(c_int, 0);
pub const BN_F_BN_RSHIFT = @as(c_int, 0);
pub const BN_F_BN_SET_WORDS = @as(c_int, 0);
pub const BN_F_BN_STACK_PUSH = @as(c_int, 0);
pub const BN_F_BN_USUB = @as(c_int, 0);
pub const BUF_F_BUF_MEM_GROW = @as(c_int, 0);
pub const BUF_F_BUF_MEM_GROW_CLEAN = @as(c_int, 0);
pub const BUF_F_BUF_MEM_NEW = @as(c_int, 0);
pub const CMS_F_CHECK_CONTENT = @as(c_int, 0);
pub const CMS_F_CMS_ADD0_CERT = @as(c_int, 0);
pub const CMS_F_CMS_ADD0_RECIPIENT_KEY = @as(c_int, 0);
pub const CMS_F_CMS_ADD0_RECIPIENT_PASSWORD = @as(c_int, 0);
pub const CMS_F_CMS_ADD1_RECEIPTREQUEST = @as(c_int, 0);
pub const CMS_F_CMS_ADD1_RECIPIENT_CERT = @as(c_int, 0);
pub const CMS_F_CMS_ADD1_SIGNER = @as(c_int, 0);
pub const CMS_F_CMS_ADD1_SIGNINGTIME = @as(c_int, 0);
pub const CMS_F_CMS_COMPRESS = @as(c_int, 0);
pub const CMS_F_CMS_COMPRESSEDDATA_CREATE = @as(c_int, 0);
pub const CMS_F_CMS_COMPRESSEDDATA_INIT_BIO = @as(c_int, 0);
pub const CMS_F_CMS_COPY_CONTENT = @as(c_int, 0);
pub const CMS_F_CMS_COPY_MESSAGEDIGEST = @as(c_int, 0);
pub const CMS_F_CMS_DATA = @as(c_int, 0);
pub const CMS_F_CMS_DATAFINAL = @as(c_int, 0);
pub const CMS_F_CMS_DATAINIT = @as(c_int, 0);
pub const CMS_F_CMS_DECRYPT = @as(c_int, 0);
pub const CMS_F_CMS_DECRYPT_SET1_KEY = @as(c_int, 0);
pub const CMS_F_CMS_DECRYPT_SET1_PASSWORD = @as(c_int, 0);
pub const CMS_F_CMS_DECRYPT_SET1_PKEY = @as(c_int, 0);
pub const CMS_F_CMS_DIGESTALGORITHM_FIND_CTX = @as(c_int, 0);
pub const CMS_F_CMS_DIGESTALGORITHM_INIT_BIO = @as(c_int, 0);
pub const CMS_F_CMS_DIGESTEDDATA_DO_FINAL = @as(c_int, 0);
pub const CMS_F_CMS_DIGEST_VERIFY = @as(c_int, 0);
pub const CMS_F_CMS_ENCODE_RECEIPT = @as(c_int, 0);
pub const CMS_F_CMS_ENCRYPT = @as(c_int, 0);
pub const CMS_F_CMS_ENCRYPTEDCONTENT_INIT = @as(c_int, 0);
pub const CMS_F_CMS_ENCRYPTEDCONTENT_INIT_BIO = @as(c_int, 0);
pub const CMS_F_CMS_ENCRYPTEDDATA_DECRYPT = @as(c_int, 0);
pub const CMS_F_CMS_ENCRYPTEDDATA_ENCRYPT = @as(c_int, 0);
pub const CMS_F_CMS_ENCRYPTEDDATA_SET1_KEY = @as(c_int, 0);
pub const CMS_F_CMS_ENVELOPEDDATA_CREATE = @as(c_int, 0);
pub const CMS_F_CMS_ENVELOPEDDATA_INIT_BIO = @as(c_int, 0);
pub const CMS_F_CMS_ENVELOPED_DATA_INIT = @as(c_int, 0);
pub const CMS_F_CMS_ENV_ASN1_CTRL = @as(c_int, 0);
pub const CMS_F_CMS_FINAL = @as(c_int, 0);
pub const CMS_F_CMS_GET0_CERTIFICATE_CHOICES = @as(c_int, 0);
pub const CMS_F_CMS_GET0_CONTENT = @as(c_int, 0);
pub const CMS_F_CMS_GET0_ECONTENT_TYPE = @as(c_int, 0);
pub const CMS_F_CMS_GET0_ENVELOPED = @as(c_int, 0);
pub const CMS_F_CMS_GET0_REVOCATION_CHOICES = @as(c_int, 0);
pub const CMS_F_CMS_GET0_SIGNED = @as(c_int, 0);
pub const CMS_F_CMS_MSGSIGDIGEST_ADD1 = @as(c_int, 0);
pub const CMS_F_CMS_RECEIPTREQUEST_CREATE0 = @as(c_int, 0);
pub const CMS_F_CMS_RECEIPT_VERIFY = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_DECRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_ENCRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KARI_ENCRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KARI_GET0_ALG = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KARI_GET0_ORIG_ID = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KARI_GET0_REKS = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KARI_ORIG_ID_CMP = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KEKRI_DECRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KEKRI_ENCRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KEKRI_GET0_ID = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KEKRI_ID_CMP = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KTRI_CERT_CMP = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KTRI_DECRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KTRI_ENCRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KTRI_GET0_ALGS = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_KTRI_GET0_SIGNER_ID = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_PWRI_CRYPT = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_SET0_KEY = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_SET0_PASSWORD = @as(c_int, 0);
pub const CMS_F_CMS_RECIPIENTINFO_SET0_PKEY = @as(c_int, 0);
pub const CMS_F_CMS_SD_ASN1_CTRL = @as(c_int, 0);
pub const CMS_F_CMS_SET1_IAS = @as(c_int, 0);
pub const CMS_F_CMS_SET1_KEYID = @as(c_int, 0);
pub const CMS_F_CMS_SET1_SIGNERIDENTIFIER = @as(c_int, 0);
pub const CMS_F_CMS_SET_DETACHED = @as(c_int, 0);
pub const CMS_F_CMS_SIGN = @as(c_int, 0);
pub const CMS_F_CMS_SIGNED_DATA_INIT = @as(c_int, 0);
pub const CMS_F_CMS_SIGNERINFO_CONTENT_SIGN = @as(c_int, 0);
pub const CMS_F_CMS_SIGNERINFO_SIGN = @as(c_int, 0);
pub const CMS_F_CMS_SIGNERINFO_VERIFY = @as(c_int, 0);
pub const CMS_F_CMS_SIGNERINFO_VERIFY_CERT = @as(c_int, 0);
pub const CMS_F_CMS_SIGNERINFO_VERIFY_CONTENT = @as(c_int, 0);
pub const CMS_F_CMS_SIGN_RECEIPT = @as(c_int, 0);
pub const CMS_F_CMS_SI_CHECK_ATTRIBUTES = @as(c_int, 0);
pub const CMS_F_CMS_STREAM = @as(c_int, 0);
pub const CMS_F_CMS_UNCOMPRESS = @as(c_int, 0);
pub const CMS_F_CMS_VERIFY = @as(c_int, 0);
pub const CMS_F_KEK_UNWRAP_KEY = @as(c_int, 0);
pub const COMP_F_BIO_ZLIB_FLUSH = @as(c_int, 0);
pub const COMP_F_BIO_ZLIB_NEW = @as(c_int, 0);
pub const COMP_F_BIO_ZLIB_READ = @as(c_int, 0);
pub const COMP_F_BIO_ZLIB_WRITE = @as(c_int, 0);
pub const COMP_F_COMP_CTX_NEW = @as(c_int, 0);
pub const CONF_F_CONF_DUMP_FP = @as(c_int, 0);
pub const CONF_F_CONF_LOAD = @as(c_int, 0);
pub const CONF_F_CONF_LOAD_FP = @as(c_int, 0);
pub const CONF_F_CONF_PARSE_LIST = @as(c_int, 0);
pub const CONF_F_DEF_LOAD = @as(c_int, 0);
pub const CONF_F_DEF_LOAD_BIO = @as(c_int, 0);
pub const CONF_F_GET_NEXT_FILE = @as(c_int, 0);
pub const CONF_F_MODULE_ADD = @as(c_int, 0);
pub const CONF_F_MODULE_INIT = @as(c_int, 0);
pub const CONF_F_MODULE_LOAD_DSO = @as(c_int, 0);
pub const CONF_F_MODULE_RUN = @as(c_int, 0);
pub const CONF_F_NCONF_DUMP_BIO = @as(c_int, 0);
pub const CONF_F_NCONF_DUMP_FP = @as(c_int, 0);
pub const CONF_F_NCONF_GET_NUMBER_E = @as(c_int, 0);
pub const CONF_F_NCONF_GET_SECTION = @as(c_int, 0);
pub const CONF_F_NCONF_GET_STRING = @as(c_int, 0);
pub const CONF_F_NCONF_LOAD = @as(c_int, 0);
pub const CONF_F_NCONF_LOAD_BIO = @as(c_int, 0);
pub const CONF_F_NCONF_LOAD_FP = @as(c_int, 0);
pub const CONF_F_NCONF_NEW = @as(c_int, 0);
pub const CONF_F_PROCESS_INCLUDE = @as(c_int, 0);
pub const CONF_F_SSL_MODULE_INIT = @as(c_int, 0);
pub const CONF_F_STR_COPY = @as(c_int, 0);
pub const CRYPTO_F_CMAC_CTX_NEW = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_DUP_EX_DATA = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_FREE_EX_DATA = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_GET_EX_NEW_INDEX = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_MEMDUP = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_NEW_EX_DATA = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_OCB128_COPY_CTX = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_OCB128_INIT = @as(c_int, 0);
pub const CRYPTO_F_CRYPTO_SET_EX_DATA = @as(c_int, 0);
pub const CRYPTO_F_GET_AND_LOCK = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_ATEXIT = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_BUF2HEXSTR = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_FOPEN = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_HEXSTR2BUF = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_INIT_CRYPTO = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_LH_NEW = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_SK_DEEP_COPY = @as(c_int, 0);
pub const CRYPTO_F_OPENSSL_SK_DUP = @as(c_int, 0);
pub const CRYPTO_F_PKEY_HMAC_INIT = @as(c_int, 0);
pub const CRYPTO_F_PKEY_POLY1305_INIT = @as(c_int, 0);
pub const CRYPTO_F_PKEY_SIPHASH_INIT = @as(c_int, 0);
pub const CRYPTO_F_SK_RESERVE = @as(c_int, 0);
pub const CT_F_CTLOG_NEW = @as(c_int, 0);
pub const CT_F_CTLOG_NEW_FROM_BASE64 = @as(c_int, 0);
pub const CT_F_CTLOG_NEW_FROM_CONF = @as(c_int, 0);
pub const CT_F_CTLOG_STORE_LOAD_CTX_NEW = @as(c_int, 0);
pub const CT_F_CTLOG_STORE_LOAD_FILE = @as(c_int, 0);
pub const CT_F_CTLOG_STORE_LOAD_LOG = @as(c_int, 0);
pub const CT_F_CTLOG_STORE_NEW = @as(c_int, 0);
pub const CT_F_CT_BASE64_DECODE = @as(c_int, 0);
pub const CT_F_CT_POLICY_EVAL_CTX_NEW = @as(c_int, 0);
pub const CT_F_CT_V1_LOG_ID_FROM_PKEY = @as(c_int, 0);
pub const CT_F_I2O_SCT = @as(c_int, 0);
pub const CT_F_I2O_SCT_LIST = @as(c_int, 0);
pub const CT_F_I2O_SCT_SIGNATURE = @as(c_int, 0);
pub const CT_F_O2I_SCT = @as(c_int, 0);
pub const CT_F_O2I_SCT_LIST = @as(c_int, 0);
pub const CT_F_O2I_SCT_SIGNATURE = @as(c_int, 0);
pub const CT_F_SCT_CTX_NEW = @as(c_int, 0);
pub const CT_F_SCT_CTX_VERIFY = @as(c_int, 0);
pub const CT_F_SCT_NEW = @as(c_int, 0);
pub const CT_F_SCT_NEW_FROM_BASE64 = @as(c_int, 0);
pub const CT_F_SCT_SET0_LOG_ID = @as(c_int, 0);
pub const CT_F_SCT_SET1_EXTENSIONS = @as(c_int, 0);
pub const CT_F_SCT_SET1_LOG_ID = @as(c_int, 0);
pub const CT_F_SCT_SET1_SIGNATURE = @as(c_int, 0);
pub const CT_F_SCT_SET_LOG_ENTRY_TYPE = @as(c_int, 0);
pub const CT_F_SCT_SET_SIGNATURE_NID = @as(c_int, 0);
pub const CT_F_SCT_SET_VERSION = @as(c_int, 0);
pub const DH_F_COMPUTE_KEY = @as(c_int, 0);
pub const DH_F_DHPARAMS_PRINT_FP = @as(c_int, 0);
pub const DH_F_DH_BUILTIN_GENPARAMS = @as(c_int, 0);
pub const DH_F_DH_CHECK_EX = @as(c_int, 0);
pub const DH_F_DH_CHECK_PARAMS_EX = @as(c_int, 0);
pub const DH_F_DH_CHECK_PUB_KEY_EX = @as(c_int, 0);
pub const DH_F_DH_CMS_DECRYPT = @as(c_int, 0);
pub const DH_F_DH_CMS_SET_PEERKEY = @as(c_int, 0);
pub const DH_F_DH_CMS_SET_SHARED_INFO = @as(c_int, 0);
pub const DH_F_DH_METH_DUP = @as(c_int, 0);
pub const DH_F_DH_METH_NEW = @as(c_int, 0);
pub const DH_F_DH_METH_SET1_NAME = @as(c_int, 0);
pub const DH_F_DH_NEW_BY_NID = @as(c_int, 0);
pub const DH_F_DH_NEW_METHOD = @as(c_int, 0);
pub const DH_F_DH_PARAM_DECODE = @as(c_int, 0);
pub const DH_F_DH_PKEY_PUBLIC_CHECK = @as(c_int, 0);
pub const DH_F_DH_PRIV_DECODE = @as(c_int, 0);
pub const DH_F_DH_PRIV_ENCODE = @as(c_int, 0);
pub const DH_F_DH_PUB_DECODE = @as(c_int, 0);
pub const DH_F_DH_PUB_ENCODE = @as(c_int, 0);
pub const DH_F_DO_DH_PRINT = @as(c_int, 0);
pub const DH_F_GENERATE_KEY = @as(c_int, 0);
pub const DH_F_PKEY_DH_CTRL_STR = @as(c_int, 0);
pub const DH_F_PKEY_DH_DERIVE = @as(c_int, 0);
pub const DH_F_PKEY_DH_INIT = @as(c_int, 0);
pub const DH_F_PKEY_DH_KEYGEN = @as(c_int, 0);
pub const DSA_F_DSAPARAMS_PRINT = @as(c_int, 0);
pub const DSA_F_DSAPARAMS_PRINT_FP = @as(c_int, 0);
pub const DSA_F_DSA_BUILTIN_PARAMGEN = @as(c_int, 0);
pub const DSA_F_DSA_BUILTIN_PARAMGEN2 = @as(c_int, 0);
pub const DSA_F_DSA_DO_SIGN = @as(c_int, 0);
pub const DSA_F_DSA_DO_VERIFY = @as(c_int, 0);
pub const DSA_F_DSA_METH_DUP = @as(c_int, 0);
pub const DSA_F_DSA_METH_NEW = @as(c_int, 0);
pub const DSA_F_DSA_METH_SET1_NAME = @as(c_int, 0);
pub const DSA_F_DSA_NEW_METHOD = @as(c_int, 0);
pub const DSA_F_DSA_PARAM_DECODE = @as(c_int, 0);
pub const DSA_F_DSA_PRINT_FP = @as(c_int, 0);
pub const DSA_F_DSA_PRIV_DECODE = @as(c_int, 0);
pub const DSA_F_DSA_PRIV_ENCODE = @as(c_int, 0);
pub const DSA_F_DSA_PUB_DECODE = @as(c_int, 0);
pub const DSA_F_DSA_PUB_ENCODE = @as(c_int, 0);
pub const DSA_F_DSA_SIGN = @as(c_int, 0);
pub const DSA_F_DSA_SIGN_SETUP = @as(c_int, 0);
pub const DSA_F_DSA_SIG_NEW = @as(c_int, 0);
pub const DSA_F_OLD_DSA_PRIV_DECODE = @as(c_int, 0);
pub const DSA_F_PKEY_DSA_CTRL = @as(c_int, 0);
pub const DSA_F_PKEY_DSA_CTRL_STR = @as(c_int, 0);
pub const DSA_F_PKEY_DSA_KEYGEN = @as(c_int, 0);
pub const EC_F_BN_TO_FELEM = @as(c_int, 0);
pub const EC_F_D2I_ECPARAMETERS = @as(c_int, 0);
pub const EC_F_D2I_ECPKPARAMETERS = @as(c_int, 0);
pub const EC_F_D2I_ECPRIVATEKEY = @as(c_int, 0);
pub const EC_F_DO_EC_KEY_PRINT = @as(c_int, 0);
pub const EC_F_ECDH_CMS_DECRYPT = @as(c_int, 0);
pub const EC_F_ECDH_CMS_SET_SHARED_INFO = @as(c_int, 0);
pub const EC_F_ECDH_COMPUTE_KEY = @as(c_int, 0);
pub const EC_F_ECDH_SIMPLE_COMPUTE_KEY = @as(c_int, 0);
pub const EC_F_ECDSA_DO_SIGN_EX = @as(c_int, 0);
pub const EC_F_ECDSA_DO_VERIFY = @as(c_int, 0);
pub const EC_F_ECDSA_SIGN_EX = @as(c_int, 0);
pub const EC_F_ECDSA_SIGN_SETUP = @as(c_int, 0);
pub const EC_F_ECDSA_SIG_NEW = @as(c_int, 0);
pub const EC_F_ECDSA_VERIFY = @as(c_int, 0);
pub const EC_F_ECD_ITEM_VERIFY = @as(c_int, 0);
pub const EC_F_ECKEY_PARAM2TYPE = @as(c_int, 0);
pub const EC_F_ECKEY_PARAM_DECODE = @as(c_int, 0);
pub const EC_F_ECKEY_PRIV_DECODE = @as(c_int, 0);
pub const EC_F_ECKEY_PRIV_ENCODE = @as(c_int, 0);
pub const EC_F_ECKEY_PUB_DECODE = @as(c_int, 0);
pub const EC_F_ECKEY_PUB_ENCODE = @as(c_int, 0);
pub const EC_F_ECKEY_TYPE2PARAM = @as(c_int, 0);
pub const EC_F_ECPARAMETERS_PRINT = @as(c_int, 0);
pub const EC_F_ECPARAMETERS_PRINT_FP = @as(c_int, 0);
pub const EC_F_ECPKPARAMETERS_PRINT = @as(c_int, 0);
pub const EC_F_ECPKPARAMETERS_PRINT_FP = @as(c_int, 0);
pub const EC_F_ECP_NISTZ256_GET_AFFINE = @as(c_int, 0);
pub const EC_F_ECP_NISTZ256_INV_MOD_ORD = @as(c_int, 0);
pub const EC_F_ECP_NISTZ256_MULT_PRECOMPUTE = @as(c_int, 0);
pub const EC_F_ECP_NISTZ256_POINTS_MUL = @as(c_int, 0);
pub const EC_F_ECP_NISTZ256_PRE_COMP_NEW = @as(c_int, 0);
pub const EC_F_ECP_NISTZ256_WINDOWED_MUL = @as(c_int, 0);
pub const EC_F_ECX_KEY_OP = @as(c_int, 0);
pub const EC_F_ECX_PRIV_ENCODE = @as(c_int, 0);
pub const EC_F_ECX_PUB_ENCODE = @as(c_int, 0);
pub const EC_F_EC_ASN1_GROUP2CURVE = @as(c_int, 0);
pub const EC_F_EC_ASN1_GROUP2FIELDID = @as(c_int, 0);
pub const EC_F_EC_GF2M_MONTGOMERY_POINT_MULTIPLY = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_FIELD_INV = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_GROUP_CHECK_DISCRIMINANT = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_LADDER_POST = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_LADDER_PRE = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_OCT2POINT = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_POINT2OCT = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_POINTS_MUL = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_POINT_GET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_POINT_SET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GF2M_SIMPLE_SET_COMPRESSED_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GFP_MONT_FIELD_DECODE = @as(c_int, 0);
pub const EC_F_EC_GFP_MONT_FIELD_ENCODE = @as(c_int, 0);
pub const EC_F_EC_GFP_MONT_FIELD_INV = @as(c_int, 0);
pub const EC_F_EC_GFP_MONT_FIELD_MUL = @as(c_int, 0);
pub const EC_F_EC_GFP_MONT_FIELD_SET_TO_ONE = @as(c_int, 0);
pub const EC_F_EC_GFP_MONT_FIELD_SQR = @as(c_int, 0);
pub const EC_F_EC_GFP_MONT_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP224_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP224_POINTS_MUL = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP224_POINT_GET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP256_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP256_POINTS_MUL = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP256_POINT_GET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP521_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP521_POINTS_MUL = @as(c_int, 0);
pub const EC_F_EC_GFP_NISTP521_POINT_GET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GFP_NIST_FIELD_MUL = @as(c_int, 0);
pub const EC_F_EC_GFP_NIST_FIELD_SQR = @as(c_int, 0);
pub const EC_F_EC_GFP_NIST_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_BLIND_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_FIELD_INV = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_GROUP_CHECK_DISCRIMINANT = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_MAKE_AFFINE = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_OCT2POINT = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_POINT2OCT = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_POINTS_MAKE_AFFINE = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_POINT_GET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_POINT_SET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GFP_SIMPLE_SET_COMPRESSED_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_GROUP_CHECK = @as(c_int, 0);
pub const EC_F_EC_GROUP_CHECK_DISCRIMINANT = @as(c_int, 0);
pub const EC_F_EC_GROUP_COPY = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_CURVE_GF2M = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_CURVE_GFP = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_DEGREE = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_ECPARAMETERS = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_ECPKPARAMETERS = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_PENTANOMIAL_BASIS = @as(c_int, 0);
pub const EC_F_EC_GROUP_GET_TRINOMIAL_BASIS = @as(c_int, 0);
pub const EC_F_EC_GROUP_NEW = @as(c_int, 0);
pub const EC_F_EC_GROUP_NEW_BY_CURVE_NAME = @as(c_int, 0);
pub const EC_F_EC_GROUP_NEW_FROM_DATA = @as(c_int, 0);
pub const EC_F_EC_GROUP_NEW_FROM_ECPARAMETERS = @as(c_int, 0);
pub const EC_F_EC_GROUP_NEW_FROM_ECPKPARAMETERS = @as(c_int, 0);
pub const EC_F_EC_GROUP_SET_CURVE = @as(c_int, 0);
pub const EC_F_EC_GROUP_SET_CURVE_GF2M = @as(c_int, 0);
pub const EC_F_EC_GROUP_SET_CURVE_GFP = @as(c_int, 0);
pub const EC_F_EC_GROUP_SET_GENERATOR = @as(c_int, 0);
pub const EC_F_EC_GROUP_SET_SEED = @as(c_int, 0);
pub const EC_F_EC_KEY_CHECK_KEY = @as(c_int, 0);
pub const EC_F_EC_KEY_COPY = @as(c_int, 0);
pub const EC_F_EC_KEY_GENERATE_KEY = @as(c_int, 0);
pub const EC_F_EC_KEY_NEW = @as(c_int, 0);
pub const EC_F_EC_KEY_NEW_METHOD = @as(c_int, 0);
pub const EC_F_EC_KEY_OCT2PRIV = @as(c_int, 0);
pub const EC_F_EC_KEY_PRINT = @as(c_int, 0);
pub const EC_F_EC_KEY_PRINT_FP = @as(c_int, 0);
pub const EC_F_EC_KEY_PRIV2BUF = @as(c_int, 0);
pub const EC_F_EC_KEY_PRIV2OCT = @as(c_int, 0);
pub const EC_F_EC_KEY_SET_PUBLIC_KEY_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_KEY_SIMPLE_CHECK_KEY = @as(c_int, 0);
pub const EC_F_EC_KEY_SIMPLE_OCT2PRIV = @as(c_int, 0);
pub const EC_F_EC_KEY_SIMPLE_PRIV2OCT = @as(c_int, 0);
pub const EC_F_EC_PKEY_CHECK = @as(c_int, 0);
pub const EC_F_EC_PKEY_PARAM_CHECK = @as(c_int, 0);
pub const EC_F_EC_POINTS_MAKE_AFFINE = @as(c_int, 0);
pub const EC_F_EC_POINTS_MUL = @as(c_int, 0);
pub const EC_F_EC_POINT_ADD = @as(c_int, 0);
pub const EC_F_EC_POINT_BN2POINT = @as(c_int, 0);
pub const EC_F_EC_POINT_CMP = @as(c_int, 0);
pub const EC_F_EC_POINT_COPY = @as(c_int, 0);
pub const EC_F_EC_POINT_DBL = @as(c_int, 0);
pub const EC_F_EC_POINT_GET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_POINT_GET_AFFINE_COORDINATES_GF2M = @as(c_int, 0);
pub const EC_F_EC_POINT_GET_AFFINE_COORDINATES_GFP = @as(c_int, 0);
pub const EC_F_EC_POINT_GET_JPROJECTIVE_COORDINATES_GFP = @as(c_int, 0);
pub const EC_F_EC_POINT_INVERT = @as(c_int, 0);
pub const EC_F_EC_POINT_IS_AT_INFINITY = @as(c_int, 0);
pub const EC_F_EC_POINT_IS_ON_CURVE = @as(c_int, 0);
pub const EC_F_EC_POINT_MAKE_AFFINE = @as(c_int, 0);
pub const EC_F_EC_POINT_NEW = @as(c_int, 0);
pub const EC_F_EC_POINT_OCT2POINT = @as(c_int, 0);
pub const EC_F_EC_POINT_POINT2BUF = @as(c_int, 0);
pub const EC_F_EC_POINT_POINT2OCT = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_AFFINE_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_AFFINE_COORDINATES_GF2M = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_AFFINE_COORDINATES_GFP = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_COMPRESSED_COORDINATES = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GF2M = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_COMPRESSED_COORDINATES_GFP = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_JPROJECTIVE_COORDINATES_GFP = @as(c_int, 0);
pub const EC_F_EC_POINT_SET_TO_INFINITY = @as(c_int, 0);
pub const EC_F_EC_PRE_COMP_NEW = @as(c_int, 0);
pub const EC_F_EC_SCALAR_MUL_LADDER = @as(c_int, 0);
pub const EC_F_EC_WNAF_MUL = @as(c_int, 0);
pub const EC_F_EC_WNAF_PRECOMPUTE_MULT = @as(c_int, 0);
pub const EC_F_I2D_ECPARAMETERS = @as(c_int, 0);
pub const EC_F_I2D_ECPKPARAMETERS = @as(c_int, 0);
pub const EC_F_I2D_ECPRIVATEKEY = @as(c_int, 0);
pub const EC_F_I2O_ECPUBLICKEY = @as(c_int, 0);
pub const EC_F_NISTP224_PRE_COMP_NEW = @as(c_int, 0);
pub const EC_F_NISTP256_PRE_COMP_NEW = @as(c_int, 0);
pub const EC_F_NISTP521_PRE_COMP_NEW = @as(c_int, 0);
pub const EC_F_O2I_ECPUBLICKEY = @as(c_int, 0);
pub const EC_F_OLD_EC_PRIV_DECODE = @as(c_int, 0);
pub const EC_F_OSSL_ECDH_COMPUTE_KEY = @as(c_int, 0);
pub const EC_F_OSSL_ECDSA_SIGN_SIG = @as(c_int, 0);
pub const EC_F_OSSL_ECDSA_VERIFY_SIG = @as(c_int, 0);
pub const EC_F_PKEY_ECD_CTRL = @as(c_int, 0);
pub const EC_F_PKEY_ECD_DIGESTSIGN = @as(c_int, 0);
pub const EC_F_PKEY_ECD_DIGESTSIGN25519 = @as(c_int, 0);
pub const EC_F_PKEY_ECD_DIGESTSIGN448 = @as(c_int, 0);
pub const EC_F_PKEY_ECX_DERIVE = @as(c_int, 0);
pub const EC_F_PKEY_EC_CTRL = @as(c_int, 0);
pub const EC_F_PKEY_EC_CTRL_STR = @as(c_int, 0);
pub const EC_F_PKEY_EC_DERIVE = @as(c_int, 0);
pub const EC_F_PKEY_EC_INIT = @as(c_int, 0);
pub const EC_F_PKEY_EC_KDF_DERIVE = @as(c_int, 0);
pub const EC_F_PKEY_EC_KEYGEN = @as(c_int, 0);
pub const EC_F_PKEY_EC_PARAMGEN = @as(c_int, 0);
pub const EC_F_PKEY_EC_SIGN = @as(c_int, 0);
pub const EC_F_VALIDATE_ECX_DERIVE = @as(c_int, 0);
pub const ENGINE_F_DIGEST_UPDATE = @as(c_int, 0);
pub const ENGINE_F_DYNAMIC_CTRL = @as(c_int, 0);
pub const ENGINE_F_DYNAMIC_GET_DATA_CTX = @as(c_int, 0);
pub const ENGINE_F_DYNAMIC_LOAD = @as(c_int, 0);
pub const ENGINE_F_DYNAMIC_SET_DATA_CTX = @as(c_int, 0);
pub const ENGINE_F_ENGINE_ADD = @as(c_int, 0);
pub const ENGINE_F_ENGINE_BY_ID = @as(c_int, 0);
pub const ENGINE_F_ENGINE_CMD_IS_EXECUTABLE = @as(c_int, 0);
pub const ENGINE_F_ENGINE_CTRL = @as(c_int, 0);
pub const ENGINE_F_ENGINE_CTRL_CMD = @as(c_int, 0);
pub const ENGINE_F_ENGINE_CTRL_CMD_STRING = @as(c_int, 0);
pub const ENGINE_F_ENGINE_FINISH = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_CIPHER = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_DIGEST = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_FIRST = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_LAST = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_NEXT = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_PKEY_ASN1_METH = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_PKEY_METH = @as(c_int, 0);
pub const ENGINE_F_ENGINE_GET_PREV = @as(c_int, 0);
pub const ENGINE_F_ENGINE_INIT = @as(c_int, 0);
pub const ENGINE_F_ENGINE_LIST_ADD = @as(c_int, 0);
pub const ENGINE_F_ENGINE_LIST_REMOVE = @as(c_int, 0);
pub const ENGINE_F_ENGINE_LOAD_PRIVATE_KEY = @as(c_int, 0);
pub const ENGINE_F_ENGINE_LOAD_PUBLIC_KEY = @as(c_int, 0);
pub const ENGINE_F_ENGINE_LOAD_SSL_CLIENT_CERT = @as(c_int, 0);
pub const ENGINE_F_ENGINE_NEW = @as(c_int, 0);
pub const ENGINE_F_ENGINE_PKEY_ASN1_FIND_STR = @as(c_int, 0);
pub const ENGINE_F_ENGINE_REMOVE = @as(c_int, 0);
pub const ENGINE_F_ENGINE_SET_DEFAULT_STRING = @as(c_int, 0);
pub const ENGINE_F_ENGINE_SET_ID = @as(c_int, 0);
pub const ENGINE_F_ENGINE_SET_NAME = @as(c_int, 0);
pub const ENGINE_F_ENGINE_TABLE_REGISTER = @as(c_int, 0);
pub const ENGINE_F_ENGINE_UNLOCKED_FINISH = @as(c_int, 0);
pub const ENGINE_F_ENGINE_UP_REF = @as(c_int, 0);
pub const ENGINE_F_INT_CLEANUP_ITEM = @as(c_int, 0);
pub const ENGINE_F_INT_CTRL_HELPER = @as(c_int, 0);
pub const ENGINE_F_INT_ENGINE_CONFIGURE = @as(c_int, 0);
pub const ENGINE_F_INT_ENGINE_MODULE_INIT = @as(c_int, 0);
pub const ENGINE_F_OSSL_HMAC_INIT = @as(c_int, 0);
pub const EVP_F_AESNI_INIT_KEY = @as(c_int, 0);
pub const EVP_F_AESNI_XTS_INIT_KEY = @as(c_int, 0);
pub const EVP_F_AES_GCM_CTRL = @as(c_int, 0);
pub const EVP_F_AES_INIT_KEY = @as(c_int, 0);
pub const EVP_F_AES_OCB_CIPHER = @as(c_int, 0);
pub const EVP_F_AES_T4_INIT_KEY = @as(c_int, 0);
pub const EVP_F_AES_T4_XTS_INIT_KEY = @as(c_int, 0);
pub const EVP_F_AES_WRAP_CIPHER = @as(c_int, 0);
pub const EVP_F_AES_XTS_INIT_KEY = @as(c_int, 0);
pub const EVP_F_ALG_MODULE_INIT = @as(c_int, 0);
pub const EVP_F_ARIA_CCM_INIT_KEY = @as(c_int, 0);
pub const EVP_F_ARIA_GCM_CTRL = @as(c_int, 0);
pub const EVP_F_ARIA_GCM_INIT_KEY = @as(c_int, 0);
pub const EVP_F_ARIA_INIT_KEY = @as(c_int, 0);
pub const EVP_F_B64_NEW = @as(c_int, 0);
pub const EVP_F_CAMELLIA_INIT_KEY = @as(c_int, 0);
pub const EVP_F_CHACHA20_POLY1305_CTRL = @as(c_int, 0);
pub const EVP_F_CMLL_T4_INIT_KEY = @as(c_int, 0);
pub const EVP_F_DES_EDE3_WRAP_CIPHER = @as(c_int, 0);
pub const EVP_F_DO_SIGVER_INIT = @as(c_int, 0);
pub const EVP_F_ENC_NEW = @as(c_int, 0);
pub const EVP_F_EVP_CIPHERINIT_EX = @as(c_int, 0);
pub const EVP_F_EVP_CIPHER_ASN1_TO_PARAM = @as(c_int, 0);
pub const EVP_F_EVP_CIPHER_CTX_COPY = @as(c_int, 0);
pub const EVP_F_EVP_CIPHER_CTX_CTRL = @as(c_int, 0);
pub const EVP_F_EVP_CIPHER_CTX_SET_KEY_LENGTH = @as(c_int, 0);
pub const EVP_F_EVP_CIPHER_PARAM_TO_ASN1 = @as(c_int, 0);
pub const EVP_F_EVP_DECRYPTFINAL_EX = @as(c_int, 0);
pub const EVP_F_EVP_DECRYPTUPDATE = @as(c_int, 0);
pub const EVP_F_EVP_DIGESTFINALXOF = @as(c_int, 0);
pub const EVP_F_EVP_DIGESTINIT_EX = @as(c_int, 0);
pub const EVP_F_EVP_ENCRYPTDECRYPTUPDATE = @as(c_int, 0);
pub const EVP_F_EVP_ENCRYPTFINAL_EX = @as(c_int, 0);
pub const EVP_F_EVP_ENCRYPTUPDATE = @as(c_int, 0);
pub const EVP_F_EVP_MD_CTX_COPY_EX = @as(c_int, 0);
pub const EVP_F_EVP_MD_SIZE = @as(c_int, 0);
pub const EVP_F_EVP_OPENINIT = @as(c_int, 0);
pub const EVP_F_EVP_PBE_ALG_ADD = @as(c_int, 0);
pub const EVP_F_EVP_PBE_ALG_ADD_TYPE = @as(c_int, 0);
pub const EVP_F_EVP_PBE_CIPHERINIT = @as(c_int, 0);
pub const EVP_F_EVP_PBE_SCRYPT = @as(c_int, 0);
pub const EVP_F_EVP_PKCS82PKEY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY2PKCS8 = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_ASN1_ADD0 = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_CHECK = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_COPY_PARAMETERS = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_CTX_CTRL = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_CTX_CTRL_STR = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_CTX_DUP = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_CTX_MD = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_DECRYPT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_DECRYPT_INIT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_DECRYPT_OLD = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_DERIVE = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_DERIVE_INIT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_DERIVE_SET_PEER = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_ENCRYPT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_ENCRYPT_INIT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_ENCRYPT_OLD = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET0_DH = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET0_DSA = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET0_EC_KEY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET0_HMAC = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET0_POLY1305 = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET0_RSA = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET0_SIPHASH = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET_RAW_PRIVATE_KEY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_GET_RAW_PUBLIC_KEY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_KEYGEN = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_KEYGEN_INIT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_METH_ADD0 = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_METH_NEW = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_NEW = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_NEW_CMAC_KEY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_NEW_RAW_PRIVATE_KEY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_NEW_RAW_PUBLIC_KEY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_PARAMGEN = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_PARAMGEN_INIT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_PARAM_CHECK = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_PUBLIC_CHECK = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_SET1_ENGINE = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_SET_ALIAS_TYPE = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_SIGN = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_SIGN_INIT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_VERIFY = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_VERIFY_INIT = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_VERIFY_RECOVER = @as(c_int, 0);
pub const EVP_F_EVP_PKEY_VERIFY_RECOVER_INIT = @as(c_int, 0);
pub const EVP_F_EVP_SIGNFINAL = @as(c_int, 0);
pub const EVP_F_EVP_VERIFYFINAL = @as(c_int, 0);
pub const EVP_F_INT_CTX_NEW = @as(c_int, 0);
pub const EVP_F_OK_NEW = @as(c_int, 0);
pub const EVP_F_PKCS5_PBE_KEYIVGEN = @as(c_int, 0);
pub const EVP_F_PKCS5_V2_PBE_KEYIVGEN = @as(c_int, 0);
pub const EVP_F_PKCS5_V2_PBKDF2_KEYIVGEN = @as(c_int, 0);
pub const EVP_F_PKCS5_V2_SCRYPT_KEYIVGEN = @as(c_int, 0);
pub const EVP_F_PKEY_SET_TYPE = @as(c_int, 0);
pub const EVP_F_RC2_MAGIC_TO_METH = @as(c_int, 0);
pub const EVP_F_RC5_CTRL = @as(c_int, 0);
pub const EVP_F_R_32_12_16_INIT_KEY = @as(c_int, 0);
pub const EVP_F_S390X_AES_GCM_CTRL = @as(c_int, 0);
pub const EVP_F_UPDATE = @as(c_int, 0);
pub const KDF_F_PKEY_HKDF_CTRL_STR = @as(c_int, 0);
pub const KDF_F_PKEY_HKDF_DERIVE = @as(c_int, 0);
pub const KDF_F_PKEY_HKDF_INIT = @as(c_int, 0);
pub const KDF_F_PKEY_SCRYPT_CTRL_STR = @as(c_int, 0);
pub const KDF_F_PKEY_SCRYPT_CTRL_UINT64 = @as(c_int, 0);
pub const KDF_F_PKEY_SCRYPT_DERIVE = @as(c_int, 0);
pub const KDF_F_PKEY_SCRYPT_INIT = @as(c_int, 0);
pub const KDF_F_PKEY_SCRYPT_SET_MEMBUF = @as(c_int, 0);
pub const KDF_F_PKEY_TLS1_PRF_CTRL_STR = @as(c_int, 0);
pub const KDF_F_PKEY_TLS1_PRF_DERIVE = @as(c_int, 0);
pub const KDF_F_PKEY_TLS1_PRF_INIT = @as(c_int, 0);
pub const KDF_F_TLS1_PRF_ALG = @as(c_int, 0);
pub const KDF_R_INVALID_DIGEST = @as(c_int, 0);
pub const KDF_R_MISSING_ITERATION_COUNT = @as(c_int, 0);
pub const KDF_R_MISSING_KEY = @as(c_int, 0);
pub const KDF_R_MISSING_MESSAGE_DIGEST = @as(c_int, 0);
pub const KDF_R_MISSING_PARAMETER = @as(c_int, 0);
pub const KDF_R_MISSING_PASS = @as(c_int, 0);
pub const KDF_R_MISSING_SALT = @as(c_int, 0);
pub const KDF_R_MISSING_SECRET = @as(c_int, 0);
pub const KDF_R_MISSING_SEED = @as(c_int, 0);
pub const KDF_R_UNKNOWN_PARAMETER_TYPE = @as(c_int, 0);
pub const KDF_R_VALUE_ERROR = @as(c_int, 0);
pub const KDF_R_VALUE_MISSING = @as(c_int, 0);
pub const OBJ_F_OBJ_ADD_OBJECT = @as(c_int, 0);
pub const OBJ_F_OBJ_ADD_SIGID = @as(c_int, 0);
pub const OBJ_F_OBJ_CREATE = @as(c_int, 0);
pub const OBJ_F_OBJ_DUP = @as(c_int, 0);
pub const OBJ_F_OBJ_NAME_NEW_INDEX = @as(c_int, 0);
pub const OBJ_F_OBJ_NID2LN = @as(c_int, 0);
pub const OBJ_F_OBJ_NID2OBJ = @as(c_int, 0);
pub const OBJ_F_OBJ_NID2SN = @as(c_int, 0);
pub const OBJ_F_OBJ_TXT2OBJ = @as(c_int, 0);
pub const OCSP_F_D2I_OCSP_NONCE = @as(c_int, 0);
pub const OCSP_F_OCSP_BASIC_ADD1_STATUS = @as(c_int, 0);
pub const OCSP_F_OCSP_BASIC_SIGN = @as(c_int, 0);
pub const OCSP_F_OCSP_BASIC_SIGN_CTX = @as(c_int, 0);
pub const OCSP_F_OCSP_BASIC_VERIFY = @as(c_int, 0);
pub const OCSP_F_OCSP_CERT_ID_NEW = @as(c_int, 0);
pub const OCSP_F_OCSP_CHECK_DELEGATED = @as(c_int, 0);
pub const OCSP_F_OCSP_CHECK_IDS = @as(c_int, 0);
pub const OCSP_F_OCSP_CHECK_ISSUER = @as(c_int, 0);
pub const OCSP_F_OCSP_CHECK_VALIDITY = @as(c_int, 0);
pub const OCSP_F_OCSP_MATCH_ISSUERID = @as(c_int, 0);
pub const OCSP_F_OCSP_PARSE_URL = @as(c_int, 0);
pub const OCSP_F_OCSP_REQUEST_SIGN = @as(c_int, 0);
pub const OCSP_F_OCSP_REQUEST_VERIFY = @as(c_int, 0);
pub const OCSP_F_OCSP_RESPONSE_GET1_BASIC = @as(c_int, 0);
pub const OCSP_F_PARSE_HTTP_LINE1 = @as(c_int, 0);
pub const PEM_F_B2I_DSS = @as(c_int, 0);
pub const PEM_F_B2I_PVK_BIO = @as(c_int, 0);
pub const PEM_F_B2I_RSA = @as(c_int, 0);
pub const PEM_F_CHECK_BITLEN_DSA = @as(c_int, 0);
pub const PEM_F_CHECK_BITLEN_RSA = @as(c_int, 0);
pub const PEM_F_D2I_PKCS8PRIVATEKEY_BIO = @as(c_int, 0);
pub const PEM_F_D2I_PKCS8PRIVATEKEY_FP = @as(c_int, 0);
pub const PEM_F_DO_B2I = @as(c_int, 0);
pub const PEM_F_DO_B2I_BIO = @as(c_int, 0);
pub const PEM_F_DO_BLOB_HEADER = @as(c_int, 0);
pub const PEM_F_DO_I2B = @as(c_int, 0);
pub const PEM_F_DO_PK8PKEY = @as(c_int, 0);
pub const PEM_F_DO_PK8PKEY_FP = @as(c_int, 0);
pub const PEM_F_DO_PVK_BODY = @as(c_int, 0);
pub const PEM_F_DO_PVK_HEADER = @as(c_int, 0);
pub const PEM_F_GET_HEADER_AND_DATA = @as(c_int, 0);
pub const PEM_F_GET_NAME = @as(c_int, 0);
pub const PEM_F_I2B_PVK = @as(c_int, 0);
pub const PEM_F_I2B_PVK_BIO = @as(c_int, 0);
pub const PEM_F_LOAD_IV = @as(c_int, 0);
pub const PEM_F_PEM_ASN1_READ = @as(c_int, 0);
pub const PEM_F_PEM_ASN1_READ_BIO = @as(c_int, 0);
pub const PEM_F_PEM_ASN1_WRITE = @as(c_int, 0);
pub const PEM_F_PEM_ASN1_WRITE_BIO = @as(c_int, 0);
pub const PEM_F_PEM_DEF_CALLBACK = @as(c_int, 0);
pub const PEM_F_PEM_DO_HEADER = @as(c_int, 0);
pub const PEM_F_PEM_GET_EVP_CIPHER_INFO = @as(c_int, 0);
pub const PEM_F_PEM_READ = @as(c_int, 0);
pub const PEM_F_PEM_READ_BIO = @as(c_int, 0);
pub const PEM_F_PEM_READ_BIO_DHPARAMS = @as(c_int, 0);
pub const PEM_F_PEM_READ_BIO_EX = @as(c_int, 0);
pub const PEM_F_PEM_READ_BIO_PARAMETERS = @as(c_int, 0);
pub const PEM_F_PEM_READ_BIO_PRIVATEKEY = @as(c_int, 0);
pub const PEM_F_PEM_READ_DHPARAMS = @as(c_int, 0);
pub const PEM_F_PEM_READ_PRIVATEKEY = @as(c_int, 0);
pub const PEM_F_PEM_SIGNFINAL = @as(c_int, 0);
pub const PEM_F_PEM_WRITE = @as(c_int, 0);
pub const PEM_F_PEM_WRITE_BIO = @as(c_int, 0);
pub const PEM_F_PEM_WRITE_BIO_PRIVATEKEY_TRADITIONAL = @as(c_int, 0);
pub const PEM_F_PEM_WRITE_PRIVATEKEY = @as(c_int, 0);
pub const PEM_F_PEM_X509_INFO_READ = @as(c_int, 0);
pub const PEM_F_PEM_X509_INFO_READ_BIO = @as(c_int, 0);
pub const PEM_F_PEM_X509_INFO_WRITE_BIO = @as(c_int, 0);
pub const PKCS12_F_OPENSSL_ASC2UNI = @as(c_int, 0);
pub const PKCS12_F_OPENSSL_UNI2ASC = @as(c_int, 0);
pub const PKCS12_F_OPENSSL_UNI2UTF8 = @as(c_int, 0);
pub const PKCS12_F_OPENSSL_UTF82UNI = @as(c_int, 0);
pub const PKCS12_F_PKCS12_CREATE = @as(c_int, 0);
pub const PKCS12_F_PKCS12_GEN_MAC = @as(c_int, 0);
pub const PKCS12_F_PKCS12_INIT = @as(c_int, 0);
pub const PKCS12_F_PKCS12_ITEM_DECRYPT_D2I = @as(c_int, 0);
pub const PKCS12_F_PKCS12_ITEM_I2D_ENCRYPT = @as(c_int, 0);
pub const PKCS12_F_PKCS12_ITEM_PACK_SAFEBAG = @as(c_int, 0);
pub const PKCS12_F_PKCS12_KEY_GEN_ASC = @as(c_int, 0);
pub const PKCS12_F_PKCS12_KEY_GEN_UNI = @as(c_int, 0);
pub const PKCS12_F_PKCS12_KEY_GEN_UTF8 = @as(c_int, 0);
pub const PKCS12_F_PKCS12_NEWPASS = @as(c_int, 0);
pub const PKCS12_F_PKCS12_PACK_P7DATA = @as(c_int, 0);
pub const PKCS12_F_PKCS12_PACK_P7ENCDATA = @as(c_int, 0);
pub const PKCS12_F_PKCS12_PARSE = @as(c_int, 0);
pub const PKCS12_F_PKCS12_PBE_CRYPT = @as(c_int, 0);
pub const PKCS12_F_PKCS12_PBE_KEYIVGEN = @as(c_int, 0);
pub const PKCS12_F_PKCS12_SAFEBAG_CREATE0_P8INF = @as(c_int, 0);
pub const PKCS12_F_PKCS12_SAFEBAG_CREATE0_PKCS8 = @as(c_int, 0);
pub const PKCS12_F_PKCS12_SAFEBAG_CREATE_PKCS8_ENCRYPT = @as(c_int, 0);
pub const PKCS12_F_PKCS12_SETUP_MAC = @as(c_int, 0);
pub const PKCS12_F_PKCS12_SET_MAC = @as(c_int, 0);
pub const PKCS12_F_PKCS12_UNPACK_AUTHSAFES = @as(c_int, 0);
pub const PKCS12_F_PKCS12_UNPACK_P7DATA = @as(c_int, 0);
pub const PKCS12_F_PKCS12_VERIFY_MAC = @as(c_int, 0);
pub const PKCS12_F_PKCS8_ENCRYPT = @as(c_int, 0);
pub const PKCS12_F_PKCS8_SET0_PBE = @as(c_int, 0);
pub const PKCS7_F_DO_PKCS7_SIGNED_ATTRIB = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ADD0_ATTRIB_SIGNING_TIME = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ADD_ATTRIB_SMIMECAP = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ADD_CERTIFICATE = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ADD_CRL = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ADD_RECIPIENT_INFO = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ADD_SIGNATURE = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ADD_SIGNER = @as(c_int, 0);
pub const PKCS7_F_PKCS7_BIO_ADD_DIGEST = @as(c_int, 0);
pub const PKCS7_F_PKCS7_COPY_EXISTING_DIGEST = @as(c_int, 0);
pub const PKCS7_F_PKCS7_CTRL = @as(c_int, 0);
pub const PKCS7_F_PKCS7_DATADECODE = @as(c_int, 0);
pub const PKCS7_F_PKCS7_DATAFINAL = @as(c_int, 0);
pub const PKCS7_F_PKCS7_DATAINIT = @as(c_int, 0);
pub const PKCS7_F_PKCS7_DATAVERIFY = @as(c_int, 0);
pub const PKCS7_F_PKCS7_DECRYPT = @as(c_int, 0);
pub const PKCS7_F_PKCS7_DECRYPT_RINFO = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ENCODE_RINFO = @as(c_int, 0);
pub const PKCS7_F_PKCS7_ENCRYPT = @as(c_int, 0);
pub const PKCS7_F_PKCS7_FINAL = @as(c_int, 0);
pub const PKCS7_F_PKCS7_FIND_DIGEST = @as(c_int, 0);
pub const PKCS7_F_PKCS7_GET0_SIGNERS = @as(c_int, 0);
pub const PKCS7_F_PKCS7_RECIP_INFO_SET = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SET_CIPHER = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SET_CONTENT = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SET_DIGEST = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SET_TYPE = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SIGN = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SIGNATUREVERIFY = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SIGNER_INFO_SET = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SIGNER_INFO_SIGN = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SIGN_ADD_SIGNER = @as(c_int, 0);
pub const PKCS7_F_PKCS7_SIMPLE_SMIMECAP = @as(c_int, 0);
pub const PKCS7_F_PKCS7_VERIFY = @as(c_int, 0);
pub const RAND_F_DATA_COLLECT_METHOD = @as(c_int, 0);
pub const RAND_F_DRBG_BYTES = @as(c_int, 0);
pub const RAND_F_DRBG_GET_ENTROPY = @as(c_int, 0);
pub const RAND_F_DRBG_SETUP = @as(c_int, 0);
pub const RAND_F_GET_ENTROPY = @as(c_int, 0);
pub const RAND_F_RAND_BYTES = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_ENABLE_LOCKING = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_GENERATE = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_GET_ENTROPY = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_GET_NONCE = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_INSTANTIATE = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_NEW = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_RESEED = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_RESTART = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_SET = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_SET_DEFAULTS = @as(c_int, 0);
pub const RAND_F_RAND_DRBG_UNINSTANTIATE = @as(c_int, 0);
pub const RAND_F_RAND_LOAD_FILE = @as(c_int, 0);
pub const RAND_F_RAND_POOL_ACQUIRE_ENTROPY = @as(c_int, 0);
pub const RAND_F_RAND_POOL_ADD = @as(c_int, 0);
pub const RAND_F_RAND_POOL_ADD_BEGIN = @as(c_int, 0);
pub const RAND_F_RAND_POOL_ADD_END = @as(c_int, 0);
pub const RAND_F_RAND_POOL_ATTACH = @as(c_int, 0);
pub const RAND_F_RAND_POOL_BYTES_NEEDED = @as(c_int, 0);
pub const RAND_F_RAND_POOL_GROW = @as(c_int, 0);
pub const RAND_F_RAND_POOL_NEW = @as(c_int, 0);
pub const RAND_F_RAND_PSEUDO_BYTES = @as(c_int, 0);
pub const RAND_F_RAND_WRITE_FILE = @as(c_int, 0);
pub const RSA_F_CHECK_PADDING_MD = @as(c_int, 0);
pub const RSA_F_ENCODE_PKCS1 = @as(c_int, 0);
pub const RSA_F_INT_RSA_VERIFY = @as(c_int, 0);
pub const RSA_F_OLD_RSA_PRIV_DECODE = @as(c_int, 0);
pub const RSA_F_PKEY_PSS_INIT = @as(c_int, 0);
pub const RSA_F_PKEY_RSA_CTRL = @as(c_int, 0);
pub const RSA_F_PKEY_RSA_CTRL_STR = @as(c_int, 0);
pub const RSA_F_PKEY_RSA_SIGN = @as(c_int, 0);
pub const RSA_F_PKEY_RSA_VERIFY = @as(c_int, 0);
pub const RSA_F_PKEY_RSA_VERIFYRECOVER = @as(c_int, 0);
pub const RSA_F_RSA_ALGOR_TO_MD = @as(c_int, 0);
pub const RSA_F_RSA_BUILTIN_KEYGEN = @as(c_int, 0);
pub const RSA_F_RSA_CHECK_KEY = @as(c_int, 0);
pub const RSA_F_RSA_CHECK_KEY_EX = @as(c_int, 0);
pub const RSA_F_RSA_CMS_DECRYPT = @as(c_int, 0);
pub const RSA_F_RSA_CMS_VERIFY = @as(c_int, 0);
pub const RSA_F_RSA_ITEM_VERIFY = @as(c_int, 0);
pub const RSA_F_RSA_METH_DUP = @as(c_int, 0);
pub const RSA_F_RSA_METH_NEW = @as(c_int, 0);
pub const RSA_F_RSA_METH_SET1_NAME = @as(c_int, 0);
pub const RSA_F_RSA_MGF1_TO_MD = @as(c_int, 0);
pub const RSA_F_RSA_MULTIP_INFO_NEW = @as(c_int, 0);
pub const RSA_F_RSA_NEW_METHOD = @as(c_int, 0);
pub const RSA_F_RSA_NULL = @as(c_int, 0);
pub const RSA_F_RSA_NULL_PRIVATE_DECRYPT = @as(c_int, 0);
pub const RSA_F_RSA_NULL_PRIVATE_ENCRYPT = @as(c_int, 0);
pub const RSA_F_RSA_NULL_PUBLIC_DECRYPT = @as(c_int, 0);
pub const RSA_F_RSA_NULL_PUBLIC_ENCRYPT = @as(c_int, 0);
pub const RSA_F_RSA_OSSL_PRIVATE_DECRYPT = @as(c_int, 0);
pub const RSA_F_RSA_OSSL_PRIVATE_ENCRYPT = @as(c_int, 0);
pub const RSA_F_RSA_OSSL_PUBLIC_DECRYPT = @as(c_int, 0);
pub const RSA_F_RSA_OSSL_PUBLIC_ENCRYPT = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_NONE = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_PKCS1_OAEP = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_PKCS1_OAEP_MGF1 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_PKCS1_PSS = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_PKCS1_PSS_MGF1 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_1 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_2 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_SSLV23 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_ADD_X931 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_CHECK_NONE = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_CHECK_PKCS1_OAEP = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_CHECK_PKCS1_OAEP_MGF1 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_1 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_2 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_CHECK_SSLV23 = @as(c_int, 0);
pub const RSA_F_RSA_PADDING_CHECK_X931 = @as(c_int, 0);
pub const RSA_F_RSA_PARAM_DECODE = @as(c_int, 0);
pub const RSA_F_RSA_PRINT = @as(c_int, 0);
pub const RSA_F_RSA_PRINT_FP = @as(c_int, 0);
pub const RSA_F_RSA_PRIV_DECODE = @as(c_int, 0);
pub const RSA_F_RSA_PRIV_ENCODE = @as(c_int, 0);
pub const RSA_F_RSA_PSS_GET_PARAM = @as(c_int, 0);
pub const RSA_F_RSA_PSS_TO_CTX = @as(c_int, 0);
pub const RSA_F_RSA_PUB_DECODE = @as(c_int, 0);
pub const RSA_F_RSA_SETUP_BLINDING = @as(c_int, 0);
pub const RSA_F_RSA_SIGN = @as(c_int, 0);
pub const RSA_F_RSA_SIGN_ASN1_OCTET_STRING = @as(c_int, 0);
pub const RSA_F_RSA_VERIFY = @as(c_int, 0);
pub const RSA_F_RSA_VERIFY_ASN1_OCTET_STRING = @as(c_int, 0);
pub const RSA_F_RSA_VERIFY_PKCS1_PSS_MGF1 = @as(c_int, 0);
pub const RSA_F_SETUP_TBUF = @as(c_int, 0);
pub const OSSL_STORE_F_FILE_CTRL = @as(c_int, 0);
pub const OSSL_STORE_F_FILE_FIND = @as(c_int, 0);
pub const OSSL_STORE_F_FILE_GET_PASS = @as(c_int, 0);
pub const OSSL_STORE_F_FILE_LOAD = @as(c_int, 0);
pub const OSSL_STORE_F_FILE_LOAD_TRY_DECODE = @as(c_int, 0);
pub const OSSL_STORE_F_FILE_NAME_TO_URI = @as(c_int, 0);
pub const OSSL_STORE_F_FILE_OPEN = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_ATTACH_PEM_BIO = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_EXPECT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_FILE_ATTACH_PEM_BIO_INT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_FIND = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_GET0_LOADER_INT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_GET1_CERT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_GET1_CRL = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_GET1_NAME = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_GET1_NAME_DESCRIPTION = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_GET1_PARAMS = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_GET1_PKEY = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_NEW_CERT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_NEW_CRL = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_NEW_EMBEDDED = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_NEW_NAME = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_NEW_PARAMS = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_NEW_PKEY = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INFO_SET0_NAME_DESCRIPTION = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_INIT_ONCE = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_LOADER_NEW = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_OPEN = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_OPEN_INT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_REGISTER_LOADER_INT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_SEARCH_BY_ALIAS = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_SEARCH_BY_ISSUER_SERIAL = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_SEARCH_BY_KEY_FINGERPRINT = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_SEARCH_BY_NAME = @as(c_int, 0);
pub const OSSL_STORE_F_OSSL_STORE_UNREGISTER_LOADER_INT = @as(c_int, 0);
pub const OSSL_STORE_F_TRY_DECODE_PARAMS = @as(c_int, 0);
pub const OSSL_STORE_F_TRY_DECODE_PKCS12 = @as(c_int, 0);
pub const OSSL_STORE_F_TRY_DECODE_PKCS8ENCRYPTED = @as(c_int, 0);
pub const TS_F_DEF_SERIAL_CB = @as(c_int, 0);
pub const TS_F_DEF_TIME_CB = @as(c_int, 0);
pub const TS_F_ESS_ADD_SIGNING_CERT = @as(c_int, 0);
pub const TS_F_ESS_ADD_SIGNING_CERT_V2 = @as(c_int, 0);
pub const TS_F_ESS_CERT_ID_NEW_INIT = @as(c_int, 0);
pub const TS_F_ESS_CERT_ID_V2_NEW_INIT = @as(c_int, 0);
pub const TS_F_ESS_SIGNING_CERT_NEW_INIT = @as(c_int, 0);
pub const TS_F_ESS_SIGNING_CERT_V2_NEW_INIT = @as(c_int, 0);
pub const TS_F_INT_TS_RESP_VERIFY_TOKEN = @as(c_int, 0);
pub const TS_F_PKCS7_TO_TS_TST_INFO = @as(c_int, 0);
pub const TS_F_TS_ACCURACY_SET_MICROS = @as(c_int, 0);
pub const TS_F_TS_ACCURACY_SET_MILLIS = @as(c_int, 0);
pub const TS_F_TS_ACCURACY_SET_SECONDS = @as(c_int, 0);
pub const TS_F_TS_CHECK_IMPRINTS = @as(c_int, 0);
pub const TS_F_TS_CHECK_NONCES = @as(c_int, 0);
pub const TS_F_TS_CHECK_POLICY = @as(c_int, 0);
pub const TS_F_TS_CHECK_SIGNING_CERTS = @as(c_int, 0);
pub const TS_F_TS_CHECK_STATUS_INFO = @as(c_int, 0);
pub const TS_F_TS_COMPUTE_IMPRINT = @as(c_int, 0);
pub const TS_F_TS_CONF_INVALID = @as(c_int, 0);
pub const TS_F_TS_CONF_LOAD_CERT = @as(c_int, 0);
pub const TS_F_TS_CONF_LOAD_CERTS = @as(c_int, 0);
pub const TS_F_TS_CONF_LOAD_KEY = @as(c_int, 0);
pub const TS_F_TS_CONF_LOOKUP_FAIL = @as(c_int, 0);
pub const TS_F_TS_CONF_SET_DEFAULT_ENGINE = @as(c_int, 0);
pub const TS_F_TS_GET_STATUS_TEXT = @as(c_int, 0);
pub const TS_F_TS_MSG_IMPRINT_SET_ALGO = @as(c_int, 0);
pub const TS_F_TS_REQ_SET_MSG_IMPRINT = @as(c_int, 0);
pub const TS_F_TS_REQ_SET_NONCE = @as(c_int, 0);
pub const TS_F_TS_REQ_SET_POLICY_ID = @as(c_int, 0);
pub const TS_F_TS_RESP_CREATE_RESPONSE = @as(c_int, 0);
pub const TS_F_TS_RESP_CREATE_TST_INFO = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_ADD_FAILURE_INFO = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_ADD_MD = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_ADD_POLICY = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_NEW = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_SET_ACCURACY = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_SET_CERTS = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_SET_DEF_POLICY = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_SET_SIGNER_CERT = @as(c_int, 0);
pub const TS_F_TS_RESP_CTX_SET_STATUS_INFO = @as(c_int, 0);
pub const TS_F_TS_RESP_GET_POLICY = @as(c_int, 0);
pub const TS_F_TS_RESP_SET_GENTIME_WITH_PRECISION = @as(c_int, 0);
pub const TS_F_TS_RESP_SET_STATUS_INFO = @as(c_int, 0);
pub const TS_F_TS_RESP_SET_TST_INFO = @as(c_int, 0);
pub const TS_F_TS_RESP_SIGN = @as(c_int, 0);
pub const TS_F_TS_RESP_VERIFY_SIGNATURE = @as(c_int, 0);
pub const TS_F_TS_TST_INFO_SET_ACCURACY = @as(c_int, 0);
pub const TS_F_TS_TST_INFO_SET_MSG_IMPRINT = @as(c_int, 0);
pub const TS_F_TS_TST_INFO_SET_NONCE = @as(c_int, 0);
pub const TS_F_TS_TST_INFO_SET_POLICY_ID = @as(c_int, 0);
pub const TS_F_TS_TST_INFO_SET_SERIAL = @as(c_int, 0);
pub const TS_F_TS_TST_INFO_SET_TIME = @as(c_int, 0);
pub const TS_F_TS_TST_INFO_SET_TSA = @as(c_int, 0);
pub const TS_F_TS_VERIFY = @as(c_int, 0);
pub const TS_F_TS_VERIFY_CERT = @as(c_int, 0);
pub const TS_F_TS_VERIFY_CTX_NEW = @as(c_int, 0);
pub const UI_F_CLOSE_CONSOLE = @as(c_int, 0);
pub const UI_F_ECHO_CONSOLE = @as(c_int, 0);
pub const UI_F_GENERAL_ALLOCATE_BOOLEAN = @as(c_int, 0);
pub const UI_F_GENERAL_ALLOCATE_PROMPT = @as(c_int, 0);
pub const UI_F_NOECHO_CONSOLE = @as(c_int, 0);
pub const UI_F_OPEN_CONSOLE = @as(c_int, 0);
pub const UI_F_UI_CONSTRUCT_PROMPT = @as(c_int, 0);
pub const UI_F_UI_CREATE_METHOD = @as(c_int, 0);
pub const UI_F_UI_CTRL = @as(c_int, 0);
pub const UI_F_UI_DUP_ERROR_STRING = @as(c_int, 0);
pub const UI_F_UI_DUP_INFO_STRING = @as(c_int, 0);
pub const UI_F_UI_DUP_INPUT_BOOLEAN = @as(c_int, 0);
pub const UI_F_UI_DUP_INPUT_STRING = @as(c_int, 0);
pub const UI_F_UI_DUP_USER_DATA = @as(c_int, 0);
pub const UI_F_UI_DUP_VERIFY_STRING = @as(c_int, 0);
pub const UI_F_UI_GET0_RESULT = @as(c_int, 0);
pub const UI_F_UI_GET_RESULT_LENGTH = @as(c_int, 0);
pub const UI_F_UI_NEW_METHOD = @as(c_int, 0);
pub const UI_F_UI_PROCESS = @as(c_int, 0);
pub const UI_F_UI_SET_RESULT = @as(c_int, 0);
pub const UI_F_UI_SET_RESULT_EX = @as(c_int, 0);
pub const X509_F_ADD_CERT_DIR = @as(c_int, 0);
pub const X509_F_BUILD_CHAIN = @as(c_int, 0);
pub const X509_F_BY_FILE_CTRL = @as(c_int, 0);
pub const X509_F_CHECK_NAME_CONSTRAINTS = @as(c_int, 0);
pub const X509_F_CHECK_POLICY = @as(c_int, 0);
pub const X509_F_DANE_I2D = @as(c_int, 0);
pub const X509_F_DIR_CTRL = @as(c_int, 0);
pub const X509_F_GET_CERT_BY_SUBJECT = @as(c_int, 0);
pub const X509_F_I2D_X509_AUX = @as(c_int, 0);
pub const X509_F_LOOKUP_CERTS_SK = @as(c_int, 0);
pub const X509_F_NETSCAPE_SPKI_B64_DECODE = @as(c_int, 0);
pub const X509_F_NETSCAPE_SPKI_B64_ENCODE = @as(c_int, 0);
pub const X509_F_NEW_DIR = @as(c_int, 0);
pub const X509_F_X509AT_ADD1_ATTR = @as(c_int, 0);
pub const X509_F_X509V3_ADD_EXT = @as(c_int, 0);
pub const X509_F_X509_ATTRIBUTE_CREATE_BY_NID = @as(c_int, 0);
pub const X509_F_X509_ATTRIBUTE_CREATE_BY_OBJ = @as(c_int, 0);
pub const X509_F_X509_ATTRIBUTE_CREATE_BY_TXT = @as(c_int, 0);
pub const X509_F_X509_ATTRIBUTE_GET0_DATA = @as(c_int, 0);
pub const X509_F_X509_ATTRIBUTE_SET1_DATA = @as(c_int, 0);
pub const X509_F_X509_CHECK_PRIVATE_KEY = @as(c_int, 0);
pub const X509_F_X509_CRL_DIFF = @as(c_int, 0);
pub const X509_F_X509_CRL_METHOD_NEW = @as(c_int, 0);
pub const X509_F_X509_CRL_PRINT_FP = @as(c_int, 0);
pub const X509_F_X509_EXTENSION_CREATE_BY_NID = @as(c_int, 0);
pub const X509_F_X509_EXTENSION_CREATE_BY_OBJ = @as(c_int, 0);
pub const X509_F_X509_GET_PUBKEY_PARAMETERS = @as(c_int, 0);
pub const X509_F_X509_LOAD_CERT_CRL_FILE = @as(c_int, 0);
pub const X509_F_X509_LOAD_CERT_FILE = @as(c_int, 0);
pub const X509_F_X509_LOAD_CRL_FILE = @as(c_int, 0);
pub const X509_F_X509_LOOKUP_METH_NEW = @as(c_int, 0);
pub const X509_F_X509_LOOKUP_NEW = @as(c_int, 0);
pub const X509_F_X509_NAME_ADD_ENTRY = @as(c_int, 0);
pub const X509_F_X509_NAME_CANON = @as(c_int, 0);
pub const X509_F_X509_NAME_ENTRY_CREATE_BY_NID = @as(c_int, 0);
pub const X509_F_X509_NAME_ENTRY_CREATE_BY_TXT = @as(c_int, 0);
pub const X509_F_X509_NAME_ENTRY_SET_OBJECT = @as(c_int, 0);
pub const X509_F_X509_NAME_ONELINE = @as(c_int, 0);
pub const X509_F_X509_NAME_PRINT = @as(c_int, 0);
pub const X509_F_X509_OBJECT_NEW = @as(c_int, 0);
pub const X509_F_X509_PRINT_EX_FP = @as(c_int, 0);
pub const X509_F_X509_PUBKEY_DECODE = @as(c_int, 0);
pub const X509_F_X509_PUBKEY_GET = @as(c_int, 0);
pub const X509_F_X509_PUBKEY_GET0 = @as(c_int, 0);
pub const X509_F_X509_PUBKEY_SET = @as(c_int, 0);
pub const X509_F_X509_REQ_CHECK_PRIVATE_KEY = @as(c_int, 0);
pub const X509_F_X509_REQ_PRINT_EX = @as(c_int, 0);
pub const X509_F_X509_REQ_PRINT_FP = @as(c_int, 0);
pub const X509_F_X509_REQ_TO_X509 = @as(c_int, 0);
pub const X509_F_X509_STORE_ADD_CERT = @as(c_int, 0);
pub const X509_F_X509_STORE_ADD_CRL = @as(c_int, 0);
pub const X509_F_X509_STORE_ADD_LOOKUP = @as(c_int, 0);
pub const X509_F_X509_STORE_CTX_GET1_ISSUER = @as(c_int, 0);
pub const X509_F_X509_STORE_CTX_INIT = @as(c_int, 0);
pub const X509_F_X509_STORE_CTX_NEW = @as(c_int, 0);
pub const X509_F_X509_STORE_CTX_PURPOSE_INHERIT = @as(c_int, 0);
pub const X509_F_X509_STORE_NEW = @as(c_int, 0);
pub const X509_F_X509_TO_X509_REQ = @as(c_int, 0);
pub const X509_F_X509_TRUST_ADD = @as(c_int, 0);
pub const X509_F_X509_TRUST_SET = @as(c_int, 0);
pub const X509_F_X509_VERIFY_CERT = @as(c_int, 0);
pub const X509_F_X509_VERIFY_PARAM_NEW = @as(c_int, 0);
pub const X509V3_F_A2I_GENERAL_NAME = @as(c_int, 0);
pub const X509V3_F_ADDR_VALIDATE_PATH_INTERNAL = @as(c_int, 0);
pub const X509V3_F_ASIDENTIFIERCHOICE_CANONIZE = @as(c_int, 0);
pub const X509V3_F_ASIDENTIFIERCHOICE_IS_CANONICAL = @as(c_int, 0);
pub const X509V3_F_BIGNUM_TO_STRING = @as(c_int, 0);
pub const X509V3_F_COPY_EMAIL = @as(c_int, 0);
pub const X509V3_F_COPY_ISSUER = @as(c_int, 0);
pub const X509V3_F_DO_DIRNAME = @as(c_int, 0);
pub const X509V3_F_DO_EXT_I2D = @as(c_int, 0);
pub const X509V3_F_DO_EXT_NCONF = @as(c_int, 0);
pub const X509V3_F_GNAMES_FROM_SECTNAME = @as(c_int, 0);
pub const X509V3_F_I2S_ASN1_ENUMERATED = @as(c_int, 0);
pub const X509V3_F_I2S_ASN1_IA5STRING = @as(c_int, 0);
pub const X509V3_F_I2S_ASN1_INTEGER = @as(c_int, 0);
pub const X509V3_F_I2V_AUTHORITY_INFO_ACCESS = @as(c_int, 0);
pub const X509V3_F_LEVEL_ADD_NODE = @as(c_int, 0);
pub const X509V3_F_NOTICE_SECTION = @as(c_int, 0);
pub const X509V3_F_NREF_NOS = @as(c_int, 0);
pub const X509V3_F_POLICY_CACHE_CREATE = @as(c_int, 0);
pub const X509V3_F_POLICY_CACHE_NEW = @as(c_int, 0);
pub const X509V3_F_POLICY_DATA_NEW = @as(c_int, 0);
pub const X509V3_F_POLICY_SECTION = @as(c_int, 0);
pub const X509V3_F_PROCESS_PCI_VALUE = @as(c_int, 0);
pub const X509V3_F_R2I_CERTPOL = @as(c_int, 0);
pub const X509V3_F_R2I_PCI = @as(c_int, 0);
pub const X509V3_F_S2I_ASN1_IA5STRING = @as(c_int, 0);
pub const X509V3_F_S2I_ASN1_INTEGER = @as(c_int, 0);
pub const X509V3_F_S2I_ASN1_OCTET_STRING = @as(c_int, 0);
pub const X509V3_F_S2I_SKEY_ID = @as(c_int, 0);
pub const X509V3_F_SET_DIST_POINT_NAME = @as(c_int, 0);
pub const X509V3_F_SXNET_ADD_ID_ASC = @as(c_int, 0);
pub const X509V3_F_SXNET_ADD_ID_INTEGER = @as(c_int, 0);
pub const X509V3_F_SXNET_ADD_ID_ULONG = @as(c_int, 0);
pub const X509V3_F_SXNET_GET_ID_ASC = @as(c_int, 0);
pub const X509V3_F_SXNET_GET_ID_ULONG = @as(c_int, 0);
pub const X509V3_F_TREE_INIT = @as(c_int, 0);
pub const X509V3_F_V2I_ASIDENTIFIERS = @as(c_int, 0);
pub const X509V3_F_V2I_ASN1_BIT_STRING = @as(c_int, 0);
pub const X509V3_F_V2I_AUTHORITY_INFO_ACCESS = @as(c_int, 0);
pub const X509V3_F_V2I_AUTHORITY_KEYID = @as(c_int, 0);
pub const X509V3_F_V2I_BASIC_CONSTRAINTS = @as(c_int, 0);
pub const X509V3_F_V2I_CRLD = @as(c_int, 0);
pub const X509V3_F_V2I_EXTENDED_KEY_USAGE = @as(c_int, 0);
pub const X509V3_F_V2I_GENERAL_NAMES = @as(c_int, 0);
pub const X509V3_F_V2I_GENERAL_NAME_EX = @as(c_int, 0);
pub const X509V3_F_V2I_IDP = @as(c_int, 0);
pub const X509V3_F_V2I_IPADDRBLOCKS = @as(c_int, 0);
pub const X509V3_F_V2I_ISSUER_ALT = @as(c_int, 0);
pub const X509V3_F_V2I_NAME_CONSTRAINTS = @as(c_int, 0);
pub const X509V3_F_V2I_POLICY_CONSTRAINTS = @as(c_int, 0);
pub const X509V3_F_V2I_POLICY_MAPPINGS = @as(c_int, 0);
pub const X509V3_F_V2I_SUBJECT_ALT = @as(c_int, 0);
pub const X509V3_F_V2I_TLS_FEATURE = @as(c_int, 0);
pub const X509V3_F_V3_GENERIC_EXTENSION = @as(c_int, 0);
pub const X509V3_F_X509V3_ADD1_I2D = @as(c_int, 0);
pub const X509V3_F_X509V3_ADD_VALUE = @as(c_int, 0);
pub const X509V3_F_X509V3_EXT_ADD = @as(c_int, 0);
pub const X509V3_F_X509V3_EXT_ADD_ALIAS = @as(c_int, 0);
pub const X509V3_F_X509V3_EXT_I2D = @as(c_int, 0);
pub const X509V3_F_X509V3_EXT_NCONF = @as(c_int, 0);
pub const X509V3_F_X509V3_GET_SECTION = @as(c_int, 0);
pub const X509V3_F_X509V3_GET_STRING = @as(c_int, 0);
pub const X509V3_F_X509V3_GET_VALUE_BOOL = @as(c_int, 0);
pub const X509V3_F_X509V3_PARSE_LIST = @as(c_int, 0);
pub const X509V3_F_X509_PURPOSE_ADD = @as(c_int, 0);
pub const X509V3_F_X509_PURPOSE_SET = @as(c_int, 0);
pub const EVP_R_OPERATON_NOT_INITIALIZED = EVP_R_OPERATION_NOT_INITIALIZED;
pub const CRYPTO_R_BAD_ALGORITHM_NAME = @as(c_int, 117);
pub const CRYPTO_R_CONFLICTING_NAMES = @as(c_int, 118);
pub const CRYPTO_R_HEX_STRING_TOO_SHORT = @as(c_int, 121);
pub const CRYPTO_R_ILLEGAL_HEX_DIGIT = @as(c_int, 102);
pub const CRYPTO_R_INSUFFICIENT_DATA_SPACE = @as(c_int, 106);
pub const CRYPTO_R_INSUFFICIENT_PARAM_SIZE = @as(c_int, 107);
pub const CRYPTO_R_INSUFFICIENT_SECURE_DATA_SPACE = @as(c_int, 108);
pub const CRYPTO_R_INVALID_NEGATIVE_VALUE = @as(c_int, 122);
pub const CRYPTO_R_INVALID_NULL_ARGUMENT = @as(c_int, 109);
pub const CRYPTO_R_INVALID_OSSL_PARAM_TYPE = @as(c_int, 110);
pub const CRYPTO_R_ODD_NUMBER_OF_DIGITS = @as(c_int, 103);
pub const CRYPTO_R_PROVIDER_ALREADY_EXISTS = @as(c_int, 104);
pub const CRYPTO_R_PROVIDER_SECTION_ERROR = @as(c_int, 105);
pub const CRYPTO_R_RANDOM_SECTION_ERROR = @as(c_int, 119);
pub const CRYPTO_R_SECURE_MALLOC_FAILURE = @as(c_int, 111);
pub const CRYPTO_R_STRING_TOO_LONG = @as(c_int, 112);
pub const CRYPTO_R_TOO_MANY_BYTES = @as(c_int, 113);
pub const CRYPTO_R_TOO_MANY_RECORDS = @as(c_int, 114);
pub const CRYPTO_R_TOO_SMALL_BUFFER = @as(c_int, 116);
pub const CRYPTO_R_UNKNOWN_NAME_IN_RANDOM_SECTION = @as(c_int, 120);
pub const CRYPTO_R_ZERO_LENGTH_NUMBER = @as(c_int, 115);
pub const SSLeay = OpenSSL_version_num;
pub const SSLeay_version = OpenSSL_version;
pub const SSLEAY_VERSION_NUMBER = OPENSSL_VERSION_NUMBER;
pub const SSLEAY_VERSION = OPENSSL_VERSION;
pub const SSLEAY_CFLAGS = OPENSSL_CFLAGS;
pub const SSLEAY_BUILT_ON = OPENSSL_BUILT_ON;
pub const SSLEAY_PLATFORM = OPENSSL_PLATFORM;
pub const SSLEAY_DIR = OPENSSL_DIR;
pub const OPENSSL_malloc_init = @compileError("unable to translate C expr: unexpected token 'while'");
// /usr/include/openssl/crypto.h:93:9
pub inline fn OPENSSL_malloc(num: anytype) @TypeOf(CRYPTO_malloc(num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &num;
    return CRYPTO_malloc(num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_zalloc(num: anytype) @TypeOf(CRYPTO_zalloc(num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &num;
    return CRYPTO_zalloc(num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_realloc(addr: anytype, num: anytype) @TypeOf(CRYPTO_realloc(addr, num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &addr;
    _ = &num;
    return CRYPTO_realloc(addr, num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_clear_realloc(addr: anytype, old_num: anytype, num: anytype) @TypeOf(CRYPTO_clear_realloc(addr, old_num, num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &addr;
    _ = &old_num;
    _ = &num;
    return CRYPTO_clear_realloc(addr, old_num, num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_clear_free(addr: anytype, num: anytype) @TypeOf(CRYPTO_clear_free(addr, num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &addr;
    _ = &num;
    return CRYPTO_clear_free(addr, num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_free(addr: anytype) @TypeOf(CRYPTO_free(addr, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &addr;
    return CRYPTO_free(addr, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_memdup(str: anytype, s: anytype) @TypeOf(CRYPTO_memdup(str, s, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &str;
    _ = &s;
    return CRYPTO_memdup(str, s, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_strdup(str: anytype) @TypeOf(CRYPTO_strdup(str, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &str;
    return CRYPTO_strdup(str, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_strndup(str: anytype, n: anytype) @TypeOf(CRYPTO_strndup(str, n, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &str;
    _ = &n;
    return CRYPTO_strndup(str, n, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_secure_malloc(num: anytype) @TypeOf(CRYPTO_secure_malloc(num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &num;
    return CRYPTO_secure_malloc(num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_secure_zalloc(num: anytype) @TypeOf(CRYPTO_secure_zalloc(num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &num;
    return CRYPTO_secure_zalloc(num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_secure_free(addr: anytype) @TypeOf(CRYPTO_secure_free(addr, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &addr;
    return CRYPTO_secure_free(addr, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_secure_clear_free(addr: anytype, num: anytype) @TypeOf(CRYPTO_secure_clear_free(addr, num, OPENSSL_FILE, OPENSSL_LINE)) {
    _ = &addr;
    _ = &num;
    return CRYPTO_secure_clear_free(addr, num, OPENSSL_FILE, OPENSSL_LINE);
}
pub inline fn OPENSSL_secure_actual_size(ptr: anytype) @TypeOf(CRYPTO_secure_actual_size(ptr)) {
    _ = &ptr;
    return CRYPTO_secure_actual_size(ptr);
}
pub inline fn OPENSSL_MALLOC_MAX_NELEMS(@"type": anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div((@as(c_uint, 1) << ((@import("std").zig.c_translation.sizeof(c_int) * @as(c_int, 8)) - @as(c_int, 1))) - @as(c_int, 1), @import("std").zig.c_translation.sizeof(@"type"))) {
    _ = &@"type";
    return @import("std").zig.c_translation.MacroArithmetic.div((@as(c_uint, 1) << ((@import("std").zig.c_translation.sizeof(c_int) * @as(c_int, 8)) - @as(c_int, 1))) - @as(c_int, 1), @import("std").zig.c_translation.sizeof(@"type"));
}
pub const OPENSSL_VERSION = @as(c_int, 0);
pub const OPENSSL_CFLAGS = @as(c_int, 1);
pub const OPENSSL_BUILT_ON = @as(c_int, 2);
pub const OPENSSL_PLATFORM = @as(c_int, 3);
pub const OPENSSL_DIR = @as(c_int, 4);
pub const OPENSSL_ENGINES_DIR = @as(c_int, 5);
pub const OPENSSL_VERSION_STRING = @as(c_int, 6);
pub const OPENSSL_FULL_VERSION_STRING = @as(c_int, 7);
pub const OPENSSL_MODULES_DIR = @as(c_int, 8);
pub const OPENSSL_CPU_INFO = @as(c_int, 9);
pub const OPENSSL_INFO_CONFIG_DIR = @as(c_int, 1001);
pub const OPENSSL_INFO_ENGINES_DIR = @as(c_int, 1002);
pub const OPENSSL_INFO_MODULES_DIR = @as(c_int, 1003);
pub const OPENSSL_INFO_DSO_EXTENSION = @as(c_int, 1004);
pub const OPENSSL_INFO_DIR_FILENAME_SEPARATOR = @as(c_int, 1005);
pub const OPENSSL_INFO_LIST_SEPARATOR = @as(c_int, 1006);
pub const OPENSSL_INFO_SEED_SOURCE = @as(c_int, 1007);
pub const OPENSSL_INFO_CPU_SETTINGS = @as(c_int, 1008);
pub inline fn sk_void_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_void_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_void_sk_type(sk));
}
pub inline fn sk_void_value(sk: anytype, idx: anytype) ?*anyopaque {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_value(ossl_check_const_void_sk_type(sk), idx));
}
pub const sk_void_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/crypto.h:188:9
pub const sk_void_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/crypto.h:189:9
pub const sk_void_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/crypto.h:190:9
pub inline fn sk_void_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_void_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_void_sk_type(sk), n);
}
pub inline fn sk_void_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_void_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_void_sk_type(sk));
}
pub inline fn sk_void_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_void_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_void_sk_type(sk));
}
pub inline fn sk_void_delete(sk: anytype, i: anytype) ?*anyopaque {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_delete(ossl_check_void_sk_type(sk), i));
}
pub inline fn sk_void_delete_ptr(sk: anytype, ptr: anytype) ?*anyopaque {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_delete_ptr(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr)));
}
pub inline fn sk_void_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr));
}
pub inline fn sk_void_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr));
}
pub inline fn sk_void_pop(sk: anytype) ?*anyopaque {
    _ = &sk;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_pop(ossl_check_void_sk_type(sk)));
}
pub inline fn sk_void_shift(sk: anytype) ?*anyopaque {
    _ = &sk;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_shift(ossl_check_void_sk_type(sk)));
}
pub inline fn sk_void_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_void_sk_type(sk), ossl_check_void_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_void_sk_type(sk), ossl_check_void_freefunc_type(freefunc));
}
pub inline fn sk_void_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr), idx);
}
pub inline fn sk_void_set(sk: anytype, idx: anytype, ptr: anytype) ?*anyopaque {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast(?*anyopaque, OPENSSL_sk_set(ossl_check_void_sk_type(sk), idx, ossl_check_void_type(ptr)));
}
pub inline fn sk_void_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr));
}
pub inline fn sk_void_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr));
}
pub inline fn sk_void_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_void_sk_type(sk), ossl_check_void_type(ptr), pnum);
}
pub inline fn sk_void_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_void_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_void_sk_type(sk));
}
pub inline fn sk_void_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_void_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_void_sk_type(sk));
}
pub const sk_void_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/crypto.h:208:9
pub const sk_void_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/crypto.h:209:9
pub inline fn sk_void_set_cmp_func(sk: anytype, cmp: anytype) sk_void_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_void_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_void_sk_type(sk), ossl_check_void_compfunc_type(cmp)));
}
pub const CRYPTO_EX_INDEX_SSL = @as(c_int, 0);
pub const CRYPTO_EX_INDEX_SSL_CTX = @as(c_int, 1);
pub const CRYPTO_EX_INDEX_SSL_SESSION = @as(c_int, 2);
pub const CRYPTO_EX_INDEX_X509 = @as(c_int, 3);
pub const CRYPTO_EX_INDEX_X509_STORE = @as(c_int, 4);
pub const CRYPTO_EX_INDEX_X509_STORE_CTX = @as(c_int, 5);
pub const CRYPTO_EX_INDEX_DH = @as(c_int, 6);
pub const CRYPTO_EX_INDEX_DSA = @as(c_int, 7);
pub const CRYPTO_EX_INDEX_EC_KEY = @as(c_int, 8);
pub const CRYPTO_EX_INDEX_RSA = @as(c_int, 9);
pub const CRYPTO_EX_INDEX_ENGINE = @as(c_int, 10);
pub const CRYPTO_EX_INDEX_UI = @as(c_int, 11);
pub const CRYPTO_EX_INDEX_BIO = @as(c_int, 12);
pub const CRYPTO_EX_INDEX_APP = @as(c_int, 13);
pub const CRYPTO_EX_INDEX_UI_METHOD = @as(c_int, 14);
pub const CRYPTO_EX_INDEX_RAND_DRBG = @as(c_int, 15);
pub const CRYPTO_EX_INDEX_DRBG = CRYPTO_EX_INDEX_RAND_DRBG;
pub const CRYPTO_EX_INDEX_OSSL_LIB_CTX = @as(c_int, 16);
pub const CRYPTO_EX_INDEX_EVP_PKEY = @as(c_int, 17);
pub const CRYPTO_EX_INDEX__COUNT = @as(c_int, 18);
pub const CRYPTO_cleanup_all_ex_data = @compileError("unable to translate C expr: unexpected token 'while'");
// /usr/include/openssl/crypto.h:277:10
pub inline fn CRYPTO_num_locks() @TypeOf(@as(c_int, 1)) {
    return @as(c_int, 1);
}
pub const CRYPTO_set_locking_callback = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:290:11
pub inline fn CRYPTO_get_locking_callback() @TypeOf(NULL) {
    return NULL;
}
pub const CRYPTO_set_add_lock_callback = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:292:11
pub inline fn CRYPTO_get_add_lock_callback() @TypeOf(NULL) {
    return NULL;
}
pub const CRYPTO_LOCK = @as(c_int, 1);
pub const CRYPTO_UNLOCK = @as(c_int, 2);
pub const CRYPTO_READ = @as(c_int, 4);
pub const CRYPTO_WRITE = @as(c_int, 8);
pub const CRYPTO_THREADID_set_numeric = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:310:11
pub const CRYPTO_THREADID_set_pointer = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:311:11
pub inline fn CRYPTO_THREADID_set_callback(threadid_func: anytype) @TypeOf(@as(c_int, 0)) {
    _ = &threadid_func;
    return @as(c_int, 0);
}
pub inline fn CRYPTO_THREADID_get_callback() @TypeOf(NULL) {
    return NULL;
}
pub const CRYPTO_THREADID_current = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:314:11
pub inline fn CRYPTO_THREADID_cmp(a: anytype, b: anytype) @TypeOf(-@as(c_int, 1)) {
    _ = &a;
    _ = &b;
    return -@as(c_int, 1);
}
pub const CRYPTO_THREADID_cpy = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:316:11
pub inline fn CRYPTO_THREADID_hash(id: anytype) @TypeOf(@as(c_ulong, 0)) {
    _ = &id;
    return @as(c_ulong, 0);
}
pub const CRYPTO_set_id_callback = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:320:12
pub inline fn CRYPTO_get_id_callback() @TypeOf(NULL) {
    return NULL;
}
pub inline fn CRYPTO_thread_id() @TypeOf(@as(c_ulong, 0)) {
    return @as(c_ulong, 0);
}
pub const CRYPTO_set_dynlock_create_callback = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:325:11
pub const CRYPTO_set_dynlock_lock_callback = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:326:11
pub const CRYPTO_set_dynlock_destroy_callback = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/crypto.h:327:11
pub inline fn CRYPTO_get_dynlock_create_callback() @TypeOf(NULL) {
    return NULL;
}
pub inline fn CRYPTO_get_dynlock_lock_callback() @TypeOf(NULL) {
    return NULL;
}
pub inline fn CRYPTO_get_dynlock_destroy_callback() @TypeOf(NULL) {
    return NULL;
}
pub inline fn OpenSSLDie(f: anytype, l: anytype, a: anytype) @TypeOf(OPENSSL_die(a, f, l)) {
    _ = &f;
    _ = &l;
    _ = &a;
    return OPENSSL_die(a, f, l);
}
pub const OPENSSL_assert = @compileError("unable to translate C expr: expected ',' or ')' instead got '#'");
// /usr/include/openssl/crypto.h:419:10
pub const OPENSSL_INIT_NO_LOAD_CRYPTO_STRINGS = @as(c_long, 0x00000001);
pub const OPENSSL_INIT_LOAD_CRYPTO_STRINGS = @as(c_long, 0x00000002);
pub const OPENSSL_INIT_ADD_ALL_CIPHERS = @as(c_long, 0x00000004);
pub const OPENSSL_INIT_ADD_ALL_DIGESTS = @as(c_long, 0x00000008);
pub const OPENSSL_INIT_NO_ADD_ALL_CIPHERS = @as(c_long, 0x00000010);
pub const OPENSSL_INIT_NO_ADD_ALL_DIGESTS = @as(c_long, 0x00000020);
pub const OPENSSL_INIT_LOAD_CONFIG = @as(c_long, 0x00000040);
pub const OPENSSL_INIT_NO_LOAD_CONFIG = @as(c_long, 0x00000080);
pub const OPENSSL_INIT_ASYNC = @as(c_long, 0x00000100);
pub const OPENSSL_INIT_ENGINE_RDRAND = @as(c_long, 0x00000200);
pub const OPENSSL_INIT_ENGINE_DYNAMIC = @as(c_long, 0x00000400);
pub const OPENSSL_INIT_ENGINE_OPENSSL = @as(c_long, 0x00000800);
pub const OPENSSL_INIT_ENGINE_CRYPTODEV = @as(c_long, 0x00001000);
pub const OPENSSL_INIT_ENGINE_CAPI = @as(c_long, 0x00002000);
pub const OPENSSL_INIT_ENGINE_PADLOCK = @as(c_long, 0x00004000);
pub const OPENSSL_INIT_ENGINE_AFALG = @as(c_long, 0x00008000);
pub const OPENSSL_INIT_ATFORK = @as(c_long, 0x00020000);
pub const OPENSSL_INIT_NO_ATEXIT = @as(c_long, 0x00080000);
pub const OPENSSL_INIT_ENGINE_ALL_BUILTIN = (((OPENSSL_INIT_ENGINE_RDRAND | OPENSSL_INIT_ENGINE_DYNAMIC) | OPENSSL_INIT_ENGINE_CRYPTODEV) | OPENSSL_INIT_ENGINE_CAPI) | OPENSSL_INIT_ENGINE_PADLOCK;
pub const _PTHREAD_H = @as(c_int, 1);
pub const _SCHED_H = @as(c_int, 1);
pub const _BITS_SCHED_H = @as(c_int, 1);
pub const SCHED_OTHER = @as(c_int, 0);
pub const SCHED_FIFO = @as(c_int, 1);
pub const SCHED_RR = @as(c_int, 2);
pub const _BITS_TYPES_STRUCT_SCHED_PARAM = @as(c_int, 1);
pub const _BITS_CPU_SET_H = @as(c_int, 1);
pub const __CPU_SETSIZE = @as(c_int, 1024);
pub const __NCPUBITS = @as(c_int, 8) * @import("std").zig.c_translation.sizeof(__cpu_mask);
pub inline fn __CPUELT(cpu: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(cpu, __NCPUBITS)) {
    _ = &cpu;
    return @import("std").zig.c_translation.MacroArithmetic.div(cpu, __NCPUBITS);
}
pub inline fn __CPUMASK(cpu: anytype) @TypeOf(@import("std").zig.c_translation.cast(__cpu_mask, @as(c_int, 1)) << @import("std").zig.c_translation.MacroArithmetic.rem(cpu, __NCPUBITS)) {
    _ = &cpu;
    return @import("std").zig.c_translation.cast(__cpu_mask, @as(c_int, 1)) << @import("std").zig.c_translation.MacroArithmetic.rem(cpu, __NCPUBITS);
}
pub const __CPU_ZERO_S = @compileError("unable to translate C expr: unexpected token 'do'");
// /usr/include/x86_64-linux-gnu/bits/cpu-set.h:46:10
pub const __CPU_SET_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/x86_64-linux-gnu/bits/cpu-set.h:58:9
pub const __CPU_CLR_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/x86_64-linux-gnu/bits/cpu-set.h:65:9
pub const __CPU_ISSET_S = @compileError("unable to translate macro: undefined identifier `__cpu`");
// /usr/include/x86_64-linux-gnu/bits/cpu-set.h:72:9
pub inline fn __CPU_COUNT_S(setsize: anytype, cpusetp: anytype) @TypeOf(__sched_cpucount(setsize, cpusetp)) {
    _ = &setsize;
    _ = &cpusetp;
    return __sched_cpucount(setsize, cpusetp);
}
pub const __CPU_EQUAL_S = @compileError("unable to translate macro: undefined identifier `__builtin_memcmp`");
// /usr/include/x86_64-linux-gnu/bits/cpu-set.h:84:10
pub const __CPU_OP_S = @compileError("unable to translate macro: undefined identifier `__dest`");
// /usr/include/x86_64-linux-gnu/bits/cpu-set.h:99:9
pub inline fn __CPU_ALLOC_SIZE(count: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * @import("std").zig.c_translation.sizeof(__cpu_mask)) {
    _ = &count;
    return @import("std").zig.c_translation.MacroArithmetic.div((count + __NCPUBITS) - @as(c_int, 1), __NCPUBITS) * @import("std").zig.c_translation.sizeof(__cpu_mask);
}
pub inline fn __CPU_ALLOC(count: anytype) @TypeOf(__sched_cpualloc(count)) {
    _ = &count;
    return __sched_cpualloc(count);
}
pub inline fn __CPU_FREE(cpuset: anytype) @TypeOf(__sched_cpufree(cpuset)) {
    _ = &cpuset;
    return __sched_cpufree(cpuset);
}
pub const __sched_priority = @compileError("unable to translate macro: undefined identifier `sched_priority`");
// /usr/include/sched.h:48:9
pub const _BITS_SETJMP_H = @as(c_int, 1);
pub const __jmp_buf_tag_defined = @as(c_int, 1);
pub const PTHREAD_MUTEX_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/pthread.h:90:9
pub const PTHREAD_RWLOCK_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/pthread.h:114:10
pub const PTHREAD_COND_INITIALIZER = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/pthread.h:155:9
pub const PTHREAD_CANCELED = @import("std").zig.c_translation.cast(?*anyopaque, -@as(c_int, 1));
pub const PTHREAD_ONCE_INIT = @as(c_int, 0);
pub const PTHREAD_BARRIER_SERIAL_THREAD = -@as(c_int, 1);
pub const __cleanup_fct_attribute = "";
pub const pthread_cleanup_push = @compileError("unable to translate macro: undefined identifier `__cancel_buf`");
// /usr/include/pthread.h:681:10
pub const pthread_cleanup_pop = @compileError("unable to translate macro: undefined identifier `__cancel_buf`");
// /usr/include/pthread.h:702:10
pub inline fn __sigsetjmp_cancel(env: anytype, savemask: anytype) @TypeOf(__sigsetjmp(@import("std").zig.c_translation.cast([*c]struct___jmp_buf_tag, @import("std").zig.c_translation.cast(?*anyopaque, env)), savemask)) {
    _ = &env;
    _ = &savemask;
    return __sigsetjmp(@import("std").zig.c_translation.cast([*c]struct___jmp_buf_tag, @import("std").zig.c_translation.cast(?*anyopaque, env)), savemask);
}
pub const CRYPTO_ONCE_STATIC_INIT = PTHREAD_ONCE_INIT;
pub const OPENSSL_BIOERR_H = "";
pub const BIO_R_ACCEPT_ERROR = @as(c_int, 100);
pub const BIO_R_ADDRINFO_ADDR_IS_NOT_AF_INET = @as(c_int, 141);
pub const BIO_R_AMBIGUOUS_HOST_OR_SERVICE = @as(c_int, 129);
pub const BIO_R_BAD_FOPEN_MODE = @as(c_int, 101);
pub const BIO_R_BROKEN_PIPE = @as(c_int, 124);
pub const BIO_R_CONNECT_ERROR = @as(c_int, 103);
pub const BIO_R_CONNECT_TIMEOUT = @as(c_int, 147);
pub const BIO_R_GETHOSTBYNAME_ADDR_IS_NOT_AF_INET = @as(c_int, 107);
pub const BIO_R_GETSOCKNAME_ERROR = @as(c_int, 132);
pub const BIO_R_GETSOCKNAME_TRUNCATED_ADDRESS = @as(c_int, 133);
pub const BIO_R_GETTING_SOCKTYPE = @as(c_int, 134);
pub const BIO_R_INVALID_ARGUMENT = @as(c_int, 125);
pub const BIO_R_INVALID_SOCKET = @as(c_int, 135);
pub const BIO_R_IN_USE = @as(c_int, 123);
pub const BIO_R_LENGTH_TOO_LONG = @as(c_int, 102);
pub const BIO_R_LISTEN_V6_ONLY = @as(c_int, 136);
pub const BIO_R_LOOKUP_RETURNED_NOTHING = @as(c_int, 142);
pub const BIO_R_MALFORMED_HOST_OR_SERVICE = @as(c_int, 130);
pub const BIO_R_NBIO_CONNECT_ERROR = @as(c_int, 110);
pub const BIO_R_NO_ACCEPT_ADDR_OR_SERVICE_SPECIFIED = @as(c_int, 143);
pub const BIO_R_NO_HOSTNAME_OR_SERVICE_SPECIFIED = @as(c_int, 144);
pub const BIO_R_NO_PORT_DEFINED = @as(c_int, 113);
pub const BIO_R_NO_SUCH_FILE = @as(c_int, 128);
pub const BIO_R_NULL_PARAMETER = @as(c_int, 115);
pub const BIO_R_TRANSFER_ERROR = @as(c_int, 104);
pub const BIO_R_TRANSFER_TIMEOUT = @as(c_int, 105);
pub const BIO_R_UNABLE_TO_BIND_SOCKET = @as(c_int, 117);
pub const BIO_R_UNABLE_TO_CREATE_SOCKET = @as(c_int, 118);
pub const BIO_R_UNABLE_TO_KEEPALIVE = @as(c_int, 137);
pub const BIO_R_UNABLE_TO_LISTEN_SOCKET = @as(c_int, 119);
pub const BIO_R_UNABLE_TO_NODELAY = @as(c_int, 138);
pub const BIO_R_UNABLE_TO_REUSEADDR = @as(c_int, 139);
pub const BIO_R_UNAVAILABLE_IP_FAMILY = @as(c_int, 145);
pub const BIO_R_UNINITIALIZED = @as(c_int, 120);
pub const BIO_R_UNKNOWN_INFO_TYPE = @as(c_int, 140);
pub const BIO_R_UNSUPPORTED_IP_FAMILY = @as(c_int, 146);
pub const BIO_R_UNSUPPORTED_METHOD = @as(c_int, 121);
pub const BIO_R_UNSUPPORTED_PROTOCOL_FAMILY = @as(c_int, 131);
pub const BIO_R_WRITE_TO_READ_ONLY_BIO = @as(c_int, 126);
pub const BIO_R_WSASTARTUP = @as(c_int, 122);
pub const BIO_TYPE_DESCRIPTOR = @as(c_int, 0x0100);
pub const BIO_TYPE_FILTER = @as(c_int, 0x0200);
pub const BIO_TYPE_SOURCE_SINK = @as(c_int, 0x0400);
pub const BIO_TYPE_NONE = @as(c_int, 0);
pub const BIO_TYPE_MEM = @as(c_int, 1) | BIO_TYPE_SOURCE_SINK;
pub const BIO_TYPE_FILE = @as(c_int, 2) | BIO_TYPE_SOURCE_SINK;
pub const BIO_TYPE_FD = (@as(c_int, 4) | BIO_TYPE_SOURCE_SINK) | BIO_TYPE_DESCRIPTOR;
pub const BIO_TYPE_SOCKET = (@as(c_int, 5) | BIO_TYPE_SOURCE_SINK) | BIO_TYPE_DESCRIPTOR;
pub const BIO_TYPE_NULL = @as(c_int, 6) | BIO_TYPE_SOURCE_SINK;
pub const BIO_TYPE_SSL = @as(c_int, 7) | BIO_TYPE_FILTER;
pub const BIO_TYPE_MD = @as(c_int, 8) | BIO_TYPE_FILTER;
pub const BIO_TYPE_BUFFER = @as(c_int, 9) | BIO_TYPE_FILTER;
pub const BIO_TYPE_CIPHER = @as(c_int, 10) | BIO_TYPE_FILTER;
pub const BIO_TYPE_BASE64 = @as(c_int, 11) | BIO_TYPE_FILTER;
pub const BIO_TYPE_CONNECT = (@as(c_int, 12) | BIO_TYPE_SOURCE_SINK) | BIO_TYPE_DESCRIPTOR;
pub const BIO_TYPE_ACCEPT = (@as(c_int, 13) | BIO_TYPE_SOURCE_SINK) | BIO_TYPE_DESCRIPTOR;
pub const BIO_TYPE_NBIO_TEST = @as(c_int, 16) | BIO_TYPE_FILTER;
pub const BIO_TYPE_NULL_FILTER = @as(c_int, 17) | BIO_TYPE_FILTER;
pub const BIO_TYPE_BIO = @as(c_int, 19) | BIO_TYPE_SOURCE_SINK;
pub const BIO_TYPE_LINEBUFFER = @as(c_int, 20) | BIO_TYPE_FILTER;
pub const BIO_TYPE_DGRAM = (@as(c_int, 21) | BIO_TYPE_SOURCE_SINK) | BIO_TYPE_DESCRIPTOR;
pub const BIO_TYPE_ASN1 = @as(c_int, 22) | BIO_TYPE_FILTER;
pub const BIO_TYPE_COMP = @as(c_int, 23) | BIO_TYPE_FILTER;
pub const BIO_TYPE_CORE_TO_PROV = @as(c_int, 25) | BIO_TYPE_SOURCE_SINK;
pub const BIO_TYPE_START = @as(c_int, 128);
pub const BIO_NOCLOSE = @as(c_int, 0x00);
pub const BIO_CLOSE = @as(c_int, 0x01);
pub const BIO_CTRL_RESET = @as(c_int, 1);
pub const BIO_CTRL_EOF = @as(c_int, 2);
pub const BIO_CTRL_INFO = @as(c_int, 3);
pub const BIO_CTRL_SET = @as(c_int, 4);
pub const BIO_CTRL_GET = @as(c_int, 5);
pub const BIO_CTRL_PUSH = @as(c_int, 6);
pub const BIO_CTRL_POP = @as(c_int, 7);
pub const BIO_CTRL_GET_CLOSE = @as(c_int, 8);
pub const BIO_CTRL_SET_CLOSE = @as(c_int, 9);
pub const BIO_CTRL_PENDING = @as(c_int, 10);
pub const BIO_CTRL_FLUSH = @as(c_int, 11);
pub const BIO_CTRL_DUP = @as(c_int, 12);
pub const BIO_CTRL_WPENDING = @as(c_int, 13);
pub const BIO_CTRL_SET_CALLBACK = @as(c_int, 14);
pub const BIO_CTRL_GET_CALLBACK = @as(c_int, 15);
pub const BIO_CTRL_PEEK = @as(c_int, 29);
pub const BIO_CTRL_SET_FILENAME = @as(c_int, 30);
pub const BIO_CTRL_DGRAM_CONNECT = @as(c_int, 31);
pub const BIO_CTRL_DGRAM_SET_CONNECTED = @as(c_int, 32);
pub const BIO_CTRL_DGRAM_SET_RECV_TIMEOUT = @as(c_int, 33);
pub const BIO_CTRL_DGRAM_GET_RECV_TIMEOUT = @as(c_int, 34);
pub const BIO_CTRL_DGRAM_SET_SEND_TIMEOUT = @as(c_int, 35);
pub const BIO_CTRL_DGRAM_GET_SEND_TIMEOUT = @as(c_int, 36);
pub const BIO_CTRL_DGRAM_GET_RECV_TIMER_EXP = @as(c_int, 37);
pub const BIO_CTRL_DGRAM_GET_SEND_TIMER_EXP = @as(c_int, 38);
pub const BIO_CTRL_DGRAM_MTU_DISCOVER = @as(c_int, 39);
pub const BIO_CTRL_DGRAM_QUERY_MTU = @as(c_int, 40);
pub const BIO_CTRL_DGRAM_GET_FALLBACK_MTU = @as(c_int, 47);
pub const BIO_CTRL_DGRAM_GET_MTU = @as(c_int, 41);
pub const BIO_CTRL_DGRAM_SET_MTU = @as(c_int, 42);
pub const BIO_CTRL_DGRAM_MTU_EXCEEDED = @as(c_int, 43);
pub const BIO_CTRL_DGRAM_GET_PEER = @as(c_int, 46);
pub const BIO_CTRL_DGRAM_SET_PEER = @as(c_int, 44);
pub const BIO_CTRL_DGRAM_SET_NEXT_TIMEOUT = @as(c_int, 45);
pub const BIO_CTRL_DGRAM_SET_DONT_FRAG = @as(c_int, 48);
pub const BIO_CTRL_DGRAM_GET_MTU_OVERHEAD = @as(c_int, 49);
pub const BIO_CTRL_DGRAM_SCTP_SET_IN_HANDSHAKE = @as(c_int, 50);
pub const BIO_CTRL_DGRAM_SET_PEEK_MODE = @as(c_int, 71);
pub const BIO_CTRL_GET_KTLS_SEND = @as(c_int, 73);
pub const BIO_CTRL_GET_KTLS_RECV = @as(c_int, 76);
pub const BIO_CTRL_DGRAM_SCTP_WAIT_FOR_DRY = @as(c_int, 77);
pub const BIO_CTRL_DGRAM_SCTP_MSG_WAITING = @as(c_int, 78);
pub const BIO_CTRL_SET_PREFIX = @as(c_int, 79);
pub const BIO_CTRL_SET_INDENT = @as(c_int, 80);
pub const BIO_CTRL_GET_INDENT = @as(c_int, 81);
pub inline fn BIO_get_ktls_send(b: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_GET_KTLS_SEND, @as(c_int, 0), NULL) > @as(c_int, 0)) {
    _ = &b;
    return BIO_ctrl(b, BIO_CTRL_GET_KTLS_SEND, @as(c_int, 0), NULL) > @as(c_int, 0);
}
pub inline fn BIO_get_ktls_recv(b: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_GET_KTLS_RECV, @as(c_int, 0), NULL) > @as(c_int, 0)) {
    _ = &b;
    return BIO_ctrl(b, BIO_CTRL_GET_KTLS_RECV, @as(c_int, 0), NULL) > @as(c_int, 0);
}
pub const BIO_FP_READ = @as(c_int, 0x02);
pub const BIO_FP_WRITE = @as(c_int, 0x04);
pub const BIO_FP_APPEND = @as(c_int, 0x08);
pub const BIO_FP_TEXT = @as(c_int, 0x10);
pub const BIO_FLAGS_READ = @as(c_int, 0x01);
pub const BIO_FLAGS_WRITE = @as(c_int, 0x02);
pub const BIO_FLAGS_IO_SPECIAL = @as(c_int, 0x04);
pub const BIO_FLAGS_RWS = (BIO_FLAGS_READ | BIO_FLAGS_WRITE) | BIO_FLAGS_IO_SPECIAL;
pub const BIO_FLAGS_SHOULD_RETRY = @as(c_int, 0x08);
pub const BIO_FLAGS_UPLINK = @as(c_int, 0);
pub const BIO_FLAGS_BASE64_NO_NL = @as(c_int, 0x100);
pub const BIO_FLAGS_MEM_RDONLY = @as(c_int, 0x200);
pub const BIO_FLAGS_NONCLEAR_RST = @as(c_int, 0x400);
pub const BIO_FLAGS_IN_EOF = @as(c_int, 0x800);
pub inline fn BIO_get_flags(b: anytype) @TypeOf(BIO_test_flags(b, ~@as(c_int, 0x0))) {
    _ = &b;
    return BIO_test_flags(b, ~@as(c_int, 0x0));
}
pub inline fn BIO_set_retry_special(b: anytype) @TypeOf(BIO_set_flags(b, BIO_FLAGS_IO_SPECIAL | BIO_FLAGS_SHOULD_RETRY)) {
    _ = &b;
    return BIO_set_flags(b, BIO_FLAGS_IO_SPECIAL | BIO_FLAGS_SHOULD_RETRY);
}
pub inline fn BIO_set_retry_read(b: anytype) @TypeOf(BIO_set_flags(b, BIO_FLAGS_READ | BIO_FLAGS_SHOULD_RETRY)) {
    _ = &b;
    return BIO_set_flags(b, BIO_FLAGS_READ | BIO_FLAGS_SHOULD_RETRY);
}
pub inline fn BIO_set_retry_write(b: anytype) @TypeOf(BIO_set_flags(b, BIO_FLAGS_WRITE | BIO_FLAGS_SHOULD_RETRY)) {
    _ = &b;
    return BIO_set_flags(b, BIO_FLAGS_WRITE | BIO_FLAGS_SHOULD_RETRY);
}
pub inline fn BIO_clear_retry_flags(b: anytype) @TypeOf(BIO_clear_flags(b, BIO_FLAGS_RWS | BIO_FLAGS_SHOULD_RETRY)) {
    _ = &b;
    return BIO_clear_flags(b, BIO_FLAGS_RWS | BIO_FLAGS_SHOULD_RETRY);
}
pub inline fn BIO_get_retry_flags(b: anytype) @TypeOf(BIO_test_flags(b, BIO_FLAGS_RWS | BIO_FLAGS_SHOULD_RETRY)) {
    _ = &b;
    return BIO_test_flags(b, BIO_FLAGS_RWS | BIO_FLAGS_SHOULD_RETRY);
}
pub inline fn BIO_should_read(a: anytype) @TypeOf(BIO_test_flags(a, BIO_FLAGS_READ)) {
    _ = &a;
    return BIO_test_flags(a, BIO_FLAGS_READ);
}
pub inline fn BIO_should_write(a: anytype) @TypeOf(BIO_test_flags(a, BIO_FLAGS_WRITE)) {
    _ = &a;
    return BIO_test_flags(a, BIO_FLAGS_WRITE);
}
pub inline fn BIO_should_io_special(a: anytype) @TypeOf(BIO_test_flags(a, BIO_FLAGS_IO_SPECIAL)) {
    _ = &a;
    return BIO_test_flags(a, BIO_FLAGS_IO_SPECIAL);
}
pub inline fn BIO_retry_type(a: anytype) @TypeOf(BIO_test_flags(a, BIO_FLAGS_RWS)) {
    _ = &a;
    return BIO_test_flags(a, BIO_FLAGS_RWS);
}
pub inline fn BIO_should_retry(a: anytype) @TypeOf(BIO_test_flags(a, BIO_FLAGS_SHOULD_RETRY)) {
    _ = &a;
    return BIO_test_flags(a, BIO_FLAGS_SHOULD_RETRY);
}
pub const BIO_RR_SSL_X509_LOOKUP = @as(c_int, 0x01);
pub const BIO_RR_CONNECT = @as(c_int, 0x02);
pub const BIO_RR_ACCEPT = @as(c_int, 0x03);
pub const BIO_CB_FREE = @as(c_int, 0x01);
pub const BIO_CB_READ = @as(c_int, 0x02);
pub const BIO_CB_WRITE = @as(c_int, 0x03);
pub const BIO_CB_PUTS = @as(c_int, 0x04);
pub const BIO_CB_GETS = @as(c_int, 0x05);
pub const BIO_CB_CTRL = @as(c_int, 0x06);
pub const BIO_CB_RETURN = @as(c_int, 0x80);
pub inline fn BIO_CB_return(a: anytype) @TypeOf(a | BIO_CB_RETURN) {
    _ = &a;
    return a | BIO_CB_RETURN;
}
pub inline fn BIO_cb_pre(a: anytype) @TypeOf(!((a & BIO_CB_RETURN) != 0)) {
    _ = &a;
    return !((a & BIO_CB_RETURN) != 0);
}
pub inline fn BIO_cb_post(a: anytype) @TypeOf(a & BIO_CB_RETURN) {
    _ = &a;
    return a & BIO_CB_RETURN;
}
pub inline fn sk_BIO_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_BIO_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_BIO_sk_type(sk));
}
pub inline fn sk_BIO_value(sk: anytype, idx: anytype) [*c]BIO {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]BIO, OPENSSL_sk_value(ossl_check_const_BIO_sk_type(sk), idx));
}
pub const sk_BIO_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/bio.h:307:9
pub const sk_BIO_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/bio.h:308:9
pub const sk_BIO_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/bio.h:309:9
pub inline fn sk_BIO_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_BIO_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_BIO_sk_type(sk), n);
}
pub inline fn sk_BIO_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_BIO_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_BIO_sk_type(sk));
}
pub inline fn sk_BIO_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_BIO_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_BIO_sk_type(sk));
}
pub inline fn sk_BIO_delete(sk: anytype, i: anytype) [*c]BIO {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]BIO, OPENSSL_sk_delete(ossl_check_BIO_sk_type(sk), i));
}
pub inline fn sk_BIO_delete_ptr(sk: anytype, ptr: anytype) [*c]BIO {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]BIO, OPENSSL_sk_delete_ptr(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr)));
}
pub inline fn sk_BIO_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr));
}
pub inline fn sk_BIO_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr));
}
pub inline fn sk_BIO_pop(sk: anytype) [*c]BIO {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]BIO, OPENSSL_sk_pop(ossl_check_BIO_sk_type(sk)));
}
pub inline fn sk_BIO_shift(sk: anytype) [*c]BIO {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]BIO, OPENSSL_sk_shift(ossl_check_BIO_sk_type(sk)));
}
pub inline fn sk_BIO_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_BIO_sk_type(sk), ossl_check_BIO_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_BIO_sk_type(sk), ossl_check_BIO_freefunc_type(freefunc));
}
pub inline fn sk_BIO_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr), idx);
}
pub inline fn sk_BIO_set(sk: anytype, idx: anytype, ptr: anytype) [*c]BIO {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]BIO, OPENSSL_sk_set(ossl_check_BIO_sk_type(sk), idx, ossl_check_BIO_type(ptr)));
}
pub inline fn sk_BIO_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr));
}
pub inline fn sk_BIO_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr));
}
pub inline fn sk_BIO_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_BIO_sk_type(sk), ossl_check_BIO_type(ptr), pnum);
}
pub inline fn sk_BIO_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_BIO_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_BIO_sk_type(sk));
}
pub inline fn sk_BIO_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_BIO_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_BIO_sk_type(sk));
}
pub const sk_BIO_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/bio.h:327:9
pub const sk_BIO_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/bio.h:328:9
pub inline fn sk_BIO_set_cmp_func(sk: anytype, cmp: anytype) sk_BIO_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_BIO_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_BIO_sk_type(sk), ossl_check_BIO_compfunc_type(cmp)));
}
pub const BIO_C_SET_CONNECT = @as(c_int, 100);
pub const BIO_C_DO_STATE_MACHINE = @as(c_int, 101);
pub const BIO_C_SET_NBIO = @as(c_int, 102);
pub const BIO_C_SET_FD = @as(c_int, 104);
pub const BIO_C_GET_FD = @as(c_int, 105);
pub const BIO_C_SET_FILE_PTR = @as(c_int, 106);
pub const BIO_C_GET_FILE_PTR = @as(c_int, 107);
pub const BIO_C_SET_FILENAME = @as(c_int, 108);
pub const BIO_C_SET_SSL = @as(c_int, 109);
pub const BIO_C_GET_SSL = @as(c_int, 110);
pub const BIO_C_SET_MD = @as(c_int, 111);
pub const BIO_C_GET_MD = @as(c_int, 112);
pub const BIO_C_GET_CIPHER_STATUS = @as(c_int, 113);
pub const BIO_C_SET_BUF_MEM = @as(c_int, 114);
pub const BIO_C_GET_BUF_MEM_PTR = @as(c_int, 115);
pub const BIO_C_GET_BUFF_NUM_LINES = @as(c_int, 116);
pub const BIO_C_SET_BUFF_SIZE = @as(c_int, 117);
pub const BIO_C_SET_ACCEPT = @as(c_int, 118);
pub const BIO_C_SSL_MODE = @as(c_int, 119);
pub const BIO_C_GET_MD_CTX = @as(c_int, 120);
pub const BIO_C_SET_BUFF_READ_DATA = @as(c_int, 122);
pub const BIO_C_GET_CONNECT = @as(c_int, 123);
pub const BIO_C_GET_ACCEPT = @as(c_int, 124);
pub const BIO_C_SET_SSL_RENEGOTIATE_BYTES = @as(c_int, 125);
pub const BIO_C_GET_SSL_NUM_RENEGOTIATES = @as(c_int, 126);
pub const BIO_C_SET_SSL_RENEGOTIATE_TIMEOUT = @as(c_int, 127);
pub const BIO_C_FILE_SEEK = @as(c_int, 128);
pub const BIO_C_GET_CIPHER_CTX = @as(c_int, 129);
pub const BIO_C_SET_BUF_MEM_EOF_RETURN = @as(c_int, 130);
pub const BIO_C_SET_BIND_MODE = @as(c_int, 131);
pub const BIO_C_GET_BIND_MODE = @as(c_int, 132);
pub const BIO_C_FILE_TELL = @as(c_int, 133);
pub const BIO_C_GET_SOCKS = @as(c_int, 134);
pub const BIO_C_SET_SOCKS = @as(c_int, 135);
pub const BIO_C_SET_WRITE_BUF_SIZE = @as(c_int, 136);
pub const BIO_C_GET_WRITE_BUF_SIZE = @as(c_int, 137);
pub const BIO_C_MAKE_BIO_PAIR = @as(c_int, 138);
pub const BIO_C_DESTROY_BIO_PAIR = @as(c_int, 139);
pub const BIO_C_GET_WRITE_GUARANTEE = @as(c_int, 140);
pub const BIO_C_GET_READ_REQUEST = @as(c_int, 141);
pub const BIO_C_SHUTDOWN_WR = @as(c_int, 142);
pub const BIO_C_NREAD0 = @as(c_int, 143);
pub const BIO_C_NREAD = @as(c_int, 144);
pub const BIO_C_NWRITE0 = @as(c_int, 145);
pub const BIO_C_NWRITE = @as(c_int, 146);
pub const BIO_C_RESET_READ_REQUEST = @as(c_int, 147);
pub const BIO_C_SET_MD_CTX = @as(c_int, 148);
pub const BIO_C_SET_PREFIX = @as(c_int, 149);
pub const BIO_C_GET_PREFIX = @as(c_int, 150);
pub const BIO_C_SET_SUFFIX = @as(c_int, 151);
pub const BIO_C_GET_SUFFIX = @as(c_int, 152);
pub const BIO_C_SET_EX_ARG = @as(c_int, 153);
pub const BIO_C_GET_EX_ARG = @as(c_int, 154);
pub const BIO_C_SET_CONNECT_MODE = @as(c_int, 155);
pub inline fn BIO_set_app_data(s: anytype, arg: anytype) @TypeOf(BIO_set_ex_data(s, @as(c_int, 0), arg)) {
    _ = &s;
    _ = &arg;
    return BIO_set_ex_data(s, @as(c_int, 0), arg);
}
pub inline fn BIO_get_app_data(s: anytype) @TypeOf(BIO_get_ex_data(s, @as(c_int, 0))) {
    _ = &s;
    return BIO_get_ex_data(s, @as(c_int, 0));
}
pub inline fn BIO_set_nbio(b: anytype, n: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_NBIO, n, NULL)) {
    _ = &b;
    _ = &n;
    return BIO_ctrl(b, BIO_C_SET_NBIO, n, NULL);
}
pub const BIO_FAMILY_IPV4 = @as(c_int, 4);
pub const BIO_FAMILY_IPV6 = @as(c_int, 6);
pub const BIO_FAMILY_IPANY = @as(c_int, 256);
pub inline fn BIO_set_conn_hostname(b: anytype, name: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, name))) {
    _ = &b;
    _ = &name;
    return BIO_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, name));
}
pub inline fn BIO_set_conn_port(b: anytype, port: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 1), @import("std").zig.c_translation.cast([*c]u8, port))) {
    _ = &b;
    _ = &port;
    return BIO_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 1), @import("std").zig.c_translation.cast([*c]u8, port));
}
pub inline fn BIO_set_conn_address(b: anytype, addr: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 2), @import("std").zig.c_translation.cast([*c]u8, addr))) {
    _ = &b;
    _ = &addr;
    return BIO_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 2), @import("std").zig.c_translation.cast([*c]u8, addr));
}
pub inline fn BIO_set_conn_ip_family(b: anytype, f: anytype) @TypeOf(BIO_int_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 3), f)) {
    _ = &b;
    _ = &f;
    return BIO_int_ctrl(b, BIO_C_SET_CONNECT, @as(c_int, 3), f);
}
pub const BIO_get_conn_hostname = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/bio.h:451:11
pub const BIO_get_conn_port = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/bio.h:452:11
pub const BIO_get_conn_address = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/bio.h:453:11
pub inline fn BIO_get_conn_ip_family(b: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_CONNECT, @as(c_int, 3), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_C_GET_CONNECT, @as(c_int, 3), NULL);
}
pub inline fn BIO_set_conn_mode(b: anytype, n: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_CONNECT_MODE, n, NULL)) {
    _ = &b;
    _ = &n;
    return BIO_ctrl(b, BIO_C_SET_CONNECT_MODE, n, NULL);
}
pub inline fn BIO_set_accept_name(b: anytype, name: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, name))) {
    _ = &b;
    _ = &name;
    return BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, name));
}
pub inline fn BIO_set_accept_port(b: anytype, port: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 1), @import("std").zig.c_translation.cast([*c]u8, port))) {
    _ = &b;
    _ = &port;
    return BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 1), @import("std").zig.c_translation.cast([*c]u8, port));
}
pub const BIO_get_accept_name = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/bio.h:462:11
pub const BIO_get_accept_port = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/bio.h:463:11
pub const BIO_get_peer_name = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/bio.h:464:11
pub const BIO_get_peer_port = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/bio.h:465:11
pub inline fn BIO_set_nbio_accept(b: anytype, n: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 2), if (n) @import("std").zig.c_translation.cast(?*anyopaque, "a") else NULL)) {
    _ = &b;
    _ = &n;
    return BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 2), if (n) @import("std").zig.c_translation.cast(?*anyopaque, "a") else NULL);
}
pub inline fn BIO_set_accept_bios(b: anytype, bio: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 3), @import("std").zig.c_translation.cast([*c]u8, bio))) {
    _ = &b;
    _ = &bio;
    return BIO_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 3), @import("std").zig.c_translation.cast([*c]u8, bio));
}
pub inline fn BIO_set_accept_ip_family(b: anytype, f: anytype) @TypeOf(BIO_int_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 4), f)) {
    _ = &b;
    _ = &f;
    return BIO_int_ctrl(b, BIO_C_SET_ACCEPT, @as(c_int, 4), f);
}
pub inline fn BIO_get_accept_ip_family(b: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_ACCEPT, @as(c_int, 4), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_C_GET_ACCEPT, @as(c_int, 4), NULL);
}
pub const BIO_BIND_NORMAL = @as(c_int, 0);
pub const BIO_BIND_REUSEADDR = BIO_SOCK_REUSEADDR;
pub const BIO_BIND_REUSEADDR_IF_UNUSED = BIO_SOCK_REUSEADDR;
pub inline fn BIO_set_bind_mode(b: anytype, mode: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_BIND_MODE, mode, NULL)) {
    _ = &b;
    _ = &mode;
    return BIO_ctrl(b, BIO_C_SET_BIND_MODE, mode, NULL);
}
pub inline fn BIO_get_bind_mode(b: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_BIND_MODE, @as(c_int, 0), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_C_GET_BIND_MODE, @as(c_int, 0), NULL);
}
pub inline fn BIO_do_connect(b: anytype) @TypeOf(BIO_do_handshake(b)) {
    _ = &b;
    return BIO_do_handshake(b);
}
pub inline fn BIO_do_accept(b: anytype) @TypeOf(BIO_do_handshake(b)) {
    _ = &b;
    return BIO_do_handshake(b);
}
pub inline fn BIO_do_handshake(b: anytype) @TypeOf(BIO_ctrl(b, BIO_C_DO_STATE_MACHINE, @as(c_int, 0), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_C_DO_STATE_MACHINE, @as(c_int, 0), NULL);
}
pub inline fn BIO_set_fd(b: anytype, fd: anytype, c: anytype) @TypeOf(BIO_int_ctrl(b, BIO_C_SET_FD, c, fd)) {
    _ = &b;
    _ = &fd;
    _ = &c;
    return BIO_int_ctrl(b, BIO_C_SET_FD, c, fd);
}
pub inline fn BIO_get_fd(b: anytype, c: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_FD, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, c))) {
    _ = &b;
    _ = &c;
    return BIO_ctrl(b, BIO_C_GET_FD, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, c));
}
pub inline fn BIO_set_fp(b: anytype, fp: anytype, c: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_FILE_PTR, c, @import("std").zig.c_translation.cast([*c]u8, fp))) {
    _ = &b;
    _ = &fp;
    _ = &c;
    return BIO_ctrl(b, BIO_C_SET_FILE_PTR, c, @import("std").zig.c_translation.cast([*c]u8, fp));
}
pub inline fn BIO_get_fp(b: anytype, fpp: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_FILE_PTR, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, fpp))) {
    _ = &b;
    _ = &fpp;
    return BIO_ctrl(b, BIO_C_GET_FILE_PTR, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, fpp));
}
pub inline fn BIO_seek(b: anytype, ofs: anytype) c_int {
    _ = &b;
    _ = &ofs;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_FILE_SEEK, ofs, NULL));
}
pub inline fn BIO_tell(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_FILE_TELL, @as(c_int, 0), NULL));
}
pub inline fn BIO_read_filename(b: anytype, name: anytype) c_int {
    _ = &b;
    _ = &name;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_SET_FILENAME, BIO_CLOSE | BIO_FP_READ, @import("std").zig.c_translation.cast([*c]u8, name)));
}
pub inline fn BIO_write_filename(b: anytype, name: anytype) c_int {
    _ = &b;
    _ = &name;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_SET_FILENAME, BIO_CLOSE | BIO_FP_WRITE, name));
}
pub inline fn BIO_append_filename(b: anytype, name: anytype) c_int {
    _ = &b;
    _ = &name;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_SET_FILENAME, BIO_CLOSE | BIO_FP_APPEND, name));
}
pub inline fn BIO_rw_filename(b: anytype, name: anytype) c_int {
    _ = &b;
    _ = &name;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_SET_FILENAME, (BIO_CLOSE | BIO_FP_READ) | BIO_FP_WRITE, name));
}
pub inline fn BIO_set_ssl(b: anytype, ssl: anytype, c: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_SSL, c, @import("std").zig.c_translation.cast([*c]u8, ssl))) {
    _ = &b;
    _ = &ssl;
    _ = &c;
    return BIO_ctrl(b, BIO_C_SET_SSL, c, @import("std").zig.c_translation.cast([*c]u8, ssl));
}
pub inline fn BIO_get_ssl(b: anytype, sslp: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_SSL, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, sslp))) {
    _ = &b;
    _ = &sslp;
    return BIO_ctrl(b, BIO_C_GET_SSL, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, sslp));
}
pub inline fn BIO_set_ssl_mode(b: anytype, client: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SSL_MODE, client, NULL)) {
    _ = &b;
    _ = &client;
    return BIO_ctrl(b, BIO_C_SSL_MODE, client, NULL);
}
pub inline fn BIO_set_ssl_renegotiate_bytes(b: anytype, num: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_SSL_RENEGOTIATE_BYTES, num, NULL)) {
    _ = &b;
    _ = &num;
    return BIO_ctrl(b, BIO_C_SET_SSL_RENEGOTIATE_BYTES, num, NULL);
}
pub inline fn BIO_get_num_renegotiates(b: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_SSL_NUM_RENEGOTIATES, @as(c_int, 0), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_C_GET_SSL_NUM_RENEGOTIATES, @as(c_int, 0), NULL);
}
pub inline fn BIO_set_ssl_renegotiate_timeout(b: anytype, seconds: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_SSL_RENEGOTIATE_TIMEOUT, seconds, NULL)) {
    _ = &b;
    _ = &seconds;
    return BIO_ctrl(b, BIO_C_SET_SSL_RENEGOTIATE_TIMEOUT, seconds, NULL);
}
pub inline fn BIO_get_mem_data(b: anytype, pp: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_INFO, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, pp))) {
    _ = &b;
    _ = &pp;
    return BIO_ctrl(b, BIO_CTRL_INFO, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, pp));
}
pub inline fn BIO_set_mem_buf(b: anytype, bm: anytype, c: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_BUF_MEM, c, @import("std").zig.c_translation.cast([*c]u8, bm))) {
    _ = &b;
    _ = &bm;
    _ = &c;
    return BIO_ctrl(b, BIO_C_SET_BUF_MEM, c, @import("std").zig.c_translation.cast([*c]u8, bm));
}
pub inline fn BIO_get_mem_ptr(b: anytype, pp: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_BUF_MEM_PTR, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, pp))) {
    _ = &b;
    _ = &pp;
    return BIO_ctrl(b, BIO_C_GET_BUF_MEM_PTR, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, pp));
}
pub inline fn BIO_set_mem_eof_return(b: anytype, v: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_BUF_MEM_EOF_RETURN, v, NULL)) {
    _ = &b;
    _ = &v;
    return BIO_ctrl(b, BIO_C_SET_BUF_MEM_EOF_RETURN, v, NULL);
}
pub inline fn BIO_get_buffer_num_lines(b: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_BUFF_NUM_LINES, @as(c_int, 0), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_C_GET_BUFF_NUM_LINES, @as(c_int, 0), NULL);
}
pub inline fn BIO_set_buffer_size(b: anytype, size: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_BUFF_SIZE, size, NULL)) {
    _ = &b;
    _ = &size;
    return BIO_ctrl(b, BIO_C_SET_BUFF_SIZE, size, NULL);
}
pub inline fn BIO_set_read_buffer_size(b: anytype, size: anytype) @TypeOf(BIO_int_ctrl(b, BIO_C_SET_BUFF_SIZE, size, @as(c_int, 0))) {
    _ = &b;
    _ = &size;
    return BIO_int_ctrl(b, BIO_C_SET_BUFF_SIZE, size, @as(c_int, 0));
}
pub inline fn BIO_set_write_buffer_size(b: anytype, size: anytype) @TypeOf(BIO_int_ctrl(b, BIO_C_SET_BUFF_SIZE, size, @as(c_int, 1))) {
    _ = &b;
    _ = &size;
    return BIO_int_ctrl(b, BIO_C_SET_BUFF_SIZE, size, @as(c_int, 1));
}
pub inline fn BIO_set_buffer_read_data(b: anytype, buf: anytype, num: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_BUFF_READ_DATA, num, buf)) {
    _ = &b;
    _ = &buf;
    _ = &num;
    return BIO_ctrl(b, BIO_C_SET_BUFF_READ_DATA, num, buf);
}
pub inline fn BIO_dup_state(b: anytype, ret: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_DUP, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, ret))) {
    _ = &b;
    _ = &ret;
    return BIO_ctrl(b, BIO_CTRL_DUP, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, ret));
}
pub inline fn BIO_reset(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_RESET, @as(c_int, 0), NULL));
}
pub inline fn BIO_eof(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_EOF, @as(c_int, 0), NULL));
}
pub inline fn BIO_set_close(b: anytype, c: anytype) c_int {
    _ = &b;
    _ = &c;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_SET_CLOSE, c, NULL));
}
pub inline fn BIO_get_close(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_GET_CLOSE, @as(c_int, 0), NULL));
}
pub inline fn BIO_pending(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_PENDING, @as(c_int, 0), NULL));
}
pub inline fn BIO_wpending(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_WPENDING, @as(c_int, 0), NULL));
}
pub inline fn BIO_flush(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_FLUSH, @as(c_int, 0), NULL));
}
pub inline fn BIO_get_info_callback(b: anytype, cbp: anytype) c_int {
    _ = &b;
    _ = &cbp;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_GET_CALLBACK, @as(c_int, 0), cbp));
}
pub inline fn BIO_set_info_callback(b: anytype, cb: anytype) c_int {
    _ = &b;
    _ = &cb;
    return @import("std").zig.c_translation.cast(c_int, BIO_callback_ctrl(b, BIO_CTRL_SET_CALLBACK, cb));
}
pub inline fn BIO_buffer_get_num_lines(b: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_GET, @as(c_int, 0), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_CTRL_GET, @as(c_int, 0), NULL);
}
pub inline fn BIO_buffer_peek(b: anytype, s: anytype, l: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_PEEK, l, s)) {
    _ = &b;
    _ = &s;
    _ = &l;
    return BIO_ctrl(b, BIO_CTRL_PEEK, l, s);
}
pub inline fn BIO_set_write_buf_size(b: anytype, size: anytype) c_int {
    _ = &b;
    _ = &size;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_SET_WRITE_BUF_SIZE, size, NULL));
}
pub inline fn BIO_get_write_buf_size(b: anytype, size: anytype) usize {
    _ = &b;
    _ = &size;
    return @import("std").zig.c_translation.cast(usize, BIO_ctrl(b, BIO_C_GET_WRITE_BUF_SIZE, size, NULL));
}
pub inline fn BIO_make_bio_pair(b1: anytype, b2: anytype) c_int {
    _ = &b1;
    _ = &b2;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b1, BIO_C_MAKE_BIO_PAIR, @as(c_int, 0), b2));
}
pub inline fn BIO_destroy_bio_pair(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_DESTROY_BIO_PAIR, @as(c_int, 0), NULL));
}
pub inline fn BIO_shutdown_wr(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_SHUTDOWN_WR, @as(c_int, 0), NULL));
}
pub inline fn BIO_get_write_guarantee(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_GET_WRITE_GUARANTEE, @as(c_int, 0), NULL));
}
pub inline fn BIO_get_read_request(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_C_GET_READ_REQUEST, @as(c_int, 0), NULL));
}
pub inline fn BIO_ctrl_dgram_connect(b: anytype, peer: anytype) c_int {
    _ = &b;
    _ = &peer;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_DGRAM_CONNECT, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, peer)));
}
pub inline fn BIO_ctrl_set_connected(b: anytype, peer: anytype) c_int {
    _ = &b;
    _ = &peer;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_DGRAM_SET_CONNECTED, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, peer)));
}
pub inline fn BIO_dgram_recv_timedout(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_DGRAM_GET_RECV_TIMER_EXP, @as(c_int, 0), NULL));
}
pub inline fn BIO_dgram_send_timedout(b: anytype) c_int {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_DGRAM_GET_SEND_TIMER_EXP, @as(c_int, 0), NULL));
}
pub inline fn BIO_dgram_get_peer(b: anytype, peer: anytype) c_int {
    _ = &b;
    _ = &peer;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_DGRAM_GET_PEER, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, peer)));
}
pub inline fn BIO_dgram_set_peer(b: anytype, peer: anytype) c_int {
    _ = &b;
    _ = &peer;
    return @import("std").zig.c_translation.cast(c_int, BIO_ctrl(b, BIO_CTRL_DGRAM_SET_PEER, @as(c_int, 0), @import("std").zig.c_translation.cast([*c]u8, peer)));
}
pub inline fn BIO_dgram_get_mtu_overhead(b: anytype) c_uint {
    _ = &b;
    return @import("std").zig.c_translation.cast(c_uint, BIO_ctrl(b, BIO_CTRL_DGRAM_GET_MTU_OVERHEAD, @as(c_int, 0), NULL));
}
pub inline fn BIO_set_prefix(b: anytype, p: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_SET_PREFIX, @as(c_int, 0), @import("std").zig.c_translation.cast(?*anyopaque, p))) {
    _ = &b;
    _ = &p;
    return BIO_ctrl(b, BIO_CTRL_SET_PREFIX, @as(c_int, 0), @import("std").zig.c_translation.cast(?*anyopaque, p));
}
pub inline fn BIO_set_indent(b: anytype, i: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_SET_INDENT, i, NULL)) {
    _ = &b;
    _ = &i;
    return BIO_ctrl(b, BIO_CTRL_SET_INDENT, i, NULL);
}
pub inline fn BIO_get_indent(b: anytype) @TypeOf(BIO_ctrl(b, BIO_CTRL_GET_INDENT, @as(c_int, 0), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_CTRL_GET_INDENT, @as(c_int, 0), NULL);
}
pub inline fn BIO_get_ex_new_index(l: anytype, p: anytype, newf: anytype, dupf: anytype, freef: anytype) @TypeOf(CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_BIO, l, p, newf, dupf, freef)) {
    _ = &l;
    _ = &p;
    _ = &newf;
    _ = &dupf;
    _ = &freef;
    return CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_BIO, l, p, newf, dupf, freef);
}
pub const BIO_sock_cleanup = @compileError("unable to translate C expr: unexpected token 'while'");
// /usr/include/openssl/bio.h:766:11
pub const BIO_SOCK_REUSEADDR = @as(c_int, 0x01);
pub const BIO_SOCK_V6_ONLY = @as(c_int, 0x02);
pub const BIO_SOCK_KEEPALIVE = @as(c_int, 0x04);
pub const BIO_SOCK_NONBLOCK = @as(c_int, 0x08);
pub const BIO_SOCK_NODELAY = @as(c_int, 0x10);
pub const ossl_bio__attr__ = @compileError("unable to translate C expr: unexpected token ''");
// /usr/include/openssl/bio.h:820:10
pub const ossl_bio__printf__ = @compileError("unable to translate macro: undefined identifier `__printf__`");
// /usr/include/openssl/bio.h:834:13
pub const OPENSSL_EVPERR_H = "";
pub const EVP_R_AES_KEY_SETUP_FAILED = @as(c_int, 143);
pub const EVP_R_ARIA_KEY_SETUP_FAILED = @as(c_int, 176);
pub const EVP_R_BAD_ALGORITHM_NAME = @as(c_int, 200);
pub const EVP_R_BAD_DECRYPT = @as(c_int, 100);
pub const EVP_R_BAD_KEY_LENGTH = @as(c_int, 195);
pub const EVP_R_BUFFER_TOO_SMALL = @as(c_int, 155);
pub const EVP_R_CACHE_CONSTANTS_FAILED = @as(c_int, 225);
pub const EVP_R_CAMELLIA_KEY_SETUP_FAILED = @as(c_int, 157);
pub const EVP_R_CANNOT_GET_PARAMETERS = @as(c_int, 197);
pub const EVP_R_CANNOT_SET_PARAMETERS = @as(c_int, 198);
pub const EVP_R_CIPHER_NOT_GCM_MODE = @as(c_int, 184);
pub const EVP_R_CIPHER_PARAMETER_ERROR = @as(c_int, 122);
pub const EVP_R_COMMAND_NOT_SUPPORTED = @as(c_int, 147);
pub const EVP_R_CONFLICTING_ALGORITHM_NAME = @as(c_int, 201);
pub const EVP_R_COPY_ERROR = @as(c_int, 173);
pub const EVP_R_CTRL_NOT_IMPLEMENTED = @as(c_int, 132);
pub const EVP_R_CTRL_OPERATION_NOT_IMPLEMENTED = @as(c_int, 133);
pub const EVP_R_DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH = @as(c_int, 138);
pub const EVP_R_DECODE_ERROR = @as(c_int, 114);
pub const EVP_R_DEFAULT_QUERY_PARSE_ERROR = @as(c_int, 210);
pub const EVP_R_DIFFERENT_KEY_TYPES = @as(c_int, 101);
pub const EVP_R_DIFFERENT_PARAMETERS = @as(c_int, 153);
pub const EVP_R_ERROR_LOADING_SECTION = @as(c_int, 165);
pub const EVP_R_EXPECTING_AN_HMAC_KEY = @as(c_int, 174);
pub const EVP_R_EXPECTING_AN_RSA_KEY = @as(c_int, 127);
pub const EVP_R_EXPECTING_A_DH_KEY = @as(c_int, 128);
pub const EVP_R_EXPECTING_A_DSA_KEY = @as(c_int, 129);
pub const EVP_R_EXPECTING_A_ECX_KEY = @as(c_int, 219);
pub const EVP_R_EXPECTING_A_EC_KEY = @as(c_int, 142);
pub const EVP_R_EXPECTING_A_POLY1305_KEY = @as(c_int, 164);
pub const EVP_R_EXPECTING_A_SIPHASH_KEY = @as(c_int, 175);
pub const EVP_R_FINAL_ERROR = @as(c_int, 188);
pub const EVP_R_GENERATE_ERROR = @as(c_int, 214);
pub const EVP_R_GET_RAW_KEY_FAILED = @as(c_int, 182);
pub const EVP_R_ILLEGAL_SCRYPT_PARAMETERS = @as(c_int, 171);
pub const EVP_R_INACCESSIBLE_DOMAIN_PARAMETERS = @as(c_int, 204);
pub const EVP_R_INACCESSIBLE_KEY = @as(c_int, 203);
pub const EVP_R_INITIALIZATION_ERROR = @as(c_int, 134);
pub const EVP_R_INPUT_NOT_INITIALIZED = @as(c_int, 111);
pub const EVP_R_INVALID_CUSTOM_LENGTH = @as(c_int, 185);
pub const EVP_R_INVALID_DIGEST = @as(c_int, 152);
pub const EVP_R_INVALID_IV_LENGTH = @as(c_int, 194);
pub const EVP_R_INVALID_KEY = @as(c_int, 163);
pub const EVP_R_INVALID_KEY_LENGTH = @as(c_int, 130);
pub const EVP_R_INVALID_LENGTH = @as(c_int, 221);
pub const EVP_R_INVALID_NULL_ALGORITHM = @as(c_int, 218);
pub const EVP_R_INVALID_OPERATION = @as(c_int, 148);
pub const EVP_R_INVALID_PROVIDER_FUNCTIONS = @as(c_int, 193);
pub const EVP_R_INVALID_SALT_LENGTH = @as(c_int, 186);
pub const EVP_R_INVALID_SECRET_LENGTH = @as(c_int, 223);
pub const EVP_R_INVALID_SEED_LENGTH = @as(c_int, 220);
pub const EVP_R_INVALID_VALUE = @as(c_int, 222);
pub const EVP_R_KEYMGMT_EXPORT_FAILURE = @as(c_int, 205);
pub const EVP_R_KEY_SETUP_FAILED = @as(c_int, 180);
pub const EVP_R_LOCKING_NOT_SUPPORTED = @as(c_int, 213);
pub const EVP_R_MEMORY_LIMIT_EXCEEDED = @as(c_int, 172);
pub const EVP_R_MESSAGE_DIGEST_IS_NULL = @as(c_int, 159);
pub const EVP_R_METHOD_NOT_SUPPORTED = @as(c_int, 144);
pub const EVP_R_MISSING_PARAMETERS = @as(c_int, 103);
pub const EVP_R_NOT_ABLE_TO_COPY_CTX = @as(c_int, 190);
pub const EVP_R_NOT_XOF_OR_INVALID_LENGTH = @as(c_int, 178);
pub const EVP_R_NO_CIPHER_SET = @as(c_int, 131);
pub const EVP_R_NO_DEFAULT_DIGEST = @as(c_int, 158);
pub const EVP_R_NO_DIGEST_SET = @as(c_int, 139);
pub const EVP_R_NO_IMPORT_FUNCTION = @as(c_int, 206);
pub const EVP_R_NO_KEYMGMT_AVAILABLE = @as(c_int, 199);
pub const EVP_R_NO_KEYMGMT_PRESENT = @as(c_int, 196);
pub const EVP_R_NO_KEY_SET = @as(c_int, 154);
pub const EVP_R_NO_OPERATION_SET = @as(c_int, 149);
pub const EVP_R_NULL_MAC_PKEY_CTX = @as(c_int, 208);
pub const EVP_R_ONLY_ONESHOT_SUPPORTED = @as(c_int, 177);
pub const EVP_R_OPERATION_NOT_INITIALIZED = @as(c_int, 151);
pub const EVP_R_OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE = @as(c_int, 150);
pub const EVP_R_OUTPUT_WOULD_OVERFLOW = @as(c_int, 202);
pub const EVP_R_PARAMETER_TOO_LARGE = @as(c_int, 187);
pub const EVP_R_PARTIALLY_OVERLAPPING = @as(c_int, 162);
pub const EVP_R_PBKDF2_ERROR = @as(c_int, 181);
pub const EVP_R_PKEY_APPLICATION_ASN1_METHOD_ALREADY_REGISTERED = @as(c_int, 179);
pub const EVP_R_PRIVATE_KEY_DECODE_ERROR = @as(c_int, 145);
pub const EVP_R_PRIVATE_KEY_ENCODE_ERROR = @as(c_int, 146);
pub const EVP_R_PUBLIC_KEY_NOT_RSA = @as(c_int, 106);
pub const EVP_R_SETTING_XOF_FAILED = @as(c_int, 227);
pub const EVP_R_SET_DEFAULT_PROPERTY_FAILURE = @as(c_int, 209);
pub const EVP_R_TOO_MANY_RECORDS = @as(c_int, 183);
pub const EVP_R_UNABLE_TO_ENABLE_LOCKING = @as(c_int, 212);
pub const EVP_R_UNABLE_TO_GET_MAXIMUM_REQUEST_SIZE = @as(c_int, 215);
pub const EVP_R_UNABLE_TO_GET_RANDOM_STRENGTH = @as(c_int, 216);
pub const EVP_R_UNABLE_TO_LOCK_CONTEXT = @as(c_int, 211);
pub const EVP_R_UNABLE_TO_SET_CALLBACKS = @as(c_int, 217);
pub const EVP_R_UNKNOWN_CIPHER = @as(c_int, 160);
pub const EVP_R_UNKNOWN_DIGEST = @as(c_int, 161);
pub const EVP_R_UNKNOWN_KEY_TYPE = @as(c_int, 207);
pub const EVP_R_UNKNOWN_OPTION = @as(c_int, 169);
pub const EVP_R_UNKNOWN_PBE_ALGORITHM = @as(c_int, 121);
pub const EVP_R_UNSUPPORTED_ALGORITHM = @as(c_int, 156);
pub const EVP_R_UNSUPPORTED_CIPHER = @as(c_int, 107);
pub const EVP_R_UNSUPPORTED_KEYLENGTH = @as(c_int, 123);
pub const EVP_R_UNSUPPORTED_KEY_DERIVATION_FUNCTION = @as(c_int, 124);
pub const EVP_R_UNSUPPORTED_KEY_SIZE = @as(c_int, 108);
pub const EVP_R_UNSUPPORTED_KEY_TYPE = @as(c_int, 224);
pub const EVP_R_UNSUPPORTED_NUMBER_OF_ROUNDS = @as(c_int, 135);
pub const EVP_R_UNSUPPORTED_PRF = @as(c_int, 125);
pub const EVP_R_UNSUPPORTED_PRIVATE_KEY_ALGORITHM = @as(c_int, 118);
pub const EVP_R_UNSUPPORTED_SALT_TYPE = @as(c_int, 126);
pub const EVP_R_UPDATE_ERROR = @as(c_int, 189);
pub const EVP_R_WRAP_MODE_NOT_ALLOWED = @as(c_int, 170);
pub const EVP_R_WRONG_FINAL_BLOCK_LENGTH = @as(c_int, 109);
pub const EVP_R_XTS_DATA_UNIT_IS_TOO_LARGE = @as(c_int, 191);
pub const EVP_R_XTS_DUPLICATED_KEYS = @as(c_int, 192);
pub const OPENSSL_PARAMS_H = "";
pub const OPENSSL_BN_H = "";
pub const HEADER_BN_H = "";
pub const OPENSSL_BNERR_H = "";
pub const BN_R_ARG2_LT_ARG3 = @as(c_int, 100);
pub const BN_R_BAD_RECIPROCAL = @as(c_int, 101);
pub const BN_R_BIGNUM_TOO_LONG = @as(c_int, 114);
pub const BN_R_BITS_TOO_SMALL = @as(c_int, 118);
pub const BN_R_CALLED_WITH_EVEN_MODULUS = @as(c_int, 102);
pub const BN_R_DIV_BY_ZERO = @as(c_int, 103);
pub const BN_R_ENCODING_ERROR = @as(c_int, 104);
pub const BN_R_EXPAND_ON_STATIC_BIGNUM_DATA = @as(c_int, 105);
pub const BN_R_INPUT_NOT_REDUCED = @as(c_int, 110);
pub const BN_R_INVALID_LENGTH = @as(c_int, 106);
pub const BN_R_INVALID_RANGE = @as(c_int, 115);
pub const BN_R_INVALID_SHIFT = @as(c_int, 119);
pub const BN_R_NOT_A_SQUARE = @as(c_int, 111);
pub const BN_R_NOT_INITIALIZED = @as(c_int, 107);
pub const BN_R_NO_INVERSE = @as(c_int, 108);
pub const BN_R_NO_PRIME_CANDIDATE = @as(c_int, 121);
pub const BN_R_NO_SOLUTION = @as(c_int, 116);
pub const BN_R_NO_SUITABLE_DIGEST = @as(c_int, 120);
pub const BN_R_PRIVATE_KEY_TOO_LARGE = @as(c_int, 117);
pub const BN_R_P_IS_NOT_PRIME = @as(c_int, 112);
pub const BN_R_TOO_MANY_ITERATIONS = @as(c_int, 113);
pub const BN_R_TOO_MANY_TEMPORARY_VARIABLES = @as(c_int, 109);
pub const BN_ULONG = c_ulong;
pub const BN_BYTES = @as(c_int, 8);
pub const BN_BITS2 = BN_BYTES * @as(c_int, 8);
pub const BN_BITS = BN_BITS2 * @as(c_int, 2);
pub const BN_TBIT = @compileError("unable to translate C expr: expected ')' instead got 'A number'");
// /usr/include/openssl/bn.h:56:10
pub const BN_FLG_MALLOCED = @as(c_int, 0x01);
pub const BN_FLG_STATIC_DATA = @as(c_int, 0x02);
pub const BN_FLG_CONSTTIME = @as(c_int, 0x04);
pub const BN_FLG_SECURE = @as(c_int, 0x08);
pub const BN_FLG_EXP_CONSTTIME = BN_FLG_CONSTTIME;
pub const BN_FLG_FREE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hex);
pub const BN_RAND_TOP_ANY = -@as(c_int, 1);
pub const BN_RAND_TOP_ONE = @as(c_int, 0);
pub const BN_RAND_TOP_TWO = @as(c_int, 1);
pub const BN_RAND_BOTTOM_ANY = @as(c_int, 0);
pub const BN_RAND_BOTTOM_ODD = @as(c_int, 1);
pub const BN_prime_checks = @as(c_int, 0);
pub inline fn BN_prime_checks_for_size(b: anytype) @TypeOf(if (b >= @as(c_int, 3747)) @as(c_int, 3) else if (b >= @as(c_int, 1345)) @as(c_int, 4) else if (b >= @as(c_int, 476)) @as(c_int, 5) else if (b >= @as(c_int, 400)) @as(c_int, 6) else if (b >= @as(c_int, 347)) @as(c_int, 7) else if (b >= @as(c_int, 308)) @as(c_int, 8) else if (b >= @as(c_int, 55)) @as(c_int, 27) else @as(c_int, 34)) {
    _ = &b;
    return if (b >= @as(c_int, 3747)) @as(c_int, 3) else if (b >= @as(c_int, 1345)) @as(c_int, 4) else if (b >= @as(c_int, 476)) @as(c_int, 5) else if (b >= @as(c_int, 400)) @as(c_int, 6) else if (b >= @as(c_int, 347)) @as(c_int, 7) else if (b >= @as(c_int, 308)) @as(c_int, 8) else if (b >= @as(c_int, 55)) @as(c_int, 27) else @as(c_int, 34);
}
pub inline fn BN_num_bytes(a: anytype) @TypeOf(@import("std").zig.c_translation.MacroArithmetic.div(BN_num_bits(a) + @as(c_int, 7), @as(c_int, 8))) {
    _ = &a;
    return @import("std").zig.c_translation.MacroArithmetic.div(BN_num_bits(a) + @as(c_int, 7), @as(c_int, 8));
}
pub inline fn BN_one(a: anytype) @TypeOf(BN_set_word(a, @as(c_int, 1))) {
    _ = &a;
    return BN_set_word(a, @as(c_int, 1));
}
pub inline fn BN_zero(a: anytype) @TypeOf(BN_zero_ex(a)) {
    _ = &a;
    return BN_zero_ex(a);
}
pub inline fn BN_mod(rem: anytype, m: anytype, d: anytype, ctx: anytype) @TypeOf(BN_div(NULL, rem, m, d, ctx)) {
    _ = &rem;
    _ = &m;
    _ = &d;
    _ = &ctx;
    return BN_div(NULL, rem, m, d, ctx);
}
pub const BN_BLINDING_NO_UPDATE = @as(c_int, 0x00000001);
pub const BN_BLINDING_NO_RECREATE = @as(c_int, 0x00000002);
pub inline fn BN_GF2m_sub(r: anytype, a: anytype, b: anytype) @TypeOf(BN_GF2m_add(r, a, b)) {
    _ = &r;
    _ = &a;
    _ = &b;
    return BN_GF2m_add(r, a, b);
}
pub inline fn BN_GF2m_cmp(a: anytype, b: anytype) @TypeOf(BN_ucmp(a, b)) {
    _ = &a;
    _ = &b;
    return BN_ucmp(a, b);
}
pub const get_rfc2409_prime_768 = BN_get_rfc2409_prime_768;
pub const get_rfc2409_prime_1024 = BN_get_rfc2409_prime_1024;
pub const get_rfc3526_prime_1536 = BN_get_rfc3526_prime_1536;
pub const get_rfc3526_prime_2048 = BN_get_rfc3526_prime_2048;
pub const get_rfc3526_prime_3072 = BN_get_rfc3526_prime_3072;
pub const get_rfc3526_prime_4096 = BN_get_rfc3526_prime_4096;
pub const get_rfc3526_prime_6144 = BN_get_rfc3526_prime_6144;
pub const get_rfc3526_prime_8192 = BN_get_rfc3526_prime_8192;
pub const OSSL_PARAM_UNMODIFIED = @import("std").zig.c_translation.cast(usize, -@as(c_int, 1));
pub const OSSL_PARAM_END = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/openssl/params.h:24:10
pub const OSSL_PARAM_DEFN = @compileError("unable to translate C expr: unexpected token '{'");
// /usr/include/openssl/params.h:27:10
pub inline fn OSSL_PARAM_int(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_int))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_int));
}
pub inline fn OSSL_PARAM_uint(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_uint))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_uint));
}
pub inline fn OSSL_PARAM_long(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_long))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_long));
}
pub inline fn OSSL_PARAM_ulong(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_ulong))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(c_ulong));
}
pub inline fn OSSL_PARAM_int32(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(i32))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(i32));
}
pub inline fn OSSL_PARAM_uint32(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(u32))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(u32));
}
pub inline fn OSSL_PARAM_int64(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(i64))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(i64));
}
pub inline fn OSSL_PARAM_uint64(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(u64))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(u64));
}
pub inline fn OSSL_PARAM_size_t(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(usize))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, addr, @import("std").zig.c_translation.sizeof(usize));
}
pub inline fn OSSL_PARAM_time_t(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(time_t))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_INTEGER, addr, @import("std").zig.c_translation.sizeof(time_t));
}
pub inline fn OSSL_PARAM_double(key: anytype, addr: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_REAL, addr, @import("std").zig.c_translation.sizeof(f64))) {
    _ = &key;
    _ = &addr;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_REAL, addr, @import("std").zig.c_translation.sizeof(f64));
}
pub inline fn OSSL_PARAM_BN(key: anytype, bn: anytype, sz: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, bn, sz)) {
    _ = &key;
    _ = &bn;
    _ = &sz;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UNSIGNED_INTEGER, bn, sz);
}
pub inline fn OSSL_PARAM_utf8_string(key: anytype, addr: anytype, sz: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UTF8_STRING, addr, sz)) {
    _ = &key;
    _ = &addr;
    _ = &sz;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UTF8_STRING, addr, sz);
}
pub inline fn OSSL_PARAM_octet_string(key: anytype, addr: anytype, sz: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_OCTET_STRING, addr, sz)) {
    _ = &key;
    _ = &addr;
    _ = &sz;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_OCTET_STRING, addr, sz);
}
pub inline fn OSSL_PARAM_utf8_ptr(key: anytype, addr: anytype, sz: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_UTF8_PTR, addr, sz)) {
    _ = &key;
    _ = &addr;
    _ = &sz;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_UTF8_PTR, addr, sz);
}
pub inline fn OSSL_PARAM_octet_ptr(key: anytype, addr: anytype, sz: anytype) @TypeOf(OSSL_PARAM_DEFN(key, OSSL_PARAM_OCTET_PTR, addr, sz)) {
    _ = &key;
    _ = &addr;
    _ = &sz;
    return OSSL_PARAM_DEFN(key, OSSL_PARAM_OCTET_PTR, addr, sz);
}
pub const EVP_MAX_MD_SIZE = @as(c_int, 64);
pub const EVP_MAX_KEY_LENGTH = @as(c_int, 64);
pub const EVP_MAX_IV_LENGTH = @as(c_int, 16);
pub const EVP_MAX_BLOCK_LENGTH = @as(c_int, 32);
pub const PKCS5_SALT_LEN = @as(c_int, 8);
pub const PKCS5_DEFAULT_ITER = @as(c_int, 2048);
pub const OPENSSL_OBJECTS_H = "";
pub const HEADER_OBJECTS_H = "";
pub const OPENSSL_OBJ_MAC_H = "";
pub const SN_undef = "UNDEF";
pub const LN_undef = "undefined";
pub const NID_undef = @as(c_int, 0);
pub const OBJ_undef = @as(c_long, 0);
pub const SN_itu_t = "ITU-T";
pub const LN_itu_t = "itu-t";
pub const NID_itu_t = @as(c_int, 645);
pub const OBJ_itu_t = @as(c_long, 0);
pub const NID_ccitt = @as(c_int, 404);
pub const OBJ_ccitt = OBJ_itu_t;
pub const SN_iso = "ISO";
pub const LN_iso = "iso";
pub const NID_iso = @as(c_int, 181);
pub const OBJ_iso = @as(c_long, 1);
pub const SN_joint_iso_itu_t = "JOINT-ISO-ITU-T";
pub const LN_joint_iso_itu_t = "joint-iso-itu-t";
pub const NID_joint_iso_itu_t = @as(c_int, 646);
pub const OBJ_joint_iso_itu_t = @as(c_long, 2);
pub const NID_joint_iso_ccitt = @as(c_int, 393);
pub const OBJ_joint_iso_ccitt = OBJ_joint_iso_itu_t;
pub const SN_member_body = "member-body";
pub const LN_member_body = "ISO Member Body";
pub const NID_member_body = @as(c_int, 182);
pub const OBJ_member_body = blk: {
    _ = &OBJ_iso;
    break :blk @as(c_long, 2);
};
pub const SN_identified_organization = "identified-organization";
pub const NID_identified_organization = @as(c_int, 676);
pub const OBJ_identified_organization = blk: {
    _ = &OBJ_iso;
    break :blk @as(c_long, 3);
};
pub const SN_gmac = "GMAC";
pub const LN_gmac = "gmac";
pub const NID_gmac = @as(c_int, 1195);
pub const OBJ_gmac = blk: {
    _ = &OBJ_iso;
    _ = @as(c_long, 0);
    _ = @as(c_long, 9797);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 4);
};
pub const SN_hmac_md5 = "HMAC-MD5";
pub const LN_hmac_md5 = "hmac-md5";
pub const NID_hmac_md5 = @as(c_int, 780);
pub const OBJ_hmac_md5 = blk: {
    _ = &OBJ_identified_organization;
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 5);
    _ = @as(c_long, 5);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_hmac_sha1 = "HMAC-SHA1";
pub const LN_hmac_sha1 = "hmac-sha1";
pub const NID_hmac_sha1 = @as(c_int, 781);
pub const OBJ_hmac_sha1 = blk: {
    _ = &OBJ_identified_organization;
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 5);
    _ = @as(c_long, 5);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_x509ExtAdmission = "x509ExtAdmission";
pub const LN_x509ExtAdmission = "Professional Information or basis for Admission";
pub const NID_x509ExtAdmission = @as(c_int, 1093);
pub const OBJ_x509ExtAdmission = blk: {
    _ = &OBJ_identified_organization;
    _ = @as(c_long, 36);
    _ = @as(c_long, 8);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 3);
};
pub const SN_certicom_arc = "certicom-arc";
pub const NID_certicom_arc = @as(c_int, 677);
pub const OBJ_certicom_arc = blk: {
    _ = &OBJ_identified_organization;
    break :blk @as(c_long, 132);
};
pub const SN_ieee = "ieee";
pub const NID_ieee = @as(c_int, 1170);
pub const OBJ_ieee = blk: {
    _ = &OBJ_identified_organization;
    break :blk @as(c_long, 111);
};
pub const SN_ieee_siswg = "ieee-siswg";
pub const LN_ieee_siswg = "IEEE Security in Storage Working Group";
pub const NID_ieee_siswg = @as(c_int, 1171);
pub const OBJ_ieee_siswg = blk: {
    _ = &OBJ_ieee;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 1619);
};
pub const SN_international_organizations = "international-organizations";
pub const LN_international_organizations = "International Organizations";
pub const NID_international_organizations = @as(c_int, 647);
pub const OBJ_international_organizations = blk: {
    _ = &OBJ_joint_iso_itu_t;
    break :blk @as(c_long, 23);
};
pub const SN_wap = "wap";
pub const NID_wap = @as(c_int, 678);
pub const OBJ_wap = blk: {
    _ = &OBJ_international_organizations;
    break :blk @as(c_long, 43);
};
pub const SN_wap_wsg = "wap-wsg";
pub const NID_wap_wsg = @as(c_int, 679);
pub const OBJ_wap_wsg = blk: {
    _ = &OBJ_wap;
    break :blk @as(c_long, 1);
};
pub const SN_selected_attribute_types = "selected-attribute-types";
pub const LN_selected_attribute_types = "Selected Attribute Types";
pub const NID_selected_attribute_types = @as(c_int, 394);
pub const OBJ_selected_attribute_types = blk: {
    _ = &OBJ_joint_iso_itu_t;
    _ = @as(c_long, 5);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 5);
};
pub const SN_clearance = "clearance";
pub const NID_clearance = @as(c_int, 395);
pub const OBJ_clearance = blk: {
    _ = &OBJ_selected_attribute_types;
    break :blk @as(c_long, 55);
};
pub const SN_ISO_US = "ISO-US";
pub const LN_ISO_US = "ISO US Member Body";
pub const NID_ISO_US = @as(c_int, 183);
pub const OBJ_ISO_US = blk: {
    _ = &OBJ_member_body;
    break :blk @as(c_long, 840);
};
pub const SN_X9_57 = "X9-57";
pub const LN_X9_57 = "X9.57";
pub const NID_X9_57 = @as(c_int, 184);
pub const OBJ_X9_57 = blk: {
    _ = &OBJ_ISO_US;
    break :blk @as(c_long, 10040);
};
pub const SN_X9cm = "X9cm";
pub const LN_X9cm = "X9.57 CM ?";
pub const NID_X9cm = @as(c_int, 185);
pub const OBJ_X9cm = blk: {
    _ = &OBJ_X9_57;
    break :blk @as(c_long, 4);
};
pub const SN_ISO_CN = "ISO-CN";
pub const LN_ISO_CN = "ISO CN Member Body";
pub const NID_ISO_CN = @as(c_int, 1140);
pub const OBJ_ISO_CN = blk: {
    _ = &OBJ_member_body;
    break :blk @as(c_long, 156);
};
pub const SN_oscca = "oscca";
pub const NID_oscca = @as(c_int, 1141);
pub const OBJ_oscca = blk: {
    _ = &OBJ_ISO_CN;
    break :blk @as(c_long, 10197);
};
pub const SN_sm_scheme = "sm-scheme";
pub const NID_sm_scheme = @as(c_int, 1142);
pub const OBJ_sm_scheme = blk: {
    _ = &OBJ_oscca;
    break :blk @as(c_long, 1);
};
pub const SN_dsa = "DSA";
pub const LN_dsa = "dsaEncryption";
pub const NID_dsa = @as(c_int, 116);
pub const OBJ_dsa = blk: {
    _ = &OBJ_X9cm;
    break :blk @as(c_long, 1);
};
pub const SN_dsaWithSHA1 = "DSA-SHA1";
pub const LN_dsaWithSHA1 = "dsaWithSHA1";
pub const NID_dsaWithSHA1 = @as(c_int, 113);
pub const OBJ_dsaWithSHA1 = blk: {
    _ = &OBJ_X9cm;
    break :blk @as(c_long, 3);
};
pub const SN_ansi_X9_62 = "ansi-X9-62";
pub const LN_ansi_X9_62 = "ANSI X9.62";
pub const NID_ansi_X9_62 = @as(c_int, 405);
pub const OBJ_ansi_X9_62 = blk: {
    _ = &OBJ_ISO_US;
    break :blk @as(c_long, 10045);
};
pub const OBJ_X9_62_id_fieldType = blk: {
    _ = &OBJ_ansi_X9_62;
    break :blk @as(c_long, 1);
};
pub const SN_X9_62_prime_field = "prime-field";
pub const NID_X9_62_prime_field = @as(c_int, 406);
pub const OBJ_X9_62_prime_field = blk: {
    _ = &OBJ_X9_62_id_fieldType;
    break :blk @as(c_long, 1);
};
pub const SN_X9_62_characteristic_two_field = "characteristic-two-field";
pub const NID_X9_62_characteristic_two_field = @as(c_int, 407);
pub const OBJ_X9_62_characteristic_two_field = blk: {
    _ = &OBJ_X9_62_id_fieldType;
    break :blk @as(c_long, 2);
};
pub const SN_X9_62_id_characteristic_two_basis = "id-characteristic-two-basis";
pub const NID_X9_62_id_characteristic_two_basis = @as(c_int, 680);
pub const OBJ_X9_62_id_characteristic_two_basis = blk: {
    _ = &OBJ_X9_62_characteristic_two_field;
    break :blk @as(c_long, 3);
};
pub const SN_X9_62_onBasis = "onBasis";
pub const NID_X9_62_onBasis = @as(c_int, 681);
pub const OBJ_X9_62_onBasis = blk: {
    _ = &OBJ_X9_62_id_characteristic_two_basis;
    break :blk @as(c_long, 1);
};
pub const SN_X9_62_tpBasis = "tpBasis";
pub const NID_X9_62_tpBasis = @as(c_int, 682);
pub const OBJ_X9_62_tpBasis = blk: {
    _ = &OBJ_X9_62_id_characteristic_two_basis;
    break :blk @as(c_long, 2);
};
pub const SN_X9_62_ppBasis = "ppBasis";
pub const NID_X9_62_ppBasis = @as(c_int, 683);
pub const OBJ_X9_62_ppBasis = blk: {
    _ = &OBJ_X9_62_id_characteristic_two_basis;
    break :blk @as(c_long, 3);
};
pub const OBJ_X9_62_id_publicKeyType = blk: {
    _ = &OBJ_ansi_X9_62;
    break :blk @as(c_long, 2);
};
pub const SN_X9_62_id_ecPublicKey = "id-ecPublicKey";
pub const NID_X9_62_id_ecPublicKey = @as(c_int, 408);
pub const OBJ_X9_62_id_ecPublicKey = blk: {
    _ = &OBJ_X9_62_id_publicKeyType;
    break :blk @as(c_long, 1);
};
pub const OBJ_X9_62_ellipticCurve = blk: {
    _ = &OBJ_ansi_X9_62;
    break :blk @as(c_long, 3);
};
pub const OBJ_X9_62_c_TwoCurve = blk: {
    _ = &OBJ_X9_62_ellipticCurve;
    break :blk @as(c_long, 0);
};
pub const SN_X9_62_c2pnb163v1 = "c2pnb163v1";
pub const NID_X9_62_c2pnb163v1 = @as(c_int, 684);
pub const OBJ_X9_62_c2pnb163v1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 1);
};
pub const SN_X9_62_c2pnb163v2 = "c2pnb163v2";
pub const NID_X9_62_c2pnb163v2 = @as(c_int, 685);
pub const OBJ_X9_62_c2pnb163v2 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 2);
};
pub const SN_X9_62_c2pnb163v3 = "c2pnb163v3";
pub const NID_X9_62_c2pnb163v3 = @as(c_int, 686);
pub const OBJ_X9_62_c2pnb163v3 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 3);
};
pub const SN_X9_62_c2pnb176v1 = "c2pnb176v1";
pub const NID_X9_62_c2pnb176v1 = @as(c_int, 687);
pub const OBJ_X9_62_c2pnb176v1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 4);
};
pub const SN_X9_62_c2tnb191v1 = "c2tnb191v1";
pub const NID_X9_62_c2tnb191v1 = @as(c_int, 688);
pub const OBJ_X9_62_c2tnb191v1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 5);
};
pub const SN_X9_62_c2tnb191v2 = "c2tnb191v2";
pub const NID_X9_62_c2tnb191v2 = @as(c_int, 689);
pub const OBJ_X9_62_c2tnb191v2 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 6);
};
pub const SN_X9_62_c2tnb191v3 = "c2tnb191v3";
pub const NID_X9_62_c2tnb191v3 = @as(c_int, 690);
pub const OBJ_X9_62_c2tnb191v3 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 7);
};
pub const SN_X9_62_c2onb191v4 = "c2onb191v4";
pub const NID_X9_62_c2onb191v4 = @as(c_int, 691);
pub const OBJ_X9_62_c2onb191v4 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 8);
};
pub const SN_X9_62_c2onb191v5 = "c2onb191v5";
pub const NID_X9_62_c2onb191v5 = @as(c_int, 692);
pub const OBJ_X9_62_c2onb191v5 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 9);
};
pub const SN_X9_62_c2pnb208w1 = "c2pnb208w1";
pub const NID_X9_62_c2pnb208w1 = @as(c_int, 693);
pub const OBJ_X9_62_c2pnb208w1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 10);
};
pub const SN_X9_62_c2tnb239v1 = "c2tnb239v1";
pub const NID_X9_62_c2tnb239v1 = @as(c_int, 694);
pub const OBJ_X9_62_c2tnb239v1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 11);
};
pub const SN_X9_62_c2tnb239v2 = "c2tnb239v2";
pub const NID_X9_62_c2tnb239v2 = @as(c_int, 695);
pub const OBJ_X9_62_c2tnb239v2 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 12);
};
pub const SN_X9_62_c2tnb239v3 = "c2tnb239v3";
pub const NID_X9_62_c2tnb239v3 = @as(c_int, 696);
pub const OBJ_X9_62_c2tnb239v3 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 13);
};
pub const SN_X9_62_c2onb239v4 = "c2onb239v4";
pub const NID_X9_62_c2onb239v4 = @as(c_int, 697);
pub const OBJ_X9_62_c2onb239v4 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 14);
};
pub const SN_X9_62_c2onb239v5 = "c2onb239v5";
pub const NID_X9_62_c2onb239v5 = @as(c_int, 698);
pub const OBJ_X9_62_c2onb239v5 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 15);
};
pub const SN_X9_62_c2pnb272w1 = "c2pnb272w1";
pub const NID_X9_62_c2pnb272w1 = @as(c_int, 699);
pub const OBJ_X9_62_c2pnb272w1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 16);
};
pub const SN_X9_62_c2pnb304w1 = "c2pnb304w1";
pub const NID_X9_62_c2pnb304w1 = @as(c_int, 700);
pub const OBJ_X9_62_c2pnb304w1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 17);
};
pub const SN_X9_62_c2tnb359v1 = "c2tnb359v1";
pub const NID_X9_62_c2tnb359v1 = @as(c_int, 701);
pub const OBJ_X9_62_c2tnb359v1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 18);
};
pub const SN_X9_62_c2pnb368w1 = "c2pnb368w1";
pub const NID_X9_62_c2pnb368w1 = @as(c_int, 702);
pub const OBJ_X9_62_c2pnb368w1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 19);
};
pub const SN_X9_62_c2tnb431r1 = "c2tnb431r1";
pub const NID_X9_62_c2tnb431r1 = @as(c_int, 703);
pub const OBJ_X9_62_c2tnb431r1 = blk: {
    _ = &OBJ_X9_62_c_TwoCurve;
    break :blk @as(c_long, 20);
};
pub const OBJ_X9_62_primeCurve = blk: {
    _ = &OBJ_X9_62_ellipticCurve;
    break :blk @as(c_long, 1);
};
pub const SN_X9_62_prime192v1 = "prime192v1";
pub const NID_X9_62_prime192v1 = @as(c_int, 409);
pub const OBJ_X9_62_prime192v1 = blk: {
    _ = &OBJ_X9_62_primeCurve;
    break :blk @as(c_long, 1);
};
pub const SN_X9_62_prime192v2 = "prime192v2";
pub const NID_X9_62_prime192v2 = @as(c_int, 410);
pub const OBJ_X9_62_prime192v2 = blk: {
    _ = &OBJ_X9_62_primeCurve;
    break :blk @as(c_long, 2);
};
pub const SN_X9_62_prime192v3 = "prime192v3";
pub const NID_X9_62_prime192v3 = @as(c_int, 411);
pub const OBJ_X9_62_prime192v3 = blk: {
    _ = &OBJ_X9_62_primeCurve;
    break :blk @as(c_long, 3);
};
pub const SN_X9_62_prime239v1 = "prime239v1";
pub const NID_X9_62_prime239v1 = @as(c_int, 412);
pub const OBJ_X9_62_prime239v1 = blk: {
    _ = &OBJ_X9_62_primeCurve;
    break :blk @as(c_long, 4);
};
pub const SN_X9_62_prime239v2 = "prime239v2";
pub const NID_X9_62_prime239v2 = @as(c_int, 413);
pub const OBJ_X9_62_prime239v2 = blk: {
    _ = &OBJ_X9_62_primeCurve;
    break :blk @as(c_long, 5);
};
pub const SN_X9_62_prime239v3 = "prime239v3";
pub const NID_X9_62_prime239v3 = @as(c_int, 414);
pub const OBJ_X9_62_prime239v3 = blk: {
    _ = &OBJ_X9_62_primeCurve;
    break :blk @as(c_long, 6);
};
pub const SN_X9_62_prime256v1 = "prime256v1";
pub const NID_X9_62_prime256v1 = @as(c_int, 415);
pub const OBJ_X9_62_prime256v1 = blk: {
    _ = &OBJ_X9_62_primeCurve;
    break :blk @as(c_long, 7);
};
pub const OBJ_X9_62_id_ecSigType = blk: {
    _ = &OBJ_ansi_X9_62;
    break :blk @as(c_long, 4);
};
pub const SN_ecdsa_with_SHA1 = "ecdsa-with-SHA1";
pub const NID_ecdsa_with_SHA1 = @as(c_int, 416);
pub const OBJ_ecdsa_with_SHA1 = blk: {
    _ = &OBJ_X9_62_id_ecSigType;
    break :blk @as(c_long, 1);
};
pub const SN_ecdsa_with_Recommended = "ecdsa-with-Recommended";
pub const NID_ecdsa_with_Recommended = @as(c_int, 791);
pub const OBJ_ecdsa_with_Recommended = blk: {
    _ = &OBJ_X9_62_id_ecSigType;
    break :blk @as(c_long, 2);
};
pub const SN_ecdsa_with_Specified = "ecdsa-with-Specified";
pub const NID_ecdsa_with_Specified = @as(c_int, 792);
pub const OBJ_ecdsa_with_Specified = blk: {
    _ = &OBJ_X9_62_id_ecSigType;
    break :blk @as(c_long, 3);
};
pub const SN_ecdsa_with_SHA224 = "ecdsa-with-SHA224";
pub const NID_ecdsa_with_SHA224 = @as(c_int, 793);
pub const OBJ_ecdsa_with_SHA224 = blk: {
    _ = &OBJ_ecdsa_with_Specified;
    break :blk @as(c_long, 1);
};
pub const SN_ecdsa_with_SHA256 = "ecdsa-with-SHA256";
pub const NID_ecdsa_with_SHA256 = @as(c_int, 794);
pub const OBJ_ecdsa_with_SHA256 = blk: {
    _ = &OBJ_ecdsa_with_Specified;
    break :blk @as(c_long, 2);
};
pub const SN_ecdsa_with_SHA384 = "ecdsa-with-SHA384";
pub const NID_ecdsa_with_SHA384 = @as(c_int, 795);
pub const OBJ_ecdsa_with_SHA384 = blk: {
    _ = &OBJ_ecdsa_with_Specified;
    break :blk @as(c_long, 3);
};
pub const SN_ecdsa_with_SHA512 = "ecdsa-with-SHA512";
pub const NID_ecdsa_with_SHA512 = @as(c_int, 796);
pub const OBJ_ecdsa_with_SHA512 = blk: {
    _ = &OBJ_ecdsa_with_Specified;
    break :blk @as(c_long, 4);
};
pub const OBJ_secg_ellipticCurve = blk: {
    _ = &OBJ_certicom_arc;
    break :blk @as(c_long, 0);
};
pub const SN_secp112r1 = "secp112r1";
pub const NID_secp112r1 = @as(c_int, 704);
pub const OBJ_secp112r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 6);
};
pub const SN_secp112r2 = "secp112r2";
pub const NID_secp112r2 = @as(c_int, 705);
pub const OBJ_secp112r2 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 7);
};
pub const SN_secp128r1 = "secp128r1";
pub const NID_secp128r1 = @as(c_int, 706);
pub const OBJ_secp128r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 28);
};
pub const SN_secp128r2 = "secp128r2";
pub const NID_secp128r2 = @as(c_int, 707);
pub const OBJ_secp128r2 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 29);
};
pub const SN_secp160k1 = "secp160k1";
pub const NID_secp160k1 = @as(c_int, 708);
pub const OBJ_secp160k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 9);
};
pub const SN_secp160r1 = "secp160r1";
pub const NID_secp160r1 = @as(c_int, 709);
pub const OBJ_secp160r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 8);
};
pub const SN_secp160r2 = "secp160r2";
pub const NID_secp160r2 = @as(c_int, 710);
pub const OBJ_secp160r2 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 30);
};
pub const SN_secp192k1 = "secp192k1";
pub const NID_secp192k1 = @as(c_int, 711);
pub const OBJ_secp192k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 31);
};
pub const SN_secp224k1 = "secp224k1";
pub const NID_secp224k1 = @as(c_int, 712);
pub const OBJ_secp224k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 32);
};
pub const SN_secp224r1 = "secp224r1";
pub const NID_secp224r1 = @as(c_int, 713);
pub const OBJ_secp224r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 33);
};
pub const SN_secp256k1 = "secp256k1";
pub const NID_secp256k1 = @as(c_int, 714);
pub const OBJ_secp256k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 10);
};
pub const SN_secp384r1 = "secp384r1";
pub const NID_secp384r1 = @as(c_int, 715);
pub const OBJ_secp384r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 34);
};
pub const SN_secp521r1 = "secp521r1";
pub const NID_secp521r1 = @as(c_int, 716);
pub const OBJ_secp521r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 35);
};
pub const SN_sect113r1 = "sect113r1";
pub const NID_sect113r1 = @as(c_int, 717);
pub const OBJ_sect113r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 4);
};
pub const SN_sect113r2 = "sect113r2";
pub const NID_sect113r2 = @as(c_int, 718);
pub const OBJ_sect113r2 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 5);
};
pub const SN_sect131r1 = "sect131r1";
pub const NID_sect131r1 = @as(c_int, 719);
pub const OBJ_sect131r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 22);
};
pub const SN_sect131r2 = "sect131r2";
pub const NID_sect131r2 = @as(c_int, 720);
pub const OBJ_sect131r2 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 23);
};
pub const SN_sect163k1 = "sect163k1";
pub const NID_sect163k1 = @as(c_int, 721);
pub const OBJ_sect163k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 1);
};
pub const SN_sect163r1 = "sect163r1";
pub const NID_sect163r1 = @as(c_int, 722);
pub const OBJ_sect163r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 2);
};
pub const SN_sect163r2 = "sect163r2";
pub const NID_sect163r2 = @as(c_int, 723);
pub const OBJ_sect163r2 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 15);
};
pub const SN_sect193r1 = "sect193r1";
pub const NID_sect193r1 = @as(c_int, 724);
pub const OBJ_sect193r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 24);
};
pub const SN_sect193r2 = "sect193r2";
pub const NID_sect193r2 = @as(c_int, 725);
pub const OBJ_sect193r2 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 25);
};
pub const SN_sect233k1 = "sect233k1";
pub const NID_sect233k1 = @as(c_int, 726);
pub const OBJ_sect233k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 26);
};
pub const SN_sect233r1 = "sect233r1";
pub const NID_sect233r1 = @as(c_int, 727);
pub const OBJ_sect233r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 27);
};
pub const SN_sect239k1 = "sect239k1";
pub const NID_sect239k1 = @as(c_int, 728);
pub const OBJ_sect239k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 3);
};
pub const SN_sect283k1 = "sect283k1";
pub const NID_sect283k1 = @as(c_int, 729);
pub const OBJ_sect283k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 16);
};
pub const SN_sect283r1 = "sect283r1";
pub const NID_sect283r1 = @as(c_int, 730);
pub const OBJ_sect283r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 17);
};
pub const SN_sect409k1 = "sect409k1";
pub const NID_sect409k1 = @as(c_int, 731);
pub const OBJ_sect409k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 36);
};
pub const SN_sect409r1 = "sect409r1";
pub const NID_sect409r1 = @as(c_int, 732);
pub const OBJ_sect409r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 37);
};
pub const SN_sect571k1 = "sect571k1";
pub const NID_sect571k1 = @as(c_int, 733);
pub const OBJ_sect571k1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 38);
};
pub const SN_sect571r1 = "sect571r1";
pub const NID_sect571r1 = @as(c_int, 734);
pub const OBJ_sect571r1 = blk: {
    _ = &OBJ_secg_ellipticCurve;
    break :blk @as(c_long, 39);
};
pub const OBJ_wap_wsg_idm_ecid = blk: {
    _ = &OBJ_wap_wsg;
    break :blk @as(c_long, 4);
};
pub const SN_wap_wsg_idm_ecid_wtls1 = "wap-wsg-idm-ecid-wtls1";
pub const NID_wap_wsg_idm_ecid_wtls1 = @as(c_int, 735);
pub const OBJ_wap_wsg_idm_ecid_wtls1 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 1);
};
pub const SN_wap_wsg_idm_ecid_wtls3 = "wap-wsg-idm-ecid-wtls3";
pub const NID_wap_wsg_idm_ecid_wtls3 = @as(c_int, 736);
pub const OBJ_wap_wsg_idm_ecid_wtls3 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 3);
};
pub const SN_wap_wsg_idm_ecid_wtls4 = "wap-wsg-idm-ecid-wtls4";
pub const NID_wap_wsg_idm_ecid_wtls4 = @as(c_int, 737);
pub const OBJ_wap_wsg_idm_ecid_wtls4 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 4);
};
pub const SN_wap_wsg_idm_ecid_wtls5 = "wap-wsg-idm-ecid-wtls5";
pub const NID_wap_wsg_idm_ecid_wtls5 = @as(c_int, 738);
pub const OBJ_wap_wsg_idm_ecid_wtls5 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 5);
};
pub const SN_wap_wsg_idm_ecid_wtls6 = "wap-wsg-idm-ecid-wtls6";
pub const NID_wap_wsg_idm_ecid_wtls6 = @as(c_int, 739);
pub const OBJ_wap_wsg_idm_ecid_wtls6 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 6);
};
pub const SN_wap_wsg_idm_ecid_wtls7 = "wap-wsg-idm-ecid-wtls7";
pub const NID_wap_wsg_idm_ecid_wtls7 = @as(c_int, 740);
pub const OBJ_wap_wsg_idm_ecid_wtls7 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 7);
};
pub const SN_wap_wsg_idm_ecid_wtls8 = "wap-wsg-idm-ecid-wtls8";
pub const NID_wap_wsg_idm_ecid_wtls8 = @as(c_int, 741);
pub const OBJ_wap_wsg_idm_ecid_wtls8 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 8);
};
pub const SN_wap_wsg_idm_ecid_wtls9 = "wap-wsg-idm-ecid-wtls9";
pub const NID_wap_wsg_idm_ecid_wtls9 = @as(c_int, 742);
pub const OBJ_wap_wsg_idm_ecid_wtls9 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 9);
};
pub const SN_wap_wsg_idm_ecid_wtls10 = "wap-wsg-idm-ecid-wtls10";
pub const NID_wap_wsg_idm_ecid_wtls10 = @as(c_int, 743);
pub const OBJ_wap_wsg_idm_ecid_wtls10 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 10);
};
pub const SN_wap_wsg_idm_ecid_wtls11 = "wap-wsg-idm-ecid-wtls11";
pub const NID_wap_wsg_idm_ecid_wtls11 = @as(c_int, 744);
pub const OBJ_wap_wsg_idm_ecid_wtls11 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 11);
};
pub const SN_wap_wsg_idm_ecid_wtls12 = "wap-wsg-idm-ecid-wtls12";
pub const NID_wap_wsg_idm_ecid_wtls12 = @as(c_int, 745);
pub const OBJ_wap_wsg_idm_ecid_wtls12 = blk: {
    _ = &OBJ_wap_wsg_idm_ecid;
    break :blk @as(c_long, 12);
};
pub const SN_cast5_cbc = "CAST5-CBC";
pub const LN_cast5_cbc = "cast5-cbc";
pub const NID_cast5_cbc = @as(c_int, 108);
pub const OBJ_cast5_cbc = blk: {
    _ = &OBJ_ISO_US;
    _ = @as(c_long, 113533);
    _ = @as(c_long, 7);
    _ = @as(c_long, 66);
    break :blk @as(c_long, 10);
};
pub const SN_cast5_ecb = "CAST5-ECB";
pub const LN_cast5_ecb = "cast5-ecb";
pub const NID_cast5_ecb = @as(c_int, 109);
pub const SN_cast5_cfb64 = "CAST5-CFB";
pub const LN_cast5_cfb64 = "cast5-cfb";
pub const NID_cast5_cfb64 = @as(c_int, 110);
pub const SN_cast5_ofb64 = "CAST5-OFB";
pub const LN_cast5_ofb64 = "cast5-ofb";
pub const NID_cast5_ofb64 = @as(c_int, 111);
pub const LN_pbeWithMD5AndCast5_CBC = "pbeWithMD5AndCast5CBC";
pub const NID_pbeWithMD5AndCast5_CBC = @as(c_int, 112);
pub const OBJ_pbeWithMD5AndCast5_CBC = blk: {
    _ = &OBJ_ISO_US;
    _ = @as(c_long, 113533);
    _ = @as(c_long, 7);
    _ = @as(c_long, 66);
    break :blk @as(c_long, 12);
};
pub const SN_id_PasswordBasedMAC = "id-PasswordBasedMAC";
pub const LN_id_PasswordBasedMAC = "password based MAC";
pub const NID_id_PasswordBasedMAC = @as(c_int, 782);
pub const OBJ_id_PasswordBasedMAC = blk: {
    _ = &OBJ_ISO_US;
    _ = @as(c_long, 113533);
    _ = @as(c_long, 7);
    _ = @as(c_long, 66);
    break :blk @as(c_long, 13);
};
pub const SN_id_DHBasedMac = "id-DHBasedMac";
pub const LN_id_DHBasedMac = "Diffie-Hellman based MAC";
pub const NID_id_DHBasedMac = @as(c_int, 783);
pub const OBJ_id_DHBasedMac = blk: {
    _ = &OBJ_ISO_US;
    _ = @as(c_long, 113533);
    _ = @as(c_long, 7);
    _ = @as(c_long, 66);
    break :blk @as(c_long, 30);
};
pub const SN_rsadsi = "rsadsi";
pub const LN_rsadsi = "RSA Data Security, Inc.";
pub const NID_rsadsi = @as(c_int, 1);
pub const OBJ_rsadsi = blk: {
    _ = &OBJ_ISO_US;
    break :blk @as(c_long, 113549);
};
pub const SN_pkcs = "pkcs";
pub const LN_pkcs = "RSA Data Security, Inc. PKCS";
pub const NID_pkcs = @as(c_int, 2);
pub const OBJ_pkcs = blk: {
    _ = &OBJ_rsadsi;
    break :blk @as(c_long, 1);
};
pub const SN_pkcs1 = "pkcs1";
pub const NID_pkcs1 = @as(c_int, 186);
pub const OBJ_pkcs1 = blk: {
    _ = &OBJ_pkcs;
    break :blk @as(c_long, 1);
};
pub const LN_rsaEncryption = "rsaEncryption";
pub const NID_rsaEncryption = @as(c_int, 6);
pub const OBJ_rsaEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 1);
};
pub const SN_md2WithRSAEncryption = "RSA-MD2";
pub const LN_md2WithRSAEncryption = "md2WithRSAEncryption";
pub const NID_md2WithRSAEncryption = @as(c_int, 7);
pub const OBJ_md2WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 2);
};
pub const SN_md4WithRSAEncryption = "RSA-MD4";
pub const LN_md4WithRSAEncryption = "md4WithRSAEncryption";
pub const NID_md4WithRSAEncryption = @as(c_int, 396);
pub const OBJ_md4WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 3);
};
pub const SN_md5WithRSAEncryption = "RSA-MD5";
pub const LN_md5WithRSAEncryption = "md5WithRSAEncryption";
pub const NID_md5WithRSAEncryption = @as(c_int, 8);
pub const OBJ_md5WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 4);
};
pub const SN_sha1WithRSAEncryption = "RSA-SHA1";
pub const LN_sha1WithRSAEncryption = "sha1WithRSAEncryption";
pub const NID_sha1WithRSAEncryption = @as(c_int, 65);
pub const OBJ_sha1WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 5);
};
pub const SN_rsaesOaep = "RSAES-OAEP";
pub const LN_rsaesOaep = "rsaesOaep";
pub const NID_rsaesOaep = @as(c_int, 919);
pub const OBJ_rsaesOaep = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 7);
};
pub const SN_mgf1 = "MGF1";
pub const LN_mgf1 = "mgf1";
pub const NID_mgf1 = @as(c_int, 911);
pub const OBJ_mgf1 = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 8);
};
pub const SN_pSpecified = "PSPECIFIED";
pub const LN_pSpecified = "pSpecified";
pub const NID_pSpecified = @as(c_int, 935);
pub const OBJ_pSpecified = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 9);
};
pub const SN_rsassaPss = "RSASSA-PSS";
pub const LN_rsassaPss = "rsassaPss";
pub const NID_rsassaPss = @as(c_int, 912);
pub const OBJ_rsassaPss = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 10);
};
pub const SN_sha256WithRSAEncryption = "RSA-SHA256";
pub const LN_sha256WithRSAEncryption = "sha256WithRSAEncryption";
pub const NID_sha256WithRSAEncryption = @as(c_int, 668);
pub const OBJ_sha256WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 11);
};
pub const SN_sha384WithRSAEncryption = "RSA-SHA384";
pub const LN_sha384WithRSAEncryption = "sha384WithRSAEncryption";
pub const NID_sha384WithRSAEncryption = @as(c_int, 669);
pub const OBJ_sha384WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 12);
};
pub const SN_sha512WithRSAEncryption = "RSA-SHA512";
pub const LN_sha512WithRSAEncryption = "sha512WithRSAEncryption";
pub const NID_sha512WithRSAEncryption = @as(c_int, 670);
pub const OBJ_sha512WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 13);
};
pub const SN_sha224WithRSAEncryption = "RSA-SHA224";
pub const LN_sha224WithRSAEncryption = "sha224WithRSAEncryption";
pub const NID_sha224WithRSAEncryption = @as(c_int, 671);
pub const OBJ_sha224WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 14);
};
pub const SN_sha512_224WithRSAEncryption = "RSA-SHA512/224";
pub const LN_sha512_224WithRSAEncryption = "sha512-224WithRSAEncryption";
pub const NID_sha512_224WithRSAEncryption = @as(c_int, 1145);
pub const OBJ_sha512_224WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 15);
};
pub const SN_sha512_256WithRSAEncryption = "RSA-SHA512/256";
pub const LN_sha512_256WithRSAEncryption = "sha512-256WithRSAEncryption";
pub const NID_sha512_256WithRSAEncryption = @as(c_int, 1146);
pub const OBJ_sha512_256WithRSAEncryption = blk: {
    _ = &OBJ_pkcs1;
    break :blk @as(c_long, 16);
};
pub const SN_pkcs3 = "pkcs3";
pub const NID_pkcs3 = @as(c_int, 27);
pub const OBJ_pkcs3 = blk: {
    _ = &OBJ_pkcs;
    break :blk @as(c_long, 3);
};
pub const LN_dhKeyAgreement = "dhKeyAgreement";
pub const NID_dhKeyAgreement = @as(c_int, 28);
pub const OBJ_dhKeyAgreement = blk: {
    _ = &OBJ_pkcs3;
    break :blk @as(c_long, 1);
};
pub const SN_pkcs5 = "pkcs5";
pub const NID_pkcs5 = @as(c_int, 187);
pub const OBJ_pkcs5 = blk: {
    _ = &OBJ_pkcs;
    break :blk @as(c_long, 5);
};
pub const SN_pbeWithMD2AndDES_CBC = "PBE-MD2-DES";
pub const LN_pbeWithMD2AndDES_CBC = "pbeWithMD2AndDES-CBC";
pub const NID_pbeWithMD2AndDES_CBC = @as(c_int, 9);
pub const OBJ_pbeWithMD2AndDES_CBC = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 1);
};
pub const SN_pbeWithMD5AndDES_CBC = "PBE-MD5-DES";
pub const LN_pbeWithMD5AndDES_CBC = "pbeWithMD5AndDES-CBC";
pub const NID_pbeWithMD5AndDES_CBC = @as(c_int, 10);
pub const OBJ_pbeWithMD5AndDES_CBC = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 3);
};
pub const SN_pbeWithMD2AndRC2_CBC = "PBE-MD2-RC2-64";
pub const LN_pbeWithMD2AndRC2_CBC = "pbeWithMD2AndRC2-CBC";
pub const NID_pbeWithMD2AndRC2_CBC = @as(c_int, 168);
pub const OBJ_pbeWithMD2AndRC2_CBC = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 4);
};
pub const SN_pbeWithMD5AndRC2_CBC = "PBE-MD5-RC2-64";
pub const LN_pbeWithMD5AndRC2_CBC = "pbeWithMD5AndRC2-CBC";
pub const NID_pbeWithMD5AndRC2_CBC = @as(c_int, 169);
pub const OBJ_pbeWithMD5AndRC2_CBC = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 6);
};
pub const SN_pbeWithSHA1AndDES_CBC = "PBE-SHA1-DES";
pub const LN_pbeWithSHA1AndDES_CBC = "pbeWithSHA1AndDES-CBC";
pub const NID_pbeWithSHA1AndDES_CBC = @as(c_int, 170);
pub const OBJ_pbeWithSHA1AndDES_CBC = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 10);
};
pub const SN_pbeWithSHA1AndRC2_CBC = "PBE-SHA1-RC2-64";
pub const LN_pbeWithSHA1AndRC2_CBC = "pbeWithSHA1AndRC2-CBC";
pub const NID_pbeWithSHA1AndRC2_CBC = @as(c_int, 68);
pub const OBJ_pbeWithSHA1AndRC2_CBC = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 11);
};
pub const LN_id_pbkdf2 = "PBKDF2";
pub const NID_id_pbkdf2 = @as(c_int, 69);
pub const OBJ_id_pbkdf2 = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 12);
};
pub const LN_pbes2 = "PBES2";
pub const NID_pbes2 = @as(c_int, 161);
pub const OBJ_pbes2 = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 13);
};
pub const LN_pbmac1 = "PBMAC1";
pub const NID_pbmac1 = @as(c_int, 162);
pub const OBJ_pbmac1 = blk: {
    _ = &OBJ_pkcs5;
    break :blk @as(c_long, 14);
};
pub const SN_pkcs7 = "pkcs7";
pub const NID_pkcs7 = @as(c_int, 20);
pub const OBJ_pkcs7 = blk: {
    _ = &OBJ_pkcs;
    break :blk @as(c_long, 7);
};
pub const LN_pkcs7_data = "pkcs7-data";
pub const NID_pkcs7_data = @as(c_int, 21);
pub const OBJ_pkcs7_data = blk: {
    _ = &OBJ_pkcs7;
    break :blk @as(c_long, 1);
};
pub const LN_pkcs7_signed = "pkcs7-signedData";
pub const NID_pkcs7_signed = @as(c_int, 22);
pub const OBJ_pkcs7_signed = blk: {
    _ = &OBJ_pkcs7;
    break :blk @as(c_long, 2);
};
pub const LN_pkcs7_enveloped = "pkcs7-envelopedData";
pub const NID_pkcs7_enveloped = @as(c_int, 23);
pub const OBJ_pkcs7_enveloped = blk: {
    _ = &OBJ_pkcs7;
    break :blk @as(c_long, 3);
};
pub const LN_pkcs7_signedAndEnveloped = "pkcs7-signedAndEnvelopedData";
pub const NID_pkcs7_signedAndEnveloped = @as(c_int, 24);
pub const OBJ_pkcs7_signedAndEnveloped = blk: {
    _ = &OBJ_pkcs7;
    break :blk @as(c_long, 4);
};
pub const LN_pkcs7_digest = "pkcs7-digestData";
pub const NID_pkcs7_digest = @as(c_int, 25);
pub const OBJ_pkcs7_digest = blk: {
    _ = &OBJ_pkcs7;
    break :blk @as(c_long, 5);
};
pub const LN_pkcs7_encrypted = "pkcs7-encryptedData";
pub const NID_pkcs7_encrypted = @as(c_int, 26);
pub const OBJ_pkcs7_encrypted = blk: {
    _ = &OBJ_pkcs7;
    break :blk @as(c_long, 6);
};
pub const SN_pkcs9 = "pkcs9";
pub const NID_pkcs9 = @as(c_int, 47);
pub const OBJ_pkcs9 = blk: {
    _ = &OBJ_pkcs;
    break :blk @as(c_long, 9);
};
pub const LN_pkcs9_emailAddress = "emailAddress";
pub const NID_pkcs9_emailAddress = @as(c_int, 48);
pub const OBJ_pkcs9_emailAddress = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 1);
};
pub const LN_pkcs9_unstructuredName = "unstructuredName";
pub const NID_pkcs9_unstructuredName = @as(c_int, 49);
pub const OBJ_pkcs9_unstructuredName = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 2);
};
pub const LN_pkcs9_contentType = "contentType";
pub const NID_pkcs9_contentType = @as(c_int, 50);
pub const OBJ_pkcs9_contentType = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 3);
};
pub const LN_pkcs9_messageDigest = "messageDigest";
pub const NID_pkcs9_messageDigest = @as(c_int, 51);
pub const OBJ_pkcs9_messageDigest = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 4);
};
pub const LN_pkcs9_signingTime = "signingTime";
pub const NID_pkcs9_signingTime = @as(c_int, 52);
pub const OBJ_pkcs9_signingTime = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 5);
};
pub const LN_pkcs9_countersignature = "countersignature";
pub const NID_pkcs9_countersignature = @as(c_int, 53);
pub const OBJ_pkcs9_countersignature = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 6);
};
pub const LN_pkcs9_challengePassword = "challengePassword";
pub const NID_pkcs9_challengePassword = @as(c_int, 54);
pub const OBJ_pkcs9_challengePassword = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 7);
};
pub const LN_pkcs9_unstructuredAddress = "unstructuredAddress";
pub const NID_pkcs9_unstructuredAddress = @as(c_int, 55);
pub const OBJ_pkcs9_unstructuredAddress = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 8);
};
pub const LN_pkcs9_extCertAttributes = "extendedCertificateAttributes";
pub const NID_pkcs9_extCertAttributes = @as(c_int, 56);
pub const OBJ_pkcs9_extCertAttributes = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 9);
};
pub const SN_ext_req = "extReq";
pub const LN_ext_req = "Extension Request";
pub const NID_ext_req = @as(c_int, 172);
pub const OBJ_ext_req = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 14);
};
pub const SN_SMIMECapabilities = "SMIME-CAPS";
pub const LN_SMIMECapabilities = "S/MIME Capabilities";
pub const NID_SMIMECapabilities = @as(c_int, 167);
pub const OBJ_SMIMECapabilities = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 15);
};
pub const SN_SMIME = "SMIME";
pub const LN_SMIME = "S/MIME";
pub const NID_SMIME = @as(c_int, 188);
pub const OBJ_SMIME = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 16);
};
pub const SN_id_smime_mod = "id-smime-mod";
pub const NID_id_smime_mod = @as(c_int, 189);
pub const OBJ_id_smime_mod = blk: {
    _ = &OBJ_SMIME;
    break :blk @as(c_long, 0);
};
pub const SN_id_smime_ct = "id-smime-ct";
pub const NID_id_smime_ct = @as(c_int, 190);
pub const OBJ_id_smime_ct = blk: {
    _ = &OBJ_SMIME;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_aa = "id-smime-aa";
pub const NID_id_smime_aa = @as(c_int, 191);
pub const OBJ_id_smime_aa = blk: {
    _ = &OBJ_SMIME;
    break :blk @as(c_long, 2);
};
pub const SN_id_smime_alg = "id-smime-alg";
pub const NID_id_smime_alg = @as(c_int, 192);
pub const OBJ_id_smime_alg = blk: {
    _ = &OBJ_SMIME;
    break :blk @as(c_long, 3);
};
pub const SN_id_smime_cd = "id-smime-cd";
pub const NID_id_smime_cd = @as(c_int, 193);
pub const OBJ_id_smime_cd = blk: {
    _ = &OBJ_SMIME;
    break :blk @as(c_long, 4);
};
pub const SN_id_smime_spq = "id-smime-spq";
pub const NID_id_smime_spq = @as(c_int, 194);
pub const OBJ_id_smime_spq = blk: {
    _ = &OBJ_SMIME;
    break :blk @as(c_long, 5);
};
pub const SN_id_smime_cti = "id-smime-cti";
pub const NID_id_smime_cti = @as(c_int, 195);
pub const OBJ_id_smime_cti = blk: {
    _ = &OBJ_SMIME;
    break :blk @as(c_long, 6);
};
pub const SN_id_smime_mod_cms = "id-smime-mod-cms";
pub const NID_id_smime_mod_cms = @as(c_int, 196);
pub const OBJ_id_smime_mod_cms = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_mod_ess = "id-smime-mod-ess";
pub const NID_id_smime_mod_ess = @as(c_int, 197);
pub const OBJ_id_smime_mod_ess = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 2);
};
pub const SN_id_smime_mod_oid = "id-smime-mod-oid";
pub const NID_id_smime_mod_oid = @as(c_int, 198);
pub const OBJ_id_smime_mod_oid = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 3);
};
pub const SN_id_smime_mod_msg_v3 = "id-smime-mod-msg-v3";
pub const NID_id_smime_mod_msg_v3 = @as(c_int, 199);
pub const OBJ_id_smime_mod_msg_v3 = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 4);
};
pub const SN_id_smime_mod_ets_eSignature_88 = "id-smime-mod-ets-eSignature-88";
pub const NID_id_smime_mod_ets_eSignature_88 = @as(c_int, 200);
pub const OBJ_id_smime_mod_ets_eSignature_88 = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 5);
};
pub const SN_id_smime_mod_ets_eSignature_97 = "id-smime-mod-ets-eSignature-97";
pub const NID_id_smime_mod_ets_eSignature_97 = @as(c_int, 201);
pub const OBJ_id_smime_mod_ets_eSignature_97 = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 6);
};
pub const SN_id_smime_mod_ets_eSigPolicy_88 = "id-smime-mod-ets-eSigPolicy-88";
pub const NID_id_smime_mod_ets_eSigPolicy_88 = @as(c_int, 202);
pub const OBJ_id_smime_mod_ets_eSigPolicy_88 = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 7);
};
pub const SN_id_smime_mod_ets_eSigPolicy_97 = "id-smime-mod-ets-eSigPolicy-97";
pub const NID_id_smime_mod_ets_eSigPolicy_97 = @as(c_int, 203);
pub const OBJ_id_smime_mod_ets_eSigPolicy_97 = blk: {
    _ = &OBJ_id_smime_mod;
    break :blk @as(c_long, 8);
};
pub const SN_id_smime_ct_receipt = "id-smime-ct-receipt";
pub const NID_id_smime_ct_receipt = @as(c_int, 204);
pub const OBJ_id_smime_ct_receipt = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_ct_authData = "id-smime-ct-authData";
pub const NID_id_smime_ct_authData = @as(c_int, 205);
pub const OBJ_id_smime_ct_authData = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 2);
};
pub const SN_id_smime_ct_publishCert = "id-smime-ct-publishCert";
pub const NID_id_smime_ct_publishCert = @as(c_int, 206);
pub const OBJ_id_smime_ct_publishCert = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 3);
};
pub const SN_id_smime_ct_TSTInfo = "id-smime-ct-TSTInfo";
pub const NID_id_smime_ct_TSTInfo = @as(c_int, 207);
pub const OBJ_id_smime_ct_TSTInfo = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 4);
};
pub const SN_id_smime_ct_TDTInfo = "id-smime-ct-TDTInfo";
pub const NID_id_smime_ct_TDTInfo = @as(c_int, 208);
pub const OBJ_id_smime_ct_TDTInfo = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 5);
};
pub const SN_id_smime_ct_contentInfo = "id-smime-ct-contentInfo";
pub const NID_id_smime_ct_contentInfo = @as(c_int, 209);
pub const OBJ_id_smime_ct_contentInfo = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 6);
};
pub const SN_id_smime_ct_DVCSRequestData = "id-smime-ct-DVCSRequestData";
pub const NID_id_smime_ct_DVCSRequestData = @as(c_int, 210);
pub const OBJ_id_smime_ct_DVCSRequestData = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 7);
};
pub const SN_id_smime_ct_DVCSResponseData = "id-smime-ct-DVCSResponseData";
pub const NID_id_smime_ct_DVCSResponseData = @as(c_int, 211);
pub const OBJ_id_smime_ct_DVCSResponseData = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 8);
};
pub const SN_id_smime_ct_compressedData = "id-smime-ct-compressedData";
pub const NID_id_smime_ct_compressedData = @as(c_int, 786);
pub const OBJ_id_smime_ct_compressedData = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 9);
};
pub const SN_id_smime_ct_contentCollection = "id-smime-ct-contentCollection";
pub const NID_id_smime_ct_contentCollection = @as(c_int, 1058);
pub const OBJ_id_smime_ct_contentCollection = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 19);
};
pub const SN_id_smime_ct_authEnvelopedData = "id-smime-ct-authEnvelopedData";
pub const NID_id_smime_ct_authEnvelopedData = @as(c_int, 1059);
pub const OBJ_id_smime_ct_authEnvelopedData = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 23);
};
pub const SN_id_ct_routeOriginAuthz = "id-ct-routeOriginAuthz";
pub const NID_id_ct_routeOriginAuthz = @as(c_int, 1234);
pub const OBJ_id_ct_routeOriginAuthz = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 24);
};
pub const SN_id_ct_rpkiManifest = "id-ct-rpkiManifest";
pub const NID_id_ct_rpkiManifest = @as(c_int, 1235);
pub const OBJ_id_ct_rpkiManifest = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 26);
};
pub const SN_id_ct_asciiTextWithCRLF = "id-ct-asciiTextWithCRLF";
pub const NID_id_ct_asciiTextWithCRLF = @as(c_int, 787);
pub const OBJ_id_ct_asciiTextWithCRLF = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 27);
};
pub const SN_id_ct_xml = "id-ct-xml";
pub const NID_id_ct_xml = @as(c_int, 1060);
pub const OBJ_id_ct_xml = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 28);
};
pub const SN_id_ct_rpkiGhostbusters = "id-ct-rpkiGhostbusters";
pub const NID_id_ct_rpkiGhostbusters = @as(c_int, 1236);
pub const OBJ_id_ct_rpkiGhostbusters = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 35);
};
pub const SN_id_ct_resourceTaggedAttest = "id-ct-resourceTaggedAttest";
pub const NID_id_ct_resourceTaggedAttest = @as(c_int, 1237);
pub const OBJ_id_ct_resourceTaggedAttest = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 36);
};
pub const SN_id_ct_geofeedCSVwithCRLF = "id-ct-geofeedCSVwithCRLF";
pub const NID_id_ct_geofeedCSVwithCRLF = @as(c_int, 1246);
pub const OBJ_id_ct_geofeedCSVwithCRLF = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 47);
};
pub const SN_id_ct_signedChecklist = "id-ct-signedChecklist";
pub const NID_id_ct_signedChecklist = @as(c_int, 1247);
pub const OBJ_id_ct_signedChecklist = blk: {
    _ = &OBJ_id_smime_ct;
    break :blk @as(c_long, 48);
};
pub const SN_id_smime_aa_receiptRequest = "id-smime-aa-receiptRequest";
pub const NID_id_smime_aa_receiptRequest = @as(c_int, 212);
pub const OBJ_id_smime_aa_receiptRequest = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_aa_securityLabel = "id-smime-aa-securityLabel";
pub const NID_id_smime_aa_securityLabel = @as(c_int, 213);
pub const OBJ_id_smime_aa_securityLabel = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 2);
};
pub const SN_id_smime_aa_mlExpandHistory = "id-smime-aa-mlExpandHistory";
pub const NID_id_smime_aa_mlExpandHistory = @as(c_int, 214);
pub const OBJ_id_smime_aa_mlExpandHistory = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 3);
};
pub const SN_id_smime_aa_contentHint = "id-smime-aa-contentHint";
pub const NID_id_smime_aa_contentHint = @as(c_int, 215);
pub const OBJ_id_smime_aa_contentHint = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 4);
};
pub const SN_id_smime_aa_msgSigDigest = "id-smime-aa-msgSigDigest";
pub const NID_id_smime_aa_msgSigDigest = @as(c_int, 216);
pub const OBJ_id_smime_aa_msgSigDigest = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 5);
};
pub const SN_id_smime_aa_encapContentType = "id-smime-aa-encapContentType";
pub const NID_id_smime_aa_encapContentType = @as(c_int, 217);
pub const OBJ_id_smime_aa_encapContentType = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 6);
};
pub const SN_id_smime_aa_contentIdentifier = "id-smime-aa-contentIdentifier";
pub const NID_id_smime_aa_contentIdentifier = @as(c_int, 218);
pub const OBJ_id_smime_aa_contentIdentifier = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 7);
};
pub const SN_id_smime_aa_macValue = "id-smime-aa-macValue";
pub const NID_id_smime_aa_macValue = @as(c_int, 219);
pub const OBJ_id_smime_aa_macValue = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 8);
};
pub const SN_id_smime_aa_equivalentLabels = "id-smime-aa-equivalentLabels";
pub const NID_id_smime_aa_equivalentLabels = @as(c_int, 220);
pub const OBJ_id_smime_aa_equivalentLabels = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 9);
};
pub const SN_id_smime_aa_contentReference = "id-smime-aa-contentReference";
pub const NID_id_smime_aa_contentReference = @as(c_int, 221);
pub const OBJ_id_smime_aa_contentReference = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 10);
};
pub const SN_id_smime_aa_encrypKeyPref = "id-smime-aa-encrypKeyPref";
pub const NID_id_smime_aa_encrypKeyPref = @as(c_int, 222);
pub const OBJ_id_smime_aa_encrypKeyPref = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 11);
};
pub const SN_id_smime_aa_signingCertificate = "id-smime-aa-signingCertificate";
pub const NID_id_smime_aa_signingCertificate = @as(c_int, 223);
pub const OBJ_id_smime_aa_signingCertificate = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 12);
};
pub const SN_id_smime_aa_smimeEncryptCerts = "id-smime-aa-smimeEncryptCerts";
pub const NID_id_smime_aa_smimeEncryptCerts = @as(c_int, 224);
pub const OBJ_id_smime_aa_smimeEncryptCerts = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 13);
};
pub const SN_id_smime_aa_timeStampToken = "id-smime-aa-timeStampToken";
pub const NID_id_smime_aa_timeStampToken = @as(c_int, 225);
pub const OBJ_id_smime_aa_timeStampToken = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 14);
};
pub const SN_id_smime_aa_ets_sigPolicyId = "id-smime-aa-ets-sigPolicyId";
pub const NID_id_smime_aa_ets_sigPolicyId = @as(c_int, 226);
pub const OBJ_id_smime_aa_ets_sigPolicyId = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 15);
};
pub const SN_id_smime_aa_ets_commitmentType = "id-smime-aa-ets-commitmentType";
pub const NID_id_smime_aa_ets_commitmentType = @as(c_int, 227);
pub const OBJ_id_smime_aa_ets_commitmentType = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 16);
};
pub const SN_id_smime_aa_ets_signerLocation = "id-smime-aa-ets-signerLocation";
pub const NID_id_smime_aa_ets_signerLocation = @as(c_int, 228);
pub const OBJ_id_smime_aa_ets_signerLocation = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 17);
};
pub const SN_id_smime_aa_ets_signerAttr = "id-smime-aa-ets-signerAttr";
pub const NID_id_smime_aa_ets_signerAttr = @as(c_int, 229);
pub const OBJ_id_smime_aa_ets_signerAttr = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 18);
};
pub const SN_id_smime_aa_ets_otherSigCert = "id-smime-aa-ets-otherSigCert";
pub const NID_id_smime_aa_ets_otherSigCert = @as(c_int, 230);
pub const OBJ_id_smime_aa_ets_otherSigCert = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 19);
};
pub const SN_id_smime_aa_ets_contentTimestamp = "id-smime-aa-ets-contentTimestamp";
pub const NID_id_smime_aa_ets_contentTimestamp = @as(c_int, 231);
pub const OBJ_id_smime_aa_ets_contentTimestamp = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 20);
};
pub const SN_id_smime_aa_ets_CertificateRefs = "id-smime-aa-ets-CertificateRefs";
pub const NID_id_smime_aa_ets_CertificateRefs = @as(c_int, 232);
pub const OBJ_id_smime_aa_ets_CertificateRefs = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 21);
};
pub const SN_id_smime_aa_ets_RevocationRefs = "id-smime-aa-ets-RevocationRefs";
pub const NID_id_smime_aa_ets_RevocationRefs = @as(c_int, 233);
pub const OBJ_id_smime_aa_ets_RevocationRefs = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 22);
};
pub const SN_id_smime_aa_ets_certValues = "id-smime-aa-ets-certValues";
pub const NID_id_smime_aa_ets_certValues = @as(c_int, 234);
pub const OBJ_id_smime_aa_ets_certValues = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 23);
};
pub const SN_id_smime_aa_ets_revocationValues = "id-smime-aa-ets-revocationValues";
pub const NID_id_smime_aa_ets_revocationValues = @as(c_int, 235);
pub const OBJ_id_smime_aa_ets_revocationValues = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 24);
};
pub const SN_id_smime_aa_ets_escTimeStamp = "id-smime-aa-ets-escTimeStamp";
pub const NID_id_smime_aa_ets_escTimeStamp = @as(c_int, 236);
pub const OBJ_id_smime_aa_ets_escTimeStamp = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 25);
};
pub const SN_id_smime_aa_ets_certCRLTimestamp = "id-smime-aa-ets-certCRLTimestamp";
pub const NID_id_smime_aa_ets_certCRLTimestamp = @as(c_int, 237);
pub const OBJ_id_smime_aa_ets_certCRLTimestamp = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 26);
};
pub const SN_id_smime_aa_ets_archiveTimeStamp = "id-smime-aa-ets-archiveTimeStamp";
pub const NID_id_smime_aa_ets_archiveTimeStamp = @as(c_int, 238);
pub const OBJ_id_smime_aa_ets_archiveTimeStamp = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 27);
};
pub const SN_id_smime_aa_signatureType = "id-smime-aa-signatureType";
pub const NID_id_smime_aa_signatureType = @as(c_int, 239);
pub const OBJ_id_smime_aa_signatureType = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 28);
};
pub const SN_id_smime_aa_dvcs_dvc = "id-smime-aa-dvcs-dvc";
pub const NID_id_smime_aa_dvcs_dvc = @as(c_int, 240);
pub const OBJ_id_smime_aa_dvcs_dvc = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 29);
};
pub const SN_id_smime_aa_signingCertificateV2 = "id-smime-aa-signingCertificateV2";
pub const NID_id_smime_aa_signingCertificateV2 = @as(c_int, 1086);
pub const OBJ_id_smime_aa_signingCertificateV2 = blk: {
    _ = &OBJ_id_smime_aa;
    break :blk @as(c_long, 47);
};
pub const SN_id_smime_alg_ESDHwith3DES = "id-smime-alg-ESDHwith3DES";
pub const NID_id_smime_alg_ESDHwith3DES = @as(c_int, 241);
pub const OBJ_id_smime_alg_ESDHwith3DES = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_alg_ESDHwithRC2 = "id-smime-alg-ESDHwithRC2";
pub const NID_id_smime_alg_ESDHwithRC2 = @as(c_int, 242);
pub const OBJ_id_smime_alg_ESDHwithRC2 = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 2);
};
pub const SN_id_smime_alg_3DESwrap = "id-smime-alg-3DESwrap";
pub const NID_id_smime_alg_3DESwrap = @as(c_int, 243);
pub const OBJ_id_smime_alg_3DESwrap = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 3);
};
pub const SN_id_smime_alg_RC2wrap = "id-smime-alg-RC2wrap";
pub const NID_id_smime_alg_RC2wrap = @as(c_int, 244);
pub const OBJ_id_smime_alg_RC2wrap = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 4);
};
pub const SN_id_smime_alg_ESDH = "id-smime-alg-ESDH";
pub const NID_id_smime_alg_ESDH = @as(c_int, 245);
pub const OBJ_id_smime_alg_ESDH = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 5);
};
pub const SN_id_smime_alg_CMS3DESwrap = "id-smime-alg-CMS3DESwrap";
pub const NID_id_smime_alg_CMS3DESwrap = @as(c_int, 246);
pub const OBJ_id_smime_alg_CMS3DESwrap = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 6);
};
pub const SN_id_smime_alg_CMSRC2wrap = "id-smime-alg-CMSRC2wrap";
pub const NID_id_smime_alg_CMSRC2wrap = @as(c_int, 247);
pub const OBJ_id_smime_alg_CMSRC2wrap = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 7);
};
pub const SN_id_alg_PWRI_KEK = "id-alg-PWRI-KEK";
pub const NID_id_alg_PWRI_KEK = @as(c_int, 893);
pub const OBJ_id_alg_PWRI_KEK = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 9);
};
pub const SN_id_smime_cd_ldap = "id-smime-cd-ldap";
pub const NID_id_smime_cd_ldap = @as(c_int, 248);
pub const OBJ_id_smime_cd_ldap = blk: {
    _ = &OBJ_id_smime_cd;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_spq_ets_sqt_uri = "id-smime-spq-ets-sqt-uri";
pub const NID_id_smime_spq_ets_sqt_uri = @as(c_int, 249);
pub const OBJ_id_smime_spq_ets_sqt_uri = blk: {
    _ = &OBJ_id_smime_spq;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_spq_ets_sqt_unotice = "id-smime-spq-ets-sqt-unotice";
pub const NID_id_smime_spq_ets_sqt_unotice = @as(c_int, 250);
pub const OBJ_id_smime_spq_ets_sqt_unotice = blk: {
    _ = &OBJ_id_smime_spq;
    break :blk @as(c_long, 2);
};
pub const SN_id_smime_cti_ets_proofOfOrigin = "id-smime-cti-ets-proofOfOrigin";
pub const NID_id_smime_cti_ets_proofOfOrigin = @as(c_int, 251);
pub const OBJ_id_smime_cti_ets_proofOfOrigin = blk: {
    _ = &OBJ_id_smime_cti;
    break :blk @as(c_long, 1);
};
pub const SN_id_smime_cti_ets_proofOfReceipt = "id-smime-cti-ets-proofOfReceipt";
pub const NID_id_smime_cti_ets_proofOfReceipt = @as(c_int, 252);
pub const OBJ_id_smime_cti_ets_proofOfReceipt = blk: {
    _ = &OBJ_id_smime_cti;
    break :blk @as(c_long, 2);
};
pub const SN_id_smime_cti_ets_proofOfDelivery = "id-smime-cti-ets-proofOfDelivery";
pub const NID_id_smime_cti_ets_proofOfDelivery = @as(c_int, 253);
pub const OBJ_id_smime_cti_ets_proofOfDelivery = blk: {
    _ = &OBJ_id_smime_cti;
    break :blk @as(c_long, 3);
};
pub const SN_id_smime_cti_ets_proofOfSender = "id-smime-cti-ets-proofOfSender";
pub const NID_id_smime_cti_ets_proofOfSender = @as(c_int, 254);
pub const OBJ_id_smime_cti_ets_proofOfSender = blk: {
    _ = &OBJ_id_smime_cti;
    break :blk @as(c_long, 4);
};
pub const SN_id_smime_cti_ets_proofOfApproval = "id-smime-cti-ets-proofOfApproval";
pub const NID_id_smime_cti_ets_proofOfApproval = @as(c_int, 255);
pub const OBJ_id_smime_cti_ets_proofOfApproval = blk: {
    _ = &OBJ_id_smime_cti;
    break :blk @as(c_long, 5);
};
pub const SN_id_smime_cti_ets_proofOfCreation = "id-smime-cti-ets-proofOfCreation";
pub const NID_id_smime_cti_ets_proofOfCreation = @as(c_int, 256);
pub const OBJ_id_smime_cti_ets_proofOfCreation = blk: {
    _ = &OBJ_id_smime_cti;
    break :blk @as(c_long, 6);
};
pub const LN_friendlyName = "friendlyName";
pub const NID_friendlyName = @as(c_int, 156);
pub const OBJ_friendlyName = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 20);
};
pub const LN_localKeyID = "localKeyID";
pub const NID_localKeyID = @as(c_int, 157);
pub const OBJ_localKeyID = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 21);
};
pub const SN_ms_csp_name = "CSPName";
pub const LN_ms_csp_name = "Microsoft CSP Name";
pub const NID_ms_csp_name = @as(c_int, 417);
pub const OBJ_ms_csp_name = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 17);
    break :blk @as(c_long, 1);
};
pub const SN_LocalKeySet = "LocalKeySet";
pub const LN_LocalKeySet = "Microsoft Local Key set";
pub const NID_LocalKeySet = @as(c_int, 856);
pub const OBJ_LocalKeySet = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 17);
    break :blk @as(c_long, 2);
};
pub const OBJ_certTypes = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 22);
};
pub const LN_x509Certificate = "x509Certificate";
pub const NID_x509Certificate = @as(c_int, 158);
pub const OBJ_x509Certificate = blk: {
    _ = &OBJ_certTypes;
    break :blk @as(c_long, 1);
};
pub const LN_sdsiCertificate = "sdsiCertificate";
pub const NID_sdsiCertificate = @as(c_int, 159);
pub const OBJ_sdsiCertificate = blk: {
    _ = &OBJ_certTypes;
    break :blk @as(c_long, 2);
};
pub const OBJ_crlTypes = blk: {
    _ = &OBJ_pkcs9;
    break :blk @as(c_long, 23);
};
pub const LN_x509Crl = "x509Crl";
pub const NID_x509Crl = @as(c_int, 160);
pub const OBJ_x509Crl = blk: {
    _ = &OBJ_crlTypes;
    break :blk @as(c_long, 1);
};
pub const OBJ_pkcs12 = blk: {
    _ = &OBJ_pkcs;
    break :blk @as(c_long, 12);
};
pub const OBJ_pkcs12_pbeids = blk: {
    _ = &OBJ_pkcs12;
    break :blk @as(c_long, 1);
};
pub const SN_pbe_WithSHA1And128BitRC4 = "PBE-SHA1-RC4-128";
pub const LN_pbe_WithSHA1And128BitRC4 = "pbeWithSHA1And128BitRC4";
pub const NID_pbe_WithSHA1And128BitRC4 = @as(c_int, 144);
pub const OBJ_pbe_WithSHA1And128BitRC4 = blk: {
    _ = &OBJ_pkcs12_pbeids;
    break :blk @as(c_long, 1);
};
pub const SN_pbe_WithSHA1And40BitRC4 = "PBE-SHA1-RC4-40";
pub const LN_pbe_WithSHA1And40BitRC4 = "pbeWithSHA1And40BitRC4";
pub const NID_pbe_WithSHA1And40BitRC4 = @as(c_int, 145);
pub const OBJ_pbe_WithSHA1And40BitRC4 = blk: {
    _ = &OBJ_pkcs12_pbeids;
    break :blk @as(c_long, 2);
};
pub const SN_pbe_WithSHA1And3_Key_TripleDES_CBC = "PBE-SHA1-3DES";
pub const LN_pbe_WithSHA1And3_Key_TripleDES_CBC = "pbeWithSHA1And3-KeyTripleDES-CBC";
pub const NID_pbe_WithSHA1And3_Key_TripleDES_CBC = @as(c_int, 146);
pub const OBJ_pbe_WithSHA1And3_Key_TripleDES_CBC = blk: {
    _ = &OBJ_pkcs12_pbeids;
    break :blk @as(c_long, 3);
};
pub const SN_pbe_WithSHA1And2_Key_TripleDES_CBC = "PBE-SHA1-2DES";
pub const LN_pbe_WithSHA1And2_Key_TripleDES_CBC = "pbeWithSHA1And2-KeyTripleDES-CBC";
pub const NID_pbe_WithSHA1And2_Key_TripleDES_CBC = @as(c_int, 147);
pub const OBJ_pbe_WithSHA1And2_Key_TripleDES_CBC = blk: {
    _ = &OBJ_pkcs12_pbeids;
    break :blk @as(c_long, 4);
};
pub const SN_pbe_WithSHA1And128BitRC2_CBC = "PBE-SHA1-RC2-128";
pub const LN_pbe_WithSHA1And128BitRC2_CBC = "pbeWithSHA1And128BitRC2-CBC";
pub const NID_pbe_WithSHA1And128BitRC2_CBC = @as(c_int, 148);
pub const OBJ_pbe_WithSHA1And128BitRC2_CBC = blk: {
    _ = &OBJ_pkcs12_pbeids;
    break :blk @as(c_long, 5);
};
pub const SN_pbe_WithSHA1And40BitRC2_CBC = "PBE-SHA1-RC2-40";
pub const LN_pbe_WithSHA1And40BitRC2_CBC = "pbeWithSHA1And40BitRC2-CBC";
pub const NID_pbe_WithSHA1And40BitRC2_CBC = @as(c_int, 149);
pub const OBJ_pbe_WithSHA1And40BitRC2_CBC = blk: {
    _ = &OBJ_pkcs12_pbeids;
    break :blk @as(c_long, 6);
};
pub const OBJ_pkcs12_Version1 = blk: {
    _ = &OBJ_pkcs12;
    break :blk @as(c_long, 10);
};
pub const OBJ_pkcs12_BagIds = blk: {
    _ = &OBJ_pkcs12_Version1;
    break :blk @as(c_long, 1);
};
pub const LN_keyBag = "keyBag";
pub const NID_keyBag = @as(c_int, 150);
pub const OBJ_keyBag = blk: {
    _ = &OBJ_pkcs12_BagIds;
    break :blk @as(c_long, 1);
};
pub const LN_pkcs8ShroudedKeyBag = "pkcs8ShroudedKeyBag";
pub const NID_pkcs8ShroudedKeyBag = @as(c_int, 151);
pub const OBJ_pkcs8ShroudedKeyBag = blk: {
    _ = &OBJ_pkcs12_BagIds;
    break :blk @as(c_long, 2);
};
pub const LN_certBag = "certBag";
pub const NID_certBag = @as(c_int, 152);
pub const OBJ_certBag = blk: {
    _ = &OBJ_pkcs12_BagIds;
    break :blk @as(c_long, 3);
};
pub const LN_crlBag = "crlBag";
pub const NID_crlBag = @as(c_int, 153);
pub const OBJ_crlBag = blk: {
    _ = &OBJ_pkcs12_BagIds;
    break :blk @as(c_long, 4);
};
pub const LN_secretBag = "secretBag";
pub const NID_secretBag = @as(c_int, 154);
pub const OBJ_secretBag = blk: {
    _ = &OBJ_pkcs12_BagIds;
    break :blk @as(c_long, 5);
};
pub const LN_safeContentsBag = "safeContentsBag";
pub const NID_safeContentsBag = @as(c_int, 155);
pub const OBJ_safeContentsBag = blk: {
    _ = &OBJ_pkcs12_BagIds;
    break :blk @as(c_long, 6);
};
pub const SN_md2 = "MD2";
pub const LN_md2 = "md2";
pub const NID_md2 = @as(c_int, 3);
pub const OBJ_md2 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 2);
};
pub const SN_md4 = "MD4";
pub const LN_md4 = "md4";
pub const NID_md4 = @as(c_int, 257);
pub const OBJ_md4 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 4);
};
pub const SN_md5 = "MD5";
pub const LN_md5 = "md5";
pub const NID_md5 = @as(c_int, 4);
pub const OBJ_md5 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 5);
};
pub const SN_md5_sha1 = "MD5-SHA1";
pub const LN_md5_sha1 = "md5-sha1";
pub const NID_md5_sha1 = @as(c_int, 114);
pub const LN_hmacWithMD5 = "hmacWithMD5";
pub const NID_hmacWithMD5 = @as(c_int, 797);
pub const OBJ_hmacWithMD5 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 6);
};
pub const LN_hmacWithSHA1 = "hmacWithSHA1";
pub const NID_hmacWithSHA1 = @as(c_int, 163);
pub const OBJ_hmacWithSHA1 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 7);
};
pub const SN_sm2 = "SM2";
pub const LN_sm2 = "sm2";
pub const NID_sm2 = @as(c_int, 1172);
pub const OBJ_sm2 = blk: {
    _ = &OBJ_sm_scheme;
    break :blk @as(c_long, 301);
};
pub const SN_sm3 = "SM3";
pub const LN_sm3 = "sm3";
pub const NID_sm3 = @as(c_int, 1143);
pub const OBJ_sm3 = blk: {
    _ = &OBJ_sm_scheme;
    break :blk @as(c_long, 401);
};
pub const SN_sm3WithRSAEncryption = "RSA-SM3";
pub const LN_sm3WithRSAEncryption = "sm3WithRSAEncryption";
pub const NID_sm3WithRSAEncryption = @as(c_int, 1144);
pub const OBJ_sm3WithRSAEncryption = blk: {
    _ = &OBJ_sm_scheme;
    break :blk @as(c_long, 504);
};
pub const SN_SM2_with_SM3 = "SM2-SM3";
pub const LN_SM2_with_SM3 = "SM2-with-SM3";
pub const NID_SM2_with_SM3 = @as(c_int, 1204);
pub const OBJ_SM2_with_SM3 = blk: {
    _ = &OBJ_sm_scheme;
    break :blk @as(c_long, 501);
};
pub const LN_hmacWithSHA224 = "hmacWithSHA224";
pub const NID_hmacWithSHA224 = @as(c_int, 798);
pub const OBJ_hmacWithSHA224 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 8);
};
pub const LN_hmacWithSHA256 = "hmacWithSHA256";
pub const NID_hmacWithSHA256 = @as(c_int, 799);
pub const OBJ_hmacWithSHA256 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 9);
};
pub const LN_hmacWithSHA384 = "hmacWithSHA384";
pub const NID_hmacWithSHA384 = @as(c_int, 800);
pub const OBJ_hmacWithSHA384 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 10);
};
pub const LN_hmacWithSHA512 = "hmacWithSHA512";
pub const NID_hmacWithSHA512 = @as(c_int, 801);
pub const OBJ_hmacWithSHA512 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 11);
};
pub const LN_hmacWithSHA512_224 = "hmacWithSHA512-224";
pub const NID_hmacWithSHA512_224 = @as(c_int, 1193);
pub const OBJ_hmacWithSHA512_224 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 12);
};
pub const LN_hmacWithSHA512_256 = "hmacWithSHA512-256";
pub const NID_hmacWithSHA512_256 = @as(c_int, 1194);
pub const OBJ_hmacWithSHA512_256 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 13);
};
pub const SN_rc2_cbc = "RC2-CBC";
pub const LN_rc2_cbc = "rc2-cbc";
pub const NID_rc2_cbc = @as(c_int, 37);
pub const OBJ_rc2_cbc = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 3);
    break :blk @as(c_long, 2);
};
pub const SN_rc2_ecb = "RC2-ECB";
pub const LN_rc2_ecb = "rc2-ecb";
pub const NID_rc2_ecb = @as(c_int, 38);
pub const SN_rc2_cfb64 = "RC2-CFB";
pub const LN_rc2_cfb64 = "rc2-cfb";
pub const NID_rc2_cfb64 = @as(c_int, 39);
pub const SN_rc2_ofb64 = "RC2-OFB";
pub const LN_rc2_ofb64 = "rc2-ofb";
pub const NID_rc2_ofb64 = @as(c_int, 40);
pub const SN_rc2_40_cbc = "RC2-40-CBC";
pub const LN_rc2_40_cbc = "rc2-40-cbc";
pub const NID_rc2_40_cbc = @as(c_int, 98);
pub const SN_rc2_64_cbc = "RC2-64-CBC";
pub const LN_rc2_64_cbc = "rc2-64-cbc";
pub const NID_rc2_64_cbc = @as(c_int, 166);
pub const SN_rc4 = "RC4";
pub const LN_rc4 = "rc4";
pub const NID_rc4 = @as(c_int, 5);
pub const OBJ_rc4 = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 3);
    break :blk @as(c_long, 4);
};
pub const SN_rc4_40 = "RC4-40";
pub const LN_rc4_40 = "rc4-40";
pub const NID_rc4_40 = @as(c_int, 97);
pub const SN_des_ede3_cbc = "DES-EDE3-CBC";
pub const LN_des_ede3_cbc = "des-ede3-cbc";
pub const NID_des_ede3_cbc = @as(c_int, 44);
pub const OBJ_des_ede3_cbc = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 3);
    break :blk @as(c_long, 7);
};
pub const SN_rc5_cbc = "RC5-CBC";
pub const LN_rc5_cbc = "rc5-cbc";
pub const NID_rc5_cbc = @as(c_int, 120);
pub const OBJ_rc5_cbc = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 3);
    break :blk @as(c_long, 8);
};
pub const SN_rc5_ecb = "RC5-ECB";
pub const LN_rc5_ecb = "rc5-ecb";
pub const NID_rc5_ecb = @as(c_int, 121);
pub const SN_rc5_cfb64 = "RC5-CFB";
pub const LN_rc5_cfb64 = "rc5-cfb";
pub const NID_rc5_cfb64 = @as(c_int, 122);
pub const SN_rc5_ofb64 = "RC5-OFB";
pub const LN_rc5_ofb64 = "rc5-ofb";
pub const NID_rc5_ofb64 = @as(c_int, 123);
pub const SN_ms_ext_req = "msExtReq";
pub const LN_ms_ext_req = "Microsoft Extension Request";
pub const NID_ms_ext_req = @as(c_int, 171);
pub const OBJ_ms_ext_req = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 2);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 14);
};
pub const SN_ms_code_ind = "msCodeInd";
pub const LN_ms_code_ind = "Microsoft Individual Code Signing";
pub const NID_ms_code_ind = @as(c_int, 134);
pub const OBJ_ms_code_ind = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 2);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 21);
};
pub const SN_ms_code_com = "msCodeCom";
pub const LN_ms_code_com = "Microsoft Commercial Code Signing";
pub const NID_ms_code_com = @as(c_int, 135);
pub const OBJ_ms_code_com = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 2);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 22);
};
pub const SN_ms_ctl_sign = "msCTLSign";
pub const LN_ms_ctl_sign = "Microsoft Trust List Signing";
pub const NID_ms_ctl_sign = @as(c_int, 136);
pub const OBJ_ms_ctl_sign = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 10);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 1);
};
pub const SN_ms_sgc = "msSGC";
pub const LN_ms_sgc = "Microsoft Server Gated Crypto";
pub const NID_ms_sgc = @as(c_int, 137);
pub const OBJ_ms_sgc = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 10);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 3);
};
pub const SN_ms_efs = "msEFS";
pub const LN_ms_efs = "Microsoft Encrypted File System";
pub const NID_ms_efs = @as(c_int, 138);
pub const OBJ_ms_efs = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 10);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 4);
};
pub const SN_ms_smartcard_login = "msSmartcardLogin";
pub const LN_ms_smartcard_login = "Microsoft Smartcard Login";
pub const NID_ms_smartcard_login = @as(c_int, 648);
pub const OBJ_ms_smartcard_login = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 20);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 2);
};
pub const SN_ms_upn = "msUPN";
pub const LN_ms_upn = "Microsoft User Principal Name";
pub const NID_ms_upn = @as(c_int, 649);
pub const OBJ_ms_upn = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 20);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 3);
};
pub const SN_idea_cbc = "IDEA-CBC";
pub const LN_idea_cbc = "idea-cbc";
pub const NID_idea_cbc = @as(c_int, 34);
pub const OBJ_idea_cbc = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 188);
    _ = @as(c_long, 7);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_idea_ecb = "IDEA-ECB";
pub const LN_idea_ecb = "idea-ecb";
pub const NID_idea_ecb = @as(c_int, 36);
pub const SN_idea_cfb64 = "IDEA-CFB";
pub const LN_idea_cfb64 = "idea-cfb";
pub const NID_idea_cfb64 = @as(c_int, 35);
pub const SN_idea_ofb64 = "IDEA-OFB";
pub const LN_idea_ofb64 = "idea-ofb";
pub const NID_idea_ofb64 = @as(c_int, 46);
pub const SN_bf_cbc = "BF-CBC";
pub const LN_bf_cbc = "bf-cbc";
pub const NID_bf_cbc = @as(c_int, 91);
pub const OBJ_bf_cbc = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 3029);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_bf_ecb = "BF-ECB";
pub const LN_bf_ecb = "bf-ecb";
pub const NID_bf_ecb = @as(c_int, 92);
pub const SN_bf_cfb64 = "BF-CFB";
pub const LN_bf_cfb64 = "bf-cfb";
pub const NID_bf_cfb64 = @as(c_int, 93);
pub const SN_bf_ofb64 = "BF-OFB";
pub const LN_bf_ofb64 = "bf-ofb";
pub const NID_bf_ofb64 = @as(c_int, 94);
pub const SN_id_pkix = "PKIX";
pub const NID_id_pkix = @as(c_int, 127);
pub const OBJ_id_pkix = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 5);
    _ = @as(c_long, 5);
    break :blk @as(c_long, 7);
};
pub const SN_id_pkix_mod = "id-pkix-mod";
pub const NID_id_pkix_mod = @as(c_int, 258);
pub const OBJ_id_pkix_mod = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 0);
};
pub const SN_id_pe = "id-pe";
pub const NID_id_pe = @as(c_int, 175);
pub const OBJ_id_pe = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 1);
};
pub const SN_id_qt = "id-qt";
pub const NID_id_qt = @as(c_int, 259);
pub const OBJ_id_qt = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 2);
};
pub const SN_id_kp = "id-kp";
pub const NID_id_kp = @as(c_int, 128);
pub const OBJ_id_kp = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 3);
};
pub const SN_id_it = "id-it";
pub const NID_id_it = @as(c_int, 260);
pub const OBJ_id_it = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 4);
};
pub const SN_id_pkip = "id-pkip";
pub const NID_id_pkip = @as(c_int, 261);
pub const OBJ_id_pkip = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 5);
};
pub const SN_id_alg = "id-alg";
pub const NID_id_alg = @as(c_int, 262);
pub const OBJ_id_alg = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 6);
};
pub const SN_id_cmc = "id-cmc";
pub const NID_id_cmc = @as(c_int, 263);
pub const OBJ_id_cmc = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 7);
};
pub const SN_id_on = "id-on";
pub const NID_id_on = @as(c_int, 264);
pub const OBJ_id_on = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 8);
};
pub const SN_id_pda = "id-pda";
pub const NID_id_pda = @as(c_int, 265);
pub const OBJ_id_pda = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 9);
};
pub const SN_id_aca = "id-aca";
pub const NID_id_aca = @as(c_int, 266);
pub const OBJ_id_aca = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 10);
};
pub const SN_id_qcs = "id-qcs";
pub const NID_id_qcs = @as(c_int, 267);
pub const OBJ_id_qcs = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 11);
};
pub const SN_id_cp = "id-cp";
pub const NID_id_cp = @as(c_int, 1238);
pub const OBJ_id_cp = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 14);
};
pub const SN_id_cct = "id-cct";
pub const NID_id_cct = @as(c_int, 268);
pub const OBJ_id_cct = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 12);
};
pub const SN_id_ppl = "id-ppl";
pub const NID_id_ppl = @as(c_int, 662);
pub const OBJ_id_ppl = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 21);
};
pub const SN_id_ad = "id-ad";
pub const NID_id_ad = @as(c_int, 176);
pub const OBJ_id_ad = blk: {
    _ = &OBJ_id_pkix;
    break :blk @as(c_long, 48);
};
pub const SN_id_pkix1_explicit_88 = "id-pkix1-explicit-88";
pub const NID_id_pkix1_explicit_88 = @as(c_int, 269);
pub const OBJ_id_pkix1_explicit_88 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 1);
};
pub const SN_id_pkix1_implicit_88 = "id-pkix1-implicit-88";
pub const NID_id_pkix1_implicit_88 = @as(c_int, 270);
pub const OBJ_id_pkix1_implicit_88 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 2);
};
pub const SN_id_pkix1_explicit_93 = "id-pkix1-explicit-93";
pub const NID_id_pkix1_explicit_93 = @as(c_int, 271);
pub const OBJ_id_pkix1_explicit_93 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 3);
};
pub const SN_id_pkix1_implicit_93 = "id-pkix1-implicit-93";
pub const NID_id_pkix1_implicit_93 = @as(c_int, 272);
pub const OBJ_id_pkix1_implicit_93 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 4);
};
pub const SN_id_mod_crmf = "id-mod-crmf";
pub const NID_id_mod_crmf = @as(c_int, 273);
pub const OBJ_id_mod_crmf = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 5);
};
pub const SN_id_mod_cmc = "id-mod-cmc";
pub const NID_id_mod_cmc = @as(c_int, 274);
pub const OBJ_id_mod_cmc = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 6);
};
pub const SN_id_mod_kea_profile_88 = "id-mod-kea-profile-88";
pub const NID_id_mod_kea_profile_88 = @as(c_int, 275);
pub const OBJ_id_mod_kea_profile_88 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 7);
};
pub const SN_id_mod_kea_profile_93 = "id-mod-kea-profile-93";
pub const NID_id_mod_kea_profile_93 = @as(c_int, 276);
pub const OBJ_id_mod_kea_profile_93 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 8);
};
pub const SN_id_mod_cmp = "id-mod-cmp";
pub const NID_id_mod_cmp = @as(c_int, 277);
pub const OBJ_id_mod_cmp = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 9);
};
pub const SN_id_mod_qualified_cert_88 = "id-mod-qualified-cert-88";
pub const NID_id_mod_qualified_cert_88 = @as(c_int, 278);
pub const OBJ_id_mod_qualified_cert_88 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 10);
};
pub const SN_id_mod_qualified_cert_93 = "id-mod-qualified-cert-93";
pub const NID_id_mod_qualified_cert_93 = @as(c_int, 279);
pub const OBJ_id_mod_qualified_cert_93 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 11);
};
pub const SN_id_mod_attribute_cert = "id-mod-attribute-cert";
pub const NID_id_mod_attribute_cert = @as(c_int, 280);
pub const OBJ_id_mod_attribute_cert = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 12);
};
pub const SN_id_mod_timestamp_protocol = "id-mod-timestamp-protocol";
pub const NID_id_mod_timestamp_protocol = @as(c_int, 281);
pub const OBJ_id_mod_timestamp_protocol = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 13);
};
pub const SN_id_mod_ocsp = "id-mod-ocsp";
pub const NID_id_mod_ocsp = @as(c_int, 282);
pub const OBJ_id_mod_ocsp = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 14);
};
pub const SN_id_mod_dvcs = "id-mod-dvcs";
pub const NID_id_mod_dvcs = @as(c_int, 283);
pub const OBJ_id_mod_dvcs = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 15);
};
pub const SN_id_mod_cmp2000 = "id-mod-cmp2000";
pub const NID_id_mod_cmp2000 = @as(c_int, 284);
pub const OBJ_id_mod_cmp2000 = blk: {
    _ = &OBJ_id_pkix_mod;
    break :blk @as(c_long, 16);
};
pub const SN_info_access = "authorityInfoAccess";
pub const LN_info_access = "Authority Information Access";
pub const NID_info_access = @as(c_int, 177);
pub const OBJ_info_access = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 1);
};
pub const SN_biometricInfo = "biometricInfo";
pub const LN_biometricInfo = "Biometric Info";
pub const NID_biometricInfo = @as(c_int, 285);
pub const OBJ_biometricInfo = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 2);
};
pub const SN_qcStatements = "qcStatements";
pub const NID_qcStatements = @as(c_int, 286);
pub const OBJ_qcStatements = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 3);
};
pub const SN_ac_auditEntity = "ac-auditEntity";
pub const NID_ac_auditEntity = @as(c_int, 287);
pub const OBJ_ac_auditEntity = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 4);
};
pub const SN_ac_targeting = "ac-targeting";
pub const NID_ac_targeting = @as(c_int, 288);
pub const OBJ_ac_targeting = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 5);
};
pub const SN_aaControls = "aaControls";
pub const NID_aaControls = @as(c_int, 289);
pub const OBJ_aaControls = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 6);
};
pub const SN_sbgp_ipAddrBlock = "sbgp-ipAddrBlock";
pub const NID_sbgp_ipAddrBlock = @as(c_int, 290);
pub const OBJ_sbgp_ipAddrBlock = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 7);
};
pub const SN_sbgp_autonomousSysNum = "sbgp-autonomousSysNum";
pub const NID_sbgp_autonomousSysNum = @as(c_int, 291);
pub const OBJ_sbgp_autonomousSysNum = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 8);
};
pub const SN_sbgp_routerIdentifier = "sbgp-routerIdentifier";
pub const NID_sbgp_routerIdentifier = @as(c_int, 292);
pub const OBJ_sbgp_routerIdentifier = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 9);
};
pub const SN_ac_proxying = "ac-proxying";
pub const NID_ac_proxying = @as(c_int, 397);
pub const OBJ_ac_proxying = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 10);
};
pub const SN_sinfo_access = "subjectInfoAccess";
pub const LN_sinfo_access = "Subject Information Access";
pub const NID_sinfo_access = @as(c_int, 398);
pub const OBJ_sinfo_access = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 11);
};
pub const SN_proxyCertInfo = "proxyCertInfo";
pub const LN_proxyCertInfo = "Proxy Certificate Information";
pub const NID_proxyCertInfo = @as(c_int, 663);
pub const OBJ_proxyCertInfo = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 14);
};
pub const SN_tlsfeature = "tlsfeature";
pub const LN_tlsfeature = "TLS Feature";
pub const NID_tlsfeature = @as(c_int, 1020);
pub const OBJ_tlsfeature = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 24);
};
pub const SN_sbgp_ipAddrBlockv2 = "sbgp-ipAddrBlockv2";
pub const NID_sbgp_ipAddrBlockv2 = @as(c_int, 1239);
pub const OBJ_sbgp_ipAddrBlockv2 = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 28);
};
pub const SN_sbgp_autonomousSysNumv2 = "sbgp-autonomousSysNumv2";
pub const NID_sbgp_autonomousSysNumv2 = @as(c_int, 1240);
pub const OBJ_sbgp_autonomousSysNumv2 = blk: {
    _ = &OBJ_id_pe;
    break :blk @as(c_long, 29);
};
pub const SN_id_qt_cps = "id-qt-cps";
pub const LN_id_qt_cps = "Policy Qualifier CPS";
pub const NID_id_qt_cps = @as(c_int, 164);
pub const OBJ_id_qt_cps = blk: {
    _ = &OBJ_id_qt;
    break :blk @as(c_long, 1);
};
pub const SN_id_qt_unotice = "id-qt-unotice";
pub const LN_id_qt_unotice = "Policy Qualifier User Notice";
pub const NID_id_qt_unotice = @as(c_int, 165);
pub const OBJ_id_qt_unotice = blk: {
    _ = &OBJ_id_qt;
    break :blk @as(c_long, 2);
};
pub const SN_textNotice = "textNotice";
pub const NID_textNotice = @as(c_int, 293);
pub const OBJ_textNotice = blk: {
    _ = &OBJ_id_qt;
    break :blk @as(c_long, 3);
};
pub const SN_server_auth = "serverAuth";
pub const LN_server_auth = "TLS Web Server Authentication";
pub const NID_server_auth = @as(c_int, 129);
pub const OBJ_server_auth = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 1);
};
pub const SN_client_auth = "clientAuth";
pub const LN_client_auth = "TLS Web Client Authentication";
pub const NID_client_auth = @as(c_int, 130);
pub const OBJ_client_auth = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 2);
};
pub const SN_code_sign = "codeSigning";
pub const LN_code_sign = "Code Signing";
pub const NID_code_sign = @as(c_int, 131);
pub const OBJ_code_sign = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 3);
};
pub const SN_email_protect = "emailProtection";
pub const LN_email_protect = "E-mail Protection";
pub const NID_email_protect = @as(c_int, 132);
pub const OBJ_email_protect = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 4);
};
pub const SN_ipsecEndSystem = "ipsecEndSystem";
pub const LN_ipsecEndSystem = "IPSec End System";
pub const NID_ipsecEndSystem = @as(c_int, 294);
pub const OBJ_ipsecEndSystem = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 5);
};
pub const SN_ipsecTunnel = "ipsecTunnel";
pub const LN_ipsecTunnel = "IPSec Tunnel";
pub const NID_ipsecTunnel = @as(c_int, 295);
pub const OBJ_ipsecTunnel = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 6);
};
pub const SN_ipsecUser = "ipsecUser";
pub const LN_ipsecUser = "IPSec User";
pub const NID_ipsecUser = @as(c_int, 296);
pub const OBJ_ipsecUser = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 7);
};
pub const SN_time_stamp = "timeStamping";
pub const LN_time_stamp = "Time Stamping";
pub const NID_time_stamp = @as(c_int, 133);
pub const OBJ_time_stamp = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 8);
};
pub const SN_OCSP_sign = "OCSPSigning";
pub const LN_OCSP_sign = "OCSP Signing";
pub const NID_OCSP_sign = @as(c_int, 180);
pub const OBJ_OCSP_sign = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 9);
};
pub const SN_dvcs = "DVCS";
pub const LN_dvcs = "dvcs";
pub const NID_dvcs = @as(c_int, 297);
pub const OBJ_dvcs = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 10);
};
pub const SN_ipsec_IKE = "ipsecIKE";
pub const LN_ipsec_IKE = "ipsec Internet Key Exchange";
pub const NID_ipsec_IKE = @as(c_int, 1022);
pub const OBJ_ipsec_IKE = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 17);
};
pub const SN_capwapAC = "capwapAC";
pub const LN_capwapAC = "Ctrl/provision WAP Access";
pub const NID_capwapAC = @as(c_int, 1023);
pub const OBJ_capwapAC = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 18);
};
pub const SN_capwapWTP = "capwapWTP";
pub const LN_capwapWTP = "Ctrl/Provision WAP Termination";
pub const NID_capwapWTP = @as(c_int, 1024);
pub const OBJ_capwapWTP = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 19);
};
pub const SN_sshClient = "secureShellClient";
pub const LN_sshClient = "SSH Client";
pub const NID_sshClient = @as(c_int, 1025);
pub const OBJ_sshClient = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 21);
};
pub const SN_sshServer = "secureShellServer";
pub const LN_sshServer = "SSH Server";
pub const NID_sshServer = @as(c_int, 1026);
pub const OBJ_sshServer = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 22);
};
pub const SN_sendRouter = "sendRouter";
pub const LN_sendRouter = "Send Router";
pub const NID_sendRouter = @as(c_int, 1027);
pub const OBJ_sendRouter = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 23);
};
pub const SN_sendProxiedRouter = "sendProxiedRouter";
pub const LN_sendProxiedRouter = "Send Proxied Router";
pub const NID_sendProxiedRouter = @as(c_int, 1028);
pub const OBJ_sendProxiedRouter = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 24);
};
pub const SN_sendOwner = "sendOwner";
pub const LN_sendOwner = "Send Owner";
pub const NID_sendOwner = @as(c_int, 1029);
pub const OBJ_sendOwner = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 25);
};
pub const SN_sendProxiedOwner = "sendProxiedOwner";
pub const LN_sendProxiedOwner = "Send Proxied Owner";
pub const NID_sendProxiedOwner = @as(c_int, 1030);
pub const OBJ_sendProxiedOwner = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 26);
};
pub const SN_cmcCA = "cmcCA";
pub const LN_cmcCA = "CMC Certificate Authority";
pub const NID_cmcCA = @as(c_int, 1131);
pub const OBJ_cmcCA = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 27);
};
pub const SN_cmcRA = "cmcRA";
pub const LN_cmcRA = "CMC Registration Authority";
pub const NID_cmcRA = @as(c_int, 1132);
pub const OBJ_cmcRA = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 28);
};
pub const SN_cmcArchive = "cmcArchive";
pub const LN_cmcArchive = "CMC Archive Server";
pub const NID_cmcArchive = @as(c_int, 1219);
pub const OBJ_cmcArchive = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 29);
};
pub const SN_id_kp_bgpsec_router = "id-kp-bgpsec-router";
pub const LN_id_kp_bgpsec_router = "BGPsec Router";
pub const NID_id_kp_bgpsec_router = @as(c_int, 1220);
pub const OBJ_id_kp_bgpsec_router = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 30);
};
pub const SN_id_kp_BrandIndicatorforMessageIdentification = "id-kp-BrandIndicatorforMessageIdentification";
pub const LN_id_kp_BrandIndicatorforMessageIdentification = "Brand Indicator for Message Identification";
pub const NID_id_kp_BrandIndicatorforMessageIdentification = @as(c_int, 1221);
pub const OBJ_id_kp_BrandIndicatorforMessageIdentification = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 31);
};
pub const SN_cmKGA = "cmKGA";
pub const LN_cmKGA = "Certificate Management Key Generation Authority";
pub const NID_cmKGA = @as(c_int, 1222);
pub const OBJ_cmKGA = blk: {
    _ = &OBJ_id_kp;
    break :blk @as(c_long, 32);
};
pub const SN_id_it_caProtEncCert = "id-it-caProtEncCert";
pub const NID_id_it_caProtEncCert = @as(c_int, 298);
pub const OBJ_id_it_caProtEncCert = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 1);
};
pub const SN_id_it_signKeyPairTypes = "id-it-signKeyPairTypes";
pub const NID_id_it_signKeyPairTypes = @as(c_int, 299);
pub const OBJ_id_it_signKeyPairTypes = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 2);
};
pub const SN_id_it_encKeyPairTypes = "id-it-encKeyPairTypes";
pub const NID_id_it_encKeyPairTypes = @as(c_int, 300);
pub const OBJ_id_it_encKeyPairTypes = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 3);
};
pub const SN_id_it_preferredSymmAlg = "id-it-preferredSymmAlg";
pub const NID_id_it_preferredSymmAlg = @as(c_int, 301);
pub const OBJ_id_it_preferredSymmAlg = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 4);
};
pub const SN_id_it_caKeyUpdateInfo = "id-it-caKeyUpdateInfo";
pub const NID_id_it_caKeyUpdateInfo = @as(c_int, 302);
pub const OBJ_id_it_caKeyUpdateInfo = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 5);
};
pub const SN_id_it_currentCRL = "id-it-currentCRL";
pub const NID_id_it_currentCRL = @as(c_int, 303);
pub const OBJ_id_it_currentCRL = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 6);
};
pub const SN_id_it_unsupportedOIDs = "id-it-unsupportedOIDs";
pub const NID_id_it_unsupportedOIDs = @as(c_int, 304);
pub const OBJ_id_it_unsupportedOIDs = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 7);
};
pub const SN_id_it_subscriptionRequest = "id-it-subscriptionRequest";
pub const NID_id_it_subscriptionRequest = @as(c_int, 305);
pub const OBJ_id_it_subscriptionRequest = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 8);
};
pub const SN_id_it_subscriptionResponse = "id-it-subscriptionResponse";
pub const NID_id_it_subscriptionResponse = @as(c_int, 306);
pub const OBJ_id_it_subscriptionResponse = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 9);
};
pub const SN_id_it_keyPairParamReq = "id-it-keyPairParamReq";
pub const NID_id_it_keyPairParamReq = @as(c_int, 307);
pub const OBJ_id_it_keyPairParamReq = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 10);
};
pub const SN_id_it_keyPairParamRep = "id-it-keyPairParamRep";
pub const NID_id_it_keyPairParamRep = @as(c_int, 308);
pub const OBJ_id_it_keyPairParamRep = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 11);
};
pub const SN_id_it_revPassphrase = "id-it-revPassphrase";
pub const NID_id_it_revPassphrase = @as(c_int, 309);
pub const OBJ_id_it_revPassphrase = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 12);
};
pub const SN_id_it_implicitConfirm = "id-it-implicitConfirm";
pub const NID_id_it_implicitConfirm = @as(c_int, 310);
pub const OBJ_id_it_implicitConfirm = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 13);
};
pub const SN_id_it_confirmWaitTime = "id-it-confirmWaitTime";
pub const NID_id_it_confirmWaitTime = @as(c_int, 311);
pub const OBJ_id_it_confirmWaitTime = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 14);
};
pub const SN_id_it_origPKIMessage = "id-it-origPKIMessage";
pub const NID_id_it_origPKIMessage = @as(c_int, 312);
pub const OBJ_id_it_origPKIMessage = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 15);
};
pub const SN_id_it_suppLangTags = "id-it-suppLangTags";
pub const NID_id_it_suppLangTags = @as(c_int, 784);
pub const OBJ_id_it_suppLangTags = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 16);
};
pub const SN_id_it_caCerts = "id-it-caCerts";
pub const NID_id_it_caCerts = @as(c_int, 1223);
pub const OBJ_id_it_caCerts = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 17);
};
pub const SN_id_it_rootCaKeyUpdate = "id-it-rootCaKeyUpdate";
pub const NID_id_it_rootCaKeyUpdate = @as(c_int, 1224);
pub const OBJ_id_it_rootCaKeyUpdate = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 18);
};
pub const SN_id_it_certReqTemplate = "id-it-certReqTemplate";
pub const NID_id_it_certReqTemplate = @as(c_int, 1225);
pub const OBJ_id_it_certReqTemplate = blk: {
    _ = &OBJ_id_it;
    break :blk @as(c_long, 19);
};
pub const SN_id_regCtrl = "id-regCtrl";
pub const NID_id_regCtrl = @as(c_int, 313);
pub const OBJ_id_regCtrl = blk: {
    _ = &OBJ_id_pkip;
    break :blk @as(c_long, 1);
};
pub const SN_id_regInfo = "id-regInfo";
pub const NID_id_regInfo = @as(c_int, 314);
pub const OBJ_id_regInfo = blk: {
    _ = &OBJ_id_pkip;
    break :blk @as(c_long, 2);
};
pub const SN_id_regCtrl_regToken = "id-regCtrl-regToken";
pub const NID_id_regCtrl_regToken = @as(c_int, 315);
pub const OBJ_id_regCtrl_regToken = blk: {
    _ = &OBJ_id_regCtrl;
    break :blk @as(c_long, 1);
};
pub const SN_id_regCtrl_authenticator = "id-regCtrl-authenticator";
pub const NID_id_regCtrl_authenticator = @as(c_int, 316);
pub const OBJ_id_regCtrl_authenticator = blk: {
    _ = &OBJ_id_regCtrl;
    break :blk @as(c_long, 2);
};
pub const SN_id_regCtrl_pkiPublicationInfo = "id-regCtrl-pkiPublicationInfo";
pub const NID_id_regCtrl_pkiPublicationInfo = @as(c_int, 317);
pub const OBJ_id_regCtrl_pkiPublicationInfo = blk: {
    _ = &OBJ_id_regCtrl;
    break :blk @as(c_long, 3);
};
pub const SN_id_regCtrl_pkiArchiveOptions = "id-regCtrl-pkiArchiveOptions";
pub const NID_id_regCtrl_pkiArchiveOptions = @as(c_int, 318);
pub const OBJ_id_regCtrl_pkiArchiveOptions = blk: {
    _ = &OBJ_id_regCtrl;
    break :blk @as(c_long, 4);
};
pub const SN_id_regCtrl_oldCertID = "id-regCtrl-oldCertID";
pub const NID_id_regCtrl_oldCertID = @as(c_int, 319);
pub const OBJ_id_regCtrl_oldCertID = blk: {
    _ = &OBJ_id_regCtrl;
    break :blk @as(c_long, 5);
};
pub const SN_id_regCtrl_protocolEncrKey = "id-regCtrl-protocolEncrKey";
pub const NID_id_regCtrl_protocolEncrKey = @as(c_int, 320);
pub const OBJ_id_regCtrl_protocolEncrKey = blk: {
    _ = &OBJ_id_regCtrl;
    break :blk @as(c_long, 6);
};
pub const SN_id_regInfo_utf8Pairs = "id-regInfo-utf8Pairs";
pub const NID_id_regInfo_utf8Pairs = @as(c_int, 321);
pub const OBJ_id_regInfo_utf8Pairs = blk: {
    _ = &OBJ_id_regInfo;
    break :blk @as(c_long, 1);
};
pub const SN_id_regInfo_certReq = "id-regInfo-certReq";
pub const NID_id_regInfo_certReq = @as(c_int, 322);
pub const OBJ_id_regInfo_certReq = blk: {
    _ = &OBJ_id_regInfo;
    break :blk @as(c_long, 2);
};
pub const SN_id_alg_des40 = "id-alg-des40";
pub const NID_id_alg_des40 = @as(c_int, 323);
pub const OBJ_id_alg_des40 = blk: {
    _ = &OBJ_id_alg;
    break :blk @as(c_long, 1);
};
pub const SN_id_alg_noSignature = "id-alg-noSignature";
pub const NID_id_alg_noSignature = @as(c_int, 324);
pub const OBJ_id_alg_noSignature = blk: {
    _ = &OBJ_id_alg;
    break :blk @as(c_long, 2);
};
pub const SN_id_alg_dh_sig_hmac_sha1 = "id-alg-dh-sig-hmac-sha1";
pub const NID_id_alg_dh_sig_hmac_sha1 = @as(c_int, 325);
pub const OBJ_id_alg_dh_sig_hmac_sha1 = blk: {
    _ = &OBJ_id_alg;
    break :blk @as(c_long, 3);
};
pub const SN_id_alg_dh_pop = "id-alg-dh-pop";
pub const NID_id_alg_dh_pop = @as(c_int, 326);
pub const OBJ_id_alg_dh_pop = blk: {
    _ = &OBJ_id_alg;
    break :blk @as(c_long, 4);
};
pub const SN_id_cmc_statusInfo = "id-cmc-statusInfo";
pub const NID_id_cmc_statusInfo = @as(c_int, 327);
pub const OBJ_id_cmc_statusInfo = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 1);
};
pub const SN_id_cmc_identification = "id-cmc-identification";
pub const NID_id_cmc_identification = @as(c_int, 328);
pub const OBJ_id_cmc_identification = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 2);
};
pub const SN_id_cmc_identityProof = "id-cmc-identityProof";
pub const NID_id_cmc_identityProof = @as(c_int, 329);
pub const OBJ_id_cmc_identityProof = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 3);
};
pub const SN_id_cmc_dataReturn = "id-cmc-dataReturn";
pub const NID_id_cmc_dataReturn = @as(c_int, 330);
pub const OBJ_id_cmc_dataReturn = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 4);
};
pub const SN_id_cmc_transactionId = "id-cmc-transactionId";
pub const NID_id_cmc_transactionId = @as(c_int, 331);
pub const OBJ_id_cmc_transactionId = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 5);
};
pub const SN_id_cmc_senderNonce = "id-cmc-senderNonce";
pub const NID_id_cmc_senderNonce = @as(c_int, 332);
pub const OBJ_id_cmc_senderNonce = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 6);
};
pub const SN_id_cmc_recipientNonce = "id-cmc-recipientNonce";
pub const NID_id_cmc_recipientNonce = @as(c_int, 333);
pub const OBJ_id_cmc_recipientNonce = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 7);
};
pub const SN_id_cmc_addExtensions = "id-cmc-addExtensions";
pub const NID_id_cmc_addExtensions = @as(c_int, 334);
pub const OBJ_id_cmc_addExtensions = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 8);
};
pub const SN_id_cmc_encryptedPOP = "id-cmc-encryptedPOP";
pub const NID_id_cmc_encryptedPOP = @as(c_int, 335);
pub const OBJ_id_cmc_encryptedPOP = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 9);
};
pub const SN_id_cmc_decryptedPOP = "id-cmc-decryptedPOP";
pub const NID_id_cmc_decryptedPOP = @as(c_int, 336);
pub const OBJ_id_cmc_decryptedPOP = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 10);
};
pub const SN_id_cmc_lraPOPWitness = "id-cmc-lraPOPWitness";
pub const NID_id_cmc_lraPOPWitness = @as(c_int, 337);
pub const OBJ_id_cmc_lraPOPWitness = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 11);
};
pub const SN_id_cmc_getCert = "id-cmc-getCert";
pub const NID_id_cmc_getCert = @as(c_int, 338);
pub const OBJ_id_cmc_getCert = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 15);
};
pub const SN_id_cmc_getCRL = "id-cmc-getCRL";
pub const NID_id_cmc_getCRL = @as(c_int, 339);
pub const OBJ_id_cmc_getCRL = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 16);
};
pub const SN_id_cmc_revokeRequest = "id-cmc-revokeRequest";
pub const NID_id_cmc_revokeRequest = @as(c_int, 340);
pub const OBJ_id_cmc_revokeRequest = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 17);
};
pub const SN_id_cmc_regInfo = "id-cmc-regInfo";
pub const NID_id_cmc_regInfo = @as(c_int, 341);
pub const OBJ_id_cmc_regInfo = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 18);
};
pub const SN_id_cmc_responseInfo = "id-cmc-responseInfo";
pub const NID_id_cmc_responseInfo = @as(c_int, 342);
pub const OBJ_id_cmc_responseInfo = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 19);
};
pub const SN_id_cmc_queryPending = "id-cmc-queryPending";
pub const NID_id_cmc_queryPending = @as(c_int, 343);
pub const OBJ_id_cmc_queryPending = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 21);
};
pub const SN_id_cmc_popLinkRandom = "id-cmc-popLinkRandom";
pub const NID_id_cmc_popLinkRandom = @as(c_int, 344);
pub const OBJ_id_cmc_popLinkRandom = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 22);
};
pub const SN_id_cmc_popLinkWitness = "id-cmc-popLinkWitness";
pub const NID_id_cmc_popLinkWitness = @as(c_int, 345);
pub const OBJ_id_cmc_popLinkWitness = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 23);
};
pub const SN_id_cmc_confirmCertAcceptance = "id-cmc-confirmCertAcceptance";
pub const NID_id_cmc_confirmCertAcceptance = @as(c_int, 346);
pub const OBJ_id_cmc_confirmCertAcceptance = blk: {
    _ = &OBJ_id_cmc;
    break :blk @as(c_long, 24);
};
pub const SN_id_on_personalData = "id-on-personalData";
pub const NID_id_on_personalData = @as(c_int, 347);
pub const OBJ_id_on_personalData = blk: {
    _ = &OBJ_id_on;
    break :blk @as(c_long, 1);
};
pub const SN_id_on_permanentIdentifier = "id-on-permanentIdentifier";
pub const LN_id_on_permanentIdentifier = "Permanent Identifier";
pub const NID_id_on_permanentIdentifier = @as(c_int, 858);
pub const OBJ_id_on_permanentIdentifier = blk: {
    _ = &OBJ_id_on;
    break :blk @as(c_long, 3);
};
pub const SN_XmppAddr = "id-on-xmppAddr";
pub const LN_XmppAddr = "XmppAddr";
pub const NID_XmppAddr = @as(c_int, 1209);
pub const OBJ_XmppAddr = blk: {
    _ = &OBJ_id_on;
    break :blk @as(c_long, 5);
};
pub const SN_SRVName = "id-on-dnsSRV";
pub const LN_SRVName = "SRVName";
pub const NID_SRVName = @as(c_int, 1210);
pub const OBJ_SRVName = blk: {
    _ = &OBJ_id_on;
    break :blk @as(c_long, 7);
};
pub const SN_NAIRealm = "id-on-NAIRealm";
pub const LN_NAIRealm = "NAIRealm";
pub const NID_NAIRealm = @as(c_int, 1211);
pub const OBJ_NAIRealm = blk: {
    _ = &OBJ_id_on;
    break :blk @as(c_long, 8);
};
pub const SN_id_on_SmtpUTF8Mailbox = "id-on-SmtpUTF8Mailbox";
pub const LN_id_on_SmtpUTF8Mailbox = "Smtp UTF8 Mailbox";
pub const NID_id_on_SmtpUTF8Mailbox = @as(c_int, 1208);
pub const OBJ_id_on_SmtpUTF8Mailbox = blk: {
    _ = &OBJ_id_on;
    break :blk @as(c_long, 9);
};
pub const SN_id_pda_dateOfBirth = "id-pda-dateOfBirth";
pub const NID_id_pda_dateOfBirth = @as(c_int, 348);
pub const OBJ_id_pda_dateOfBirth = blk: {
    _ = &OBJ_id_pda;
    break :blk @as(c_long, 1);
};
pub const SN_id_pda_placeOfBirth = "id-pda-placeOfBirth";
pub const NID_id_pda_placeOfBirth = @as(c_int, 349);
pub const OBJ_id_pda_placeOfBirth = blk: {
    _ = &OBJ_id_pda;
    break :blk @as(c_long, 2);
};
pub const SN_id_pda_gender = "id-pda-gender";
pub const NID_id_pda_gender = @as(c_int, 351);
pub const OBJ_id_pda_gender = blk: {
    _ = &OBJ_id_pda;
    break :blk @as(c_long, 3);
};
pub const SN_id_pda_countryOfCitizenship = "id-pda-countryOfCitizenship";
pub const NID_id_pda_countryOfCitizenship = @as(c_int, 352);
pub const OBJ_id_pda_countryOfCitizenship = blk: {
    _ = &OBJ_id_pda;
    break :blk @as(c_long, 4);
};
pub const SN_id_pda_countryOfResidence = "id-pda-countryOfResidence";
pub const NID_id_pda_countryOfResidence = @as(c_int, 353);
pub const OBJ_id_pda_countryOfResidence = blk: {
    _ = &OBJ_id_pda;
    break :blk @as(c_long, 5);
};
pub const SN_id_aca_authenticationInfo = "id-aca-authenticationInfo";
pub const NID_id_aca_authenticationInfo = @as(c_int, 354);
pub const OBJ_id_aca_authenticationInfo = blk: {
    _ = &OBJ_id_aca;
    break :blk @as(c_long, 1);
};
pub const SN_id_aca_accessIdentity = "id-aca-accessIdentity";
pub const NID_id_aca_accessIdentity = @as(c_int, 355);
pub const OBJ_id_aca_accessIdentity = blk: {
    _ = &OBJ_id_aca;
    break :blk @as(c_long, 2);
};
pub const SN_id_aca_chargingIdentity = "id-aca-chargingIdentity";
pub const NID_id_aca_chargingIdentity = @as(c_int, 356);
pub const OBJ_id_aca_chargingIdentity = blk: {
    _ = &OBJ_id_aca;
    break :blk @as(c_long, 3);
};
pub const SN_id_aca_group = "id-aca-group";
pub const NID_id_aca_group = @as(c_int, 357);
pub const OBJ_id_aca_group = blk: {
    _ = &OBJ_id_aca;
    break :blk @as(c_long, 4);
};
pub const SN_id_aca_role = "id-aca-role";
pub const NID_id_aca_role = @as(c_int, 358);
pub const OBJ_id_aca_role = blk: {
    _ = &OBJ_id_aca;
    break :blk @as(c_long, 5);
};
pub const SN_id_aca_encAttrs = "id-aca-encAttrs";
pub const NID_id_aca_encAttrs = @as(c_int, 399);
pub const OBJ_id_aca_encAttrs = blk: {
    _ = &OBJ_id_aca;
    break :blk @as(c_long, 6);
};
pub const SN_id_qcs_pkixQCSyntax_v1 = "id-qcs-pkixQCSyntax-v1";
pub const NID_id_qcs_pkixQCSyntax_v1 = @as(c_int, 359);
pub const OBJ_id_qcs_pkixQCSyntax_v1 = blk: {
    _ = &OBJ_id_qcs;
    break :blk @as(c_long, 1);
};
pub const SN_ipAddr_asNumber = "ipAddr-asNumber";
pub const NID_ipAddr_asNumber = @as(c_int, 1241);
pub const OBJ_ipAddr_asNumber = blk: {
    _ = &OBJ_id_cp;
    break :blk @as(c_long, 2);
};
pub const SN_ipAddr_asNumberv2 = "ipAddr-asNumberv2";
pub const NID_ipAddr_asNumberv2 = @as(c_int, 1242);
pub const OBJ_ipAddr_asNumberv2 = blk: {
    _ = &OBJ_id_cp;
    break :blk @as(c_long, 3);
};
pub const SN_id_cct_crs = "id-cct-crs";
pub const NID_id_cct_crs = @as(c_int, 360);
pub const OBJ_id_cct_crs = blk: {
    _ = &OBJ_id_cct;
    break :blk @as(c_long, 1);
};
pub const SN_id_cct_PKIData = "id-cct-PKIData";
pub const NID_id_cct_PKIData = @as(c_int, 361);
pub const OBJ_id_cct_PKIData = blk: {
    _ = &OBJ_id_cct;
    break :blk @as(c_long, 2);
};
pub const SN_id_cct_PKIResponse = "id-cct-PKIResponse";
pub const NID_id_cct_PKIResponse = @as(c_int, 362);
pub const OBJ_id_cct_PKIResponse = blk: {
    _ = &OBJ_id_cct;
    break :blk @as(c_long, 3);
};
pub const SN_id_ppl_anyLanguage = "id-ppl-anyLanguage";
pub const LN_id_ppl_anyLanguage = "Any language";
pub const NID_id_ppl_anyLanguage = @as(c_int, 664);
pub const OBJ_id_ppl_anyLanguage = blk: {
    _ = &OBJ_id_ppl;
    break :blk @as(c_long, 0);
};
pub const SN_id_ppl_inheritAll = "id-ppl-inheritAll";
pub const LN_id_ppl_inheritAll = "Inherit all";
pub const NID_id_ppl_inheritAll = @as(c_int, 665);
pub const OBJ_id_ppl_inheritAll = blk: {
    _ = &OBJ_id_ppl;
    break :blk @as(c_long, 1);
};
pub const SN_Independent = "id-ppl-independent";
pub const LN_Independent = "Independent";
pub const NID_Independent = @as(c_int, 667);
pub const OBJ_Independent = blk: {
    _ = &OBJ_id_ppl;
    break :blk @as(c_long, 2);
};
pub const SN_ad_OCSP = "OCSP";
pub const LN_ad_OCSP = "OCSP";
pub const NID_ad_OCSP = @as(c_int, 178);
pub const OBJ_ad_OCSP = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 1);
};
pub const SN_ad_ca_issuers = "caIssuers";
pub const LN_ad_ca_issuers = "CA Issuers";
pub const NID_ad_ca_issuers = @as(c_int, 179);
pub const OBJ_ad_ca_issuers = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 2);
};
pub const SN_ad_timeStamping = "ad_timestamping";
pub const LN_ad_timeStamping = "AD Time Stamping";
pub const NID_ad_timeStamping = @as(c_int, 363);
pub const OBJ_ad_timeStamping = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 3);
};
pub const SN_ad_dvcs = "AD_DVCS";
pub const LN_ad_dvcs = "ad dvcs";
pub const NID_ad_dvcs = @as(c_int, 364);
pub const OBJ_ad_dvcs = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 4);
};
pub const SN_caRepository = "caRepository";
pub const LN_caRepository = "CA Repository";
pub const NID_caRepository = @as(c_int, 785);
pub const OBJ_caRepository = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 5);
};
pub const SN_rpkiManifest = "rpkiManifest";
pub const LN_rpkiManifest = "RPKI Manifest";
pub const NID_rpkiManifest = @as(c_int, 1243);
pub const OBJ_rpkiManifest = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 10);
};
pub const SN_signedObject = "signedObject";
pub const LN_signedObject = "Signed Object";
pub const NID_signedObject = @as(c_int, 1244);
pub const OBJ_signedObject = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 11);
};
pub const SN_rpkiNotify = "rpkiNotify";
pub const LN_rpkiNotify = "RPKI Notify";
pub const NID_rpkiNotify = @as(c_int, 1245);
pub const OBJ_rpkiNotify = blk: {
    _ = &OBJ_id_ad;
    break :blk @as(c_long, 13);
};
pub const OBJ_id_pkix_OCSP = OBJ_ad_OCSP;
pub const SN_id_pkix_OCSP_basic = "basicOCSPResponse";
pub const LN_id_pkix_OCSP_basic = "Basic OCSP Response";
pub const NID_id_pkix_OCSP_basic = @as(c_int, 365);
pub const OBJ_id_pkix_OCSP_basic = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 1);
};
pub const SN_id_pkix_OCSP_Nonce = "Nonce";
pub const LN_id_pkix_OCSP_Nonce = "OCSP Nonce";
pub const NID_id_pkix_OCSP_Nonce = @as(c_int, 366);
pub const OBJ_id_pkix_OCSP_Nonce = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 2);
};
pub const SN_id_pkix_OCSP_CrlID = "CrlID";
pub const LN_id_pkix_OCSP_CrlID = "OCSP CRL ID";
pub const NID_id_pkix_OCSP_CrlID = @as(c_int, 367);
pub const OBJ_id_pkix_OCSP_CrlID = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 3);
};
pub const SN_id_pkix_OCSP_acceptableResponses = "acceptableResponses";
pub const LN_id_pkix_OCSP_acceptableResponses = "Acceptable OCSP Responses";
pub const NID_id_pkix_OCSP_acceptableResponses = @as(c_int, 368);
pub const OBJ_id_pkix_OCSP_acceptableResponses = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 4);
};
pub const SN_id_pkix_OCSP_noCheck = "noCheck";
pub const LN_id_pkix_OCSP_noCheck = "OCSP No Check";
pub const NID_id_pkix_OCSP_noCheck = @as(c_int, 369);
pub const OBJ_id_pkix_OCSP_noCheck = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 5);
};
pub const SN_id_pkix_OCSP_archiveCutoff = "archiveCutoff";
pub const LN_id_pkix_OCSP_archiveCutoff = "OCSP Archive Cutoff";
pub const NID_id_pkix_OCSP_archiveCutoff = @as(c_int, 370);
pub const OBJ_id_pkix_OCSP_archiveCutoff = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 6);
};
pub const SN_id_pkix_OCSP_serviceLocator = "serviceLocator";
pub const LN_id_pkix_OCSP_serviceLocator = "OCSP Service Locator";
pub const NID_id_pkix_OCSP_serviceLocator = @as(c_int, 371);
pub const OBJ_id_pkix_OCSP_serviceLocator = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 7);
};
pub const SN_id_pkix_OCSP_extendedStatus = "extendedStatus";
pub const LN_id_pkix_OCSP_extendedStatus = "Extended OCSP Status";
pub const NID_id_pkix_OCSP_extendedStatus = @as(c_int, 372);
pub const OBJ_id_pkix_OCSP_extendedStatus = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 8);
};
pub const SN_id_pkix_OCSP_valid = "valid";
pub const NID_id_pkix_OCSP_valid = @as(c_int, 373);
pub const OBJ_id_pkix_OCSP_valid = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 9);
};
pub const SN_id_pkix_OCSP_path = "path";
pub const NID_id_pkix_OCSP_path = @as(c_int, 374);
pub const OBJ_id_pkix_OCSP_path = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 10);
};
pub const SN_id_pkix_OCSP_trustRoot = "trustRoot";
pub const LN_id_pkix_OCSP_trustRoot = "Trust Root";
pub const NID_id_pkix_OCSP_trustRoot = @as(c_int, 375);
pub const OBJ_id_pkix_OCSP_trustRoot = blk: {
    _ = &OBJ_id_pkix_OCSP;
    break :blk @as(c_long, 11);
};
pub const SN_algorithm = "algorithm";
pub const LN_algorithm = "algorithm";
pub const NID_algorithm = @as(c_int, 376);
pub const OBJ_algorithm = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 14);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 2);
};
pub const SN_md5WithRSA = "RSA-NP-MD5";
pub const LN_md5WithRSA = "md5WithRSA";
pub const NID_md5WithRSA = @as(c_int, 104);
pub const OBJ_md5WithRSA = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 3);
};
pub const SN_des_ecb = "DES-ECB";
pub const LN_des_ecb = "des-ecb";
pub const NID_des_ecb = @as(c_int, 29);
pub const OBJ_des_ecb = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 6);
};
pub const SN_des_cbc = "DES-CBC";
pub const LN_des_cbc = "des-cbc";
pub const NID_des_cbc = @as(c_int, 31);
pub const OBJ_des_cbc = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 7);
};
pub const SN_des_ofb64 = "DES-OFB";
pub const LN_des_ofb64 = "des-ofb";
pub const NID_des_ofb64 = @as(c_int, 45);
pub const OBJ_des_ofb64 = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 8);
};
pub const SN_des_cfb64 = "DES-CFB";
pub const LN_des_cfb64 = "des-cfb";
pub const NID_des_cfb64 = @as(c_int, 30);
pub const OBJ_des_cfb64 = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 9);
};
pub const SN_rsaSignature = "rsaSignature";
pub const NID_rsaSignature = @as(c_int, 377);
pub const OBJ_rsaSignature = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 11);
};
pub const SN_dsa_2 = "DSA-old";
pub const LN_dsa_2 = "dsaEncryption-old";
pub const NID_dsa_2 = @as(c_int, 67);
pub const OBJ_dsa_2 = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 12);
};
pub const SN_dsaWithSHA = "DSA-SHA";
pub const LN_dsaWithSHA = "dsaWithSHA";
pub const NID_dsaWithSHA = @as(c_int, 66);
pub const OBJ_dsaWithSHA = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 13);
};
pub const SN_shaWithRSAEncryption = "RSA-SHA";
pub const LN_shaWithRSAEncryption = "shaWithRSAEncryption";
pub const NID_shaWithRSAEncryption = @as(c_int, 42);
pub const OBJ_shaWithRSAEncryption = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 15);
};
pub const SN_des_ede_ecb = "DES-EDE";
pub const LN_des_ede_ecb = "des-ede";
pub const NID_des_ede_ecb = @as(c_int, 32);
pub const OBJ_des_ede_ecb = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 17);
};
pub const SN_des_ede3_ecb = "DES-EDE3";
pub const LN_des_ede3_ecb = "des-ede3";
pub const NID_des_ede3_ecb = @as(c_int, 33);
pub const SN_des_ede_cbc = "DES-EDE-CBC";
pub const LN_des_ede_cbc = "des-ede-cbc";
pub const NID_des_ede_cbc = @as(c_int, 43);
pub const SN_des_ede_cfb64 = "DES-EDE-CFB";
pub const LN_des_ede_cfb64 = "des-ede-cfb";
pub const NID_des_ede_cfb64 = @as(c_int, 60);
pub const SN_des_ede3_cfb64 = "DES-EDE3-CFB";
pub const LN_des_ede3_cfb64 = "des-ede3-cfb";
pub const NID_des_ede3_cfb64 = @as(c_int, 61);
pub const SN_des_ede_ofb64 = "DES-EDE-OFB";
pub const LN_des_ede_ofb64 = "des-ede-ofb";
pub const NID_des_ede_ofb64 = @as(c_int, 62);
pub const SN_des_ede3_ofb64 = "DES-EDE3-OFB";
pub const LN_des_ede3_ofb64 = "des-ede3-ofb";
pub const NID_des_ede3_ofb64 = @as(c_int, 63);
pub const SN_desx_cbc = "DESX-CBC";
pub const LN_desx_cbc = "desx-cbc";
pub const NID_desx_cbc = @as(c_int, 80);
pub const SN_sha = "SHA";
pub const LN_sha = "sha";
pub const NID_sha = @as(c_int, 41);
pub const OBJ_sha = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 18);
};
pub const SN_sha1 = "SHA1";
pub const LN_sha1 = "sha1";
pub const NID_sha1 = @as(c_int, 64);
pub const OBJ_sha1 = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 26);
};
pub const SN_dsaWithSHA1_2 = "DSA-SHA1-old";
pub const LN_dsaWithSHA1_2 = "dsaWithSHA1-old";
pub const NID_dsaWithSHA1_2 = @as(c_int, 70);
pub const OBJ_dsaWithSHA1_2 = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 27);
};
pub const SN_sha1WithRSA = "RSA-SHA1-2";
pub const LN_sha1WithRSA = "sha1WithRSA";
pub const NID_sha1WithRSA = @as(c_int, 115);
pub const OBJ_sha1WithRSA = blk: {
    _ = &OBJ_algorithm;
    break :blk @as(c_long, 29);
};
pub const SN_ripemd160 = "RIPEMD160";
pub const LN_ripemd160 = "ripemd160";
pub const NID_ripemd160 = @as(c_int, 117);
pub const OBJ_ripemd160 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 1);
};
pub const SN_ripemd160WithRSA = "RSA-RIPEMD160";
pub const LN_ripemd160WithRSA = "ripemd160WithRSA";
pub const NID_ripemd160WithRSA = @as(c_int, 119);
pub const OBJ_ripemd160WithRSA = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_blake2bmac = "BLAKE2BMAC";
pub const LN_blake2bmac = "blake2bmac";
pub const NID_blake2bmac = @as(c_int, 1201);
pub const OBJ_blake2bmac = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1722);
    _ = @as(c_long, 12);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 1);
};
pub const SN_blake2smac = "BLAKE2SMAC";
pub const LN_blake2smac = "blake2smac";
pub const NID_blake2smac = @as(c_int, 1202);
pub const OBJ_blake2smac = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1722);
    _ = @as(c_long, 12);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 2);
};
pub const SN_blake2b512 = "BLAKE2b512";
pub const LN_blake2b512 = "blake2b512";
pub const NID_blake2b512 = @as(c_int, 1056);
pub const OBJ_blake2b512 = blk: {
    _ = &OBJ_blake2bmac;
    break :blk @as(c_long, 16);
};
pub const SN_blake2s256 = "BLAKE2s256";
pub const LN_blake2s256 = "blake2s256";
pub const NID_blake2s256 = @as(c_int, 1057);
pub const OBJ_blake2s256 = blk: {
    _ = &OBJ_blake2smac;
    break :blk @as(c_long, 8);
};
pub const SN_sxnet = "SXNetID";
pub const LN_sxnet = "Strong Extranet ID";
pub const NID_sxnet = @as(c_int, 143);
pub const OBJ_sxnet = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 101);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    break :blk @as(c_long, 1);
};
pub const SN_X500 = "X500";
pub const LN_X500 = "directory services (X.500)";
pub const NID_X500 = @as(c_int, 11);
pub const OBJ_X500 = blk: {
    _ = @as(c_long, 2);
    break :blk @as(c_long, 5);
};
pub const SN_X509 = "X509";
pub const NID_X509 = @as(c_int, 12);
pub const OBJ_X509 = blk: {
    _ = &OBJ_X500;
    break :blk @as(c_long, 4);
};
pub const SN_commonName = "CN";
pub const LN_commonName = "commonName";
pub const NID_commonName = @as(c_int, 13);
pub const OBJ_commonName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 3);
};
pub const SN_surname = "SN";
pub const LN_surname = "surname";
pub const NID_surname = @as(c_int, 100);
pub const OBJ_surname = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 4);
};
pub const LN_serialNumber = "serialNumber";
pub const NID_serialNumber = @as(c_int, 105);
pub const OBJ_serialNumber = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 5);
};
pub const SN_countryName = "C";
pub const LN_countryName = "countryName";
pub const NID_countryName = @as(c_int, 14);
pub const OBJ_countryName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 6);
};
pub const SN_localityName = "L";
pub const LN_localityName = "localityName";
pub const NID_localityName = @as(c_int, 15);
pub const OBJ_localityName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 7);
};
pub const SN_stateOrProvinceName = "ST";
pub const LN_stateOrProvinceName = "stateOrProvinceName";
pub const NID_stateOrProvinceName = @as(c_int, 16);
pub const OBJ_stateOrProvinceName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 8);
};
pub const SN_streetAddress = "street";
pub const LN_streetAddress = "streetAddress";
pub const NID_streetAddress = @as(c_int, 660);
pub const OBJ_streetAddress = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 9);
};
pub const SN_organizationName = "O";
pub const LN_organizationName = "organizationName";
pub const NID_organizationName = @as(c_int, 17);
pub const OBJ_organizationName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 10);
};
pub const SN_organizationalUnitName = "OU";
pub const LN_organizationalUnitName = "organizationalUnitName";
pub const NID_organizationalUnitName = @as(c_int, 18);
pub const OBJ_organizationalUnitName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 11);
};
pub const SN_title = "title";
pub const LN_title = "title";
pub const NID_title = @as(c_int, 106);
pub const OBJ_title = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 12);
};
pub const LN_description = "description";
pub const NID_description = @as(c_int, 107);
pub const OBJ_description = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 13);
};
pub const LN_searchGuide = "searchGuide";
pub const NID_searchGuide = @as(c_int, 859);
pub const OBJ_searchGuide = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 14);
};
pub const LN_businessCategory = "businessCategory";
pub const NID_businessCategory = @as(c_int, 860);
pub const OBJ_businessCategory = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 15);
};
pub const LN_postalAddress = "postalAddress";
pub const NID_postalAddress = @as(c_int, 861);
pub const OBJ_postalAddress = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 16);
};
pub const LN_postalCode = "postalCode";
pub const NID_postalCode = @as(c_int, 661);
pub const OBJ_postalCode = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 17);
};
pub const LN_postOfficeBox = "postOfficeBox";
pub const NID_postOfficeBox = @as(c_int, 862);
pub const OBJ_postOfficeBox = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 18);
};
pub const LN_physicalDeliveryOfficeName = "physicalDeliveryOfficeName";
pub const NID_physicalDeliveryOfficeName = @as(c_int, 863);
pub const OBJ_physicalDeliveryOfficeName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 19);
};
pub const LN_telephoneNumber = "telephoneNumber";
pub const NID_telephoneNumber = @as(c_int, 864);
pub const OBJ_telephoneNumber = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 20);
};
pub const LN_telexNumber = "telexNumber";
pub const NID_telexNumber = @as(c_int, 865);
pub const OBJ_telexNumber = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 21);
};
pub const LN_teletexTerminalIdentifier = "teletexTerminalIdentifier";
pub const NID_teletexTerminalIdentifier = @as(c_int, 866);
pub const OBJ_teletexTerminalIdentifier = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 22);
};
pub const LN_facsimileTelephoneNumber = "facsimileTelephoneNumber";
pub const NID_facsimileTelephoneNumber = @as(c_int, 867);
pub const OBJ_facsimileTelephoneNumber = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 23);
};
pub const LN_x121Address = "x121Address";
pub const NID_x121Address = @as(c_int, 868);
pub const OBJ_x121Address = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 24);
};
pub const LN_internationaliSDNNumber = "internationaliSDNNumber";
pub const NID_internationaliSDNNumber = @as(c_int, 869);
pub const OBJ_internationaliSDNNumber = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 25);
};
pub const LN_registeredAddress = "registeredAddress";
pub const NID_registeredAddress = @as(c_int, 870);
pub const OBJ_registeredAddress = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 26);
};
pub const LN_destinationIndicator = "destinationIndicator";
pub const NID_destinationIndicator = @as(c_int, 871);
pub const OBJ_destinationIndicator = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 27);
};
pub const LN_preferredDeliveryMethod = "preferredDeliveryMethod";
pub const NID_preferredDeliveryMethod = @as(c_int, 872);
pub const OBJ_preferredDeliveryMethod = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 28);
};
pub const LN_presentationAddress = "presentationAddress";
pub const NID_presentationAddress = @as(c_int, 873);
pub const OBJ_presentationAddress = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 29);
};
pub const LN_supportedApplicationContext = "supportedApplicationContext";
pub const NID_supportedApplicationContext = @as(c_int, 874);
pub const OBJ_supportedApplicationContext = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 30);
};
pub const SN_member = "member";
pub const NID_member = @as(c_int, 875);
pub const OBJ_member = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 31);
};
pub const SN_owner = "owner";
pub const NID_owner = @as(c_int, 876);
pub const OBJ_owner = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 32);
};
pub const LN_roleOccupant = "roleOccupant";
pub const NID_roleOccupant = @as(c_int, 877);
pub const OBJ_roleOccupant = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 33);
};
pub const SN_seeAlso = "seeAlso";
pub const NID_seeAlso = @as(c_int, 878);
pub const OBJ_seeAlso = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 34);
};
pub const LN_userPassword = "userPassword";
pub const NID_userPassword = @as(c_int, 879);
pub const OBJ_userPassword = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 35);
};
pub const LN_userCertificate = "userCertificate";
pub const NID_userCertificate = @as(c_int, 880);
pub const OBJ_userCertificate = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 36);
};
pub const LN_cACertificate = "cACertificate";
pub const NID_cACertificate = @as(c_int, 881);
pub const OBJ_cACertificate = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 37);
};
pub const LN_authorityRevocationList = "authorityRevocationList";
pub const NID_authorityRevocationList = @as(c_int, 882);
pub const OBJ_authorityRevocationList = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 38);
};
pub const LN_certificateRevocationList = "certificateRevocationList";
pub const NID_certificateRevocationList = @as(c_int, 883);
pub const OBJ_certificateRevocationList = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 39);
};
pub const LN_crossCertificatePair = "crossCertificatePair";
pub const NID_crossCertificatePair = @as(c_int, 884);
pub const OBJ_crossCertificatePair = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 40);
};
pub const SN_name = "name";
pub const LN_name = "name";
pub const NID_name = @as(c_int, 173);
pub const OBJ_name = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 41);
};
pub const SN_givenName = "GN";
pub const LN_givenName = "givenName";
pub const NID_givenName = @as(c_int, 99);
pub const OBJ_givenName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 42);
};
pub const SN_initials = "initials";
pub const LN_initials = "initials";
pub const NID_initials = @as(c_int, 101);
pub const OBJ_initials = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 43);
};
pub const LN_generationQualifier = "generationQualifier";
pub const NID_generationQualifier = @as(c_int, 509);
pub const OBJ_generationQualifier = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 44);
};
pub const LN_x500UniqueIdentifier = "x500UniqueIdentifier";
pub const NID_x500UniqueIdentifier = @as(c_int, 503);
pub const OBJ_x500UniqueIdentifier = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 45);
};
pub const SN_dnQualifier = "dnQualifier";
pub const LN_dnQualifier = "dnQualifier";
pub const NID_dnQualifier = @as(c_int, 174);
pub const OBJ_dnQualifier = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 46);
};
pub const LN_enhancedSearchGuide = "enhancedSearchGuide";
pub const NID_enhancedSearchGuide = @as(c_int, 885);
pub const OBJ_enhancedSearchGuide = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 47);
};
pub const LN_protocolInformation = "protocolInformation";
pub const NID_protocolInformation = @as(c_int, 886);
pub const OBJ_protocolInformation = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 48);
};
pub const LN_distinguishedName = "distinguishedName";
pub const NID_distinguishedName = @as(c_int, 887);
pub const OBJ_distinguishedName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 49);
};
pub const LN_uniqueMember = "uniqueMember";
pub const NID_uniqueMember = @as(c_int, 888);
pub const OBJ_uniqueMember = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 50);
};
pub const LN_houseIdentifier = "houseIdentifier";
pub const NID_houseIdentifier = @as(c_int, 889);
pub const OBJ_houseIdentifier = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 51);
};
pub const LN_supportedAlgorithms = "supportedAlgorithms";
pub const NID_supportedAlgorithms = @as(c_int, 890);
pub const OBJ_supportedAlgorithms = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 52);
};
pub const LN_deltaRevocationList = "deltaRevocationList";
pub const NID_deltaRevocationList = @as(c_int, 891);
pub const OBJ_deltaRevocationList = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 53);
};
pub const SN_dmdName = "dmdName";
pub const NID_dmdName = @as(c_int, 892);
pub const OBJ_dmdName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 54);
};
pub const LN_pseudonym = "pseudonym";
pub const NID_pseudonym = @as(c_int, 510);
pub const OBJ_pseudonym = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 65);
};
pub const SN_role = "role";
pub const LN_role = "role";
pub const NID_role = @as(c_int, 400);
pub const OBJ_role = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 72);
};
pub const LN_organizationIdentifier = "organizationIdentifier";
pub const NID_organizationIdentifier = @as(c_int, 1089);
pub const OBJ_organizationIdentifier = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 97);
};
pub const SN_countryCode3c = "c3";
pub const LN_countryCode3c = "countryCode3c";
pub const NID_countryCode3c = @as(c_int, 1090);
pub const OBJ_countryCode3c = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 98);
};
pub const SN_countryCode3n = "n3";
pub const LN_countryCode3n = "countryCode3n";
pub const NID_countryCode3n = @as(c_int, 1091);
pub const OBJ_countryCode3n = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 99);
};
pub const LN_dnsName = "dnsName";
pub const NID_dnsName = @as(c_int, 1092);
pub const OBJ_dnsName = blk: {
    _ = &OBJ_X509;
    break :blk @as(c_long, 100);
};
pub const SN_X500algorithms = "X500algorithms";
pub const LN_X500algorithms = "directory services - algorithms";
pub const NID_X500algorithms = @as(c_int, 378);
pub const OBJ_X500algorithms = blk: {
    _ = &OBJ_X500;
    break :blk @as(c_long, 8);
};
pub const SN_rsa = "RSA";
pub const LN_rsa = "rsa";
pub const NID_rsa = @as(c_int, 19);
pub const OBJ_rsa = blk: {
    _ = &OBJ_X500algorithms;
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_mdc2WithRSA = "RSA-MDC2";
pub const LN_mdc2WithRSA = "mdc2WithRSA";
pub const NID_mdc2WithRSA = @as(c_int, 96);
pub const OBJ_mdc2WithRSA = blk: {
    _ = &OBJ_X500algorithms;
    _ = @as(c_long, 3);
    break :blk @as(c_long, 100);
};
pub const SN_mdc2 = "MDC2";
pub const LN_mdc2 = "mdc2";
pub const NID_mdc2 = @as(c_int, 95);
pub const OBJ_mdc2 = blk: {
    _ = &OBJ_X500algorithms;
    _ = @as(c_long, 3);
    break :blk @as(c_long, 101);
};
pub const SN_id_ce = "id-ce";
pub const NID_id_ce = @as(c_int, 81);
pub const OBJ_id_ce = blk: {
    _ = &OBJ_X500;
    break :blk @as(c_long, 29);
};
pub const SN_subject_directory_attributes = "subjectDirectoryAttributes";
pub const LN_subject_directory_attributes = "X509v3 Subject Directory Attributes";
pub const NID_subject_directory_attributes = @as(c_int, 769);
pub const OBJ_subject_directory_attributes = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 9);
};
pub const SN_subject_key_identifier = "subjectKeyIdentifier";
pub const LN_subject_key_identifier = "X509v3 Subject Key Identifier";
pub const NID_subject_key_identifier = @as(c_int, 82);
pub const OBJ_subject_key_identifier = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 14);
};
pub const SN_key_usage = "keyUsage";
pub const LN_key_usage = "X509v3 Key Usage";
pub const NID_key_usage = @as(c_int, 83);
pub const OBJ_key_usage = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 15);
};
pub const SN_private_key_usage_period = "privateKeyUsagePeriod";
pub const LN_private_key_usage_period = "X509v3 Private Key Usage Period";
pub const NID_private_key_usage_period = @as(c_int, 84);
pub const OBJ_private_key_usage_period = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 16);
};
pub const SN_subject_alt_name = "subjectAltName";
pub const LN_subject_alt_name = "X509v3 Subject Alternative Name";
pub const NID_subject_alt_name = @as(c_int, 85);
pub const OBJ_subject_alt_name = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 17);
};
pub const SN_issuer_alt_name = "issuerAltName";
pub const LN_issuer_alt_name = "X509v3 Issuer Alternative Name";
pub const NID_issuer_alt_name = @as(c_int, 86);
pub const OBJ_issuer_alt_name = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 18);
};
pub const SN_basic_constraints = "basicConstraints";
pub const LN_basic_constraints = "X509v3 Basic Constraints";
pub const NID_basic_constraints = @as(c_int, 87);
pub const OBJ_basic_constraints = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 19);
};
pub const SN_crl_number = "crlNumber";
pub const LN_crl_number = "X509v3 CRL Number";
pub const NID_crl_number = @as(c_int, 88);
pub const OBJ_crl_number = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 20);
};
pub const SN_crl_reason = "CRLReason";
pub const LN_crl_reason = "X509v3 CRL Reason Code";
pub const NID_crl_reason = @as(c_int, 141);
pub const OBJ_crl_reason = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 21);
};
pub const SN_invalidity_date = "invalidityDate";
pub const LN_invalidity_date = "Invalidity Date";
pub const NID_invalidity_date = @as(c_int, 142);
pub const OBJ_invalidity_date = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 24);
};
pub const SN_delta_crl = "deltaCRL";
pub const LN_delta_crl = "X509v3 Delta CRL Indicator";
pub const NID_delta_crl = @as(c_int, 140);
pub const OBJ_delta_crl = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 27);
};
pub const SN_issuing_distribution_point = "issuingDistributionPoint";
pub const LN_issuing_distribution_point = "X509v3 Issuing Distribution Point";
pub const NID_issuing_distribution_point = @as(c_int, 770);
pub const OBJ_issuing_distribution_point = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 28);
};
pub const SN_certificate_issuer = "certificateIssuer";
pub const LN_certificate_issuer = "X509v3 Certificate Issuer";
pub const NID_certificate_issuer = @as(c_int, 771);
pub const OBJ_certificate_issuer = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 29);
};
pub const SN_name_constraints = "nameConstraints";
pub const LN_name_constraints = "X509v3 Name Constraints";
pub const NID_name_constraints = @as(c_int, 666);
pub const OBJ_name_constraints = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 30);
};
pub const SN_crl_distribution_points = "crlDistributionPoints";
pub const LN_crl_distribution_points = "X509v3 CRL Distribution Points";
pub const NID_crl_distribution_points = @as(c_int, 103);
pub const OBJ_crl_distribution_points = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 31);
};
pub const SN_certificate_policies = "certificatePolicies";
pub const LN_certificate_policies = "X509v3 Certificate Policies";
pub const NID_certificate_policies = @as(c_int, 89);
pub const OBJ_certificate_policies = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 32);
};
pub const SN_any_policy = "anyPolicy";
pub const LN_any_policy = "X509v3 Any Policy";
pub const NID_any_policy = @as(c_int, 746);
pub const OBJ_any_policy = blk: {
    _ = &OBJ_certificate_policies;
    break :blk @as(c_long, 0);
};
pub const SN_policy_mappings = "policyMappings";
pub const LN_policy_mappings = "X509v3 Policy Mappings";
pub const NID_policy_mappings = @as(c_int, 747);
pub const OBJ_policy_mappings = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 33);
};
pub const SN_authority_key_identifier = "authorityKeyIdentifier";
pub const LN_authority_key_identifier = "X509v3 Authority Key Identifier";
pub const NID_authority_key_identifier = @as(c_int, 90);
pub const OBJ_authority_key_identifier = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 35);
};
pub const SN_policy_constraints = "policyConstraints";
pub const LN_policy_constraints = "X509v3 Policy Constraints";
pub const NID_policy_constraints = @as(c_int, 401);
pub const OBJ_policy_constraints = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 36);
};
pub const SN_ext_key_usage = "extendedKeyUsage";
pub const LN_ext_key_usage = "X509v3 Extended Key Usage";
pub const NID_ext_key_usage = @as(c_int, 126);
pub const OBJ_ext_key_usage = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 37);
};
pub const SN_freshest_crl = "freshestCRL";
pub const LN_freshest_crl = "X509v3 Freshest CRL";
pub const NID_freshest_crl = @as(c_int, 857);
pub const OBJ_freshest_crl = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 46);
};
pub const SN_inhibit_any_policy = "inhibitAnyPolicy";
pub const LN_inhibit_any_policy = "X509v3 Inhibit Any Policy";
pub const NID_inhibit_any_policy = @as(c_int, 748);
pub const OBJ_inhibit_any_policy = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 54);
};
pub const SN_target_information = "targetInformation";
pub const LN_target_information = "X509v3 AC Targeting";
pub const NID_target_information = @as(c_int, 402);
pub const OBJ_target_information = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 55);
};
pub const SN_no_rev_avail = "noRevAvail";
pub const LN_no_rev_avail = "X509v3 No Revocation Available";
pub const NID_no_rev_avail = @as(c_int, 403);
pub const OBJ_no_rev_avail = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 56);
};
pub const SN_anyExtendedKeyUsage = "anyExtendedKeyUsage";
pub const LN_anyExtendedKeyUsage = "Any Extended Key Usage";
pub const NID_anyExtendedKeyUsage = @as(c_int, 910);
pub const OBJ_anyExtendedKeyUsage = blk: {
    _ = &OBJ_ext_key_usage;
    break :blk @as(c_long, 0);
};
pub const SN_netscape = "Netscape";
pub const LN_netscape = "Netscape Communications Corp.";
pub const NID_netscape = @as(c_int, 57);
pub const OBJ_netscape = blk: {
    _ = @as(c_long, 2);
    _ = @as(c_long, 16);
    _ = @as(c_long, 840);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 113730);
};
pub const SN_netscape_cert_extension = "nsCertExt";
pub const LN_netscape_cert_extension = "Netscape Certificate Extension";
pub const NID_netscape_cert_extension = @as(c_int, 58);
pub const OBJ_netscape_cert_extension = blk: {
    _ = &OBJ_netscape;
    break :blk @as(c_long, 1);
};
pub const SN_netscape_data_type = "nsDataType";
pub const LN_netscape_data_type = "Netscape Data Type";
pub const NID_netscape_data_type = @as(c_int, 59);
pub const OBJ_netscape_data_type = blk: {
    _ = &OBJ_netscape;
    break :blk @as(c_long, 2);
};
pub const SN_netscape_cert_type = "nsCertType";
pub const LN_netscape_cert_type = "Netscape Cert Type";
pub const NID_netscape_cert_type = @as(c_int, 71);
pub const OBJ_netscape_cert_type = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 1);
};
pub const SN_netscape_base_url = "nsBaseUrl";
pub const LN_netscape_base_url = "Netscape Base Url";
pub const NID_netscape_base_url = @as(c_int, 72);
pub const OBJ_netscape_base_url = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 2);
};
pub const SN_netscape_revocation_url = "nsRevocationUrl";
pub const LN_netscape_revocation_url = "Netscape Revocation Url";
pub const NID_netscape_revocation_url = @as(c_int, 73);
pub const OBJ_netscape_revocation_url = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 3);
};
pub const SN_netscape_ca_revocation_url = "nsCaRevocationUrl";
pub const LN_netscape_ca_revocation_url = "Netscape CA Revocation Url";
pub const NID_netscape_ca_revocation_url = @as(c_int, 74);
pub const OBJ_netscape_ca_revocation_url = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 4);
};
pub const SN_netscape_renewal_url = "nsRenewalUrl";
pub const LN_netscape_renewal_url = "Netscape Renewal Url";
pub const NID_netscape_renewal_url = @as(c_int, 75);
pub const OBJ_netscape_renewal_url = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 7);
};
pub const SN_netscape_ca_policy_url = "nsCaPolicyUrl";
pub const LN_netscape_ca_policy_url = "Netscape CA Policy Url";
pub const NID_netscape_ca_policy_url = @as(c_int, 76);
pub const OBJ_netscape_ca_policy_url = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 8);
};
pub const SN_netscape_ssl_server_name = "nsSslServerName";
pub const LN_netscape_ssl_server_name = "Netscape SSL Server Name";
pub const NID_netscape_ssl_server_name = @as(c_int, 77);
pub const OBJ_netscape_ssl_server_name = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 12);
};
pub const SN_netscape_comment = "nsComment";
pub const LN_netscape_comment = "Netscape Comment";
pub const NID_netscape_comment = @as(c_int, 78);
pub const OBJ_netscape_comment = blk: {
    _ = &OBJ_netscape_cert_extension;
    break :blk @as(c_long, 13);
};
pub const SN_netscape_cert_sequence = "nsCertSequence";
pub const LN_netscape_cert_sequence = "Netscape Certificate Sequence";
pub const NID_netscape_cert_sequence = @as(c_int, 79);
pub const OBJ_netscape_cert_sequence = blk: {
    _ = &OBJ_netscape_data_type;
    break :blk @as(c_long, 5);
};
pub const SN_ns_sgc = "nsSGC";
pub const LN_ns_sgc = "Netscape Server Gated Crypto";
pub const NID_ns_sgc = @as(c_int, 139);
pub const OBJ_ns_sgc = blk: {
    _ = &OBJ_netscape;
    _ = @as(c_long, 4);
    break :blk @as(c_long, 1);
};
pub const SN_org = "ORG";
pub const LN_org = "org";
pub const NID_org = @as(c_int, 379);
pub const OBJ_org = blk: {
    _ = &OBJ_iso;
    break :blk @as(c_long, 3);
};
pub const SN_dod = "DOD";
pub const LN_dod = "dod";
pub const NID_dod = @as(c_int, 380);
pub const OBJ_dod = blk: {
    _ = &OBJ_org;
    break :blk @as(c_long, 6);
};
pub const SN_iana = "IANA";
pub const LN_iana = "iana";
pub const NID_iana = @as(c_int, 381);
pub const OBJ_iana = blk: {
    _ = &OBJ_dod;
    break :blk @as(c_long, 1);
};
pub const OBJ_internet = OBJ_iana;
pub const SN_Directory = "directory";
pub const LN_Directory = "Directory";
pub const NID_Directory = @as(c_int, 382);
pub const OBJ_Directory = blk: {
    _ = &OBJ_internet;
    break :blk @as(c_long, 1);
};
pub const SN_Management = "mgmt";
pub const LN_Management = "Management";
pub const NID_Management = @as(c_int, 383);
pub const OBJ_Management = blk: {
    _ = &OBJ_internet;
    break :blk @as(c_long, 2);
};
pub const SN_Experimental = "experimental";
pub const LN_Experimental = "Experimental";
pub const NID_Experimental = @as(c_int, 384);
pub const OBJ_Experimental = blk: {
    _ = &OBJ_internet;
    break :blk @as(c_long, 3);
};
pub const SN_Private = "private";
pub const LN_Private = "Private";
pub const NID_Private = @as(c_int, 385);
pub const OBJ_Private = blk: {
    _ = &OBJ_internet;
    break :blk @as(c_long, 4);
};
pub const SN_Security = "security";
pub const LN_Security = "Security";
pub const NID_Security = @as(c_int, 386);
pub const OBJ_Security = blk: {
    _ = &OBJ_internet;
    break :blk @as(c_long, 5);
};
pub const SN_SNMPv2 = "snmpv2";
pub const LN_SNMPv2 = "SNMPv2";
pub const NID_SNMPv2 = @as(c_int, 387);
pub const OBJ_SNMPv2 = blk: {
    _ = &OBJ_internet;
    break :blk @as(c_long, 6);
};
pub const LN_Mail = "Mail";
pub const NID_Mail = @as(c_int, 388);
pub const OBJ_Mail = blk: {
    _ = &OBJ_internet;
    break :blk @as(c_long, 7);
};
pub const SN_Enterprises = "enterprises";
pub const LN_Enterprises = "Enterprises";
pub const NID_Enterprises = @as(c_int, 389);
pub const OBJ_Enterprises = blk: {
    _ = &OBJ_Private;
    break :blk @as(c_long, 1);
};
pub const SN_dcObject = "dcobject";
pub const LN_dcObject = "dcObject";
pub const NID_dcObject = @as(c_int, 390);
pub const OBJ_dcObject = blk: {
    _ = &OBJ_Enterprises;
    _ = @as(c_long, 1466);
    break :blk @as(c_long, 344);
};
pub const SN_mime_mhs = "mime-mhs";
pub const LN_mime_mhs = "MIME MHS";
pub const NID_mime_mhs = @as(c_int, 504);
pub const OBJ_mime_mhs = blk: {
    _ = &OBJ_Mail;
    break :blk @as(c_long, 1);
};
pub const SN_mime_mhs_headings = "mime-mhs-headings";
pub const LN_mime_mhs_headings = "mime-mhs-headings";
pub const NID_mime_mhs_headings = @as(c_int, 505);
pub const OBJ_mime_mhs_headings = blk: {
    _ = &OBJ_mime_mhs;
    break :blk @as(c_long, 1);
};
pub const SN_mime_mhs_bodies = "mime-mhs-bodies";
pub const LN_mime_mhs_bodies = "mime-mhs-bodies";
pub const NID_mime_mhs_bodies = @as(c_int, 506);
pub const OBJ_mime_mhs_bodies = blk: {
    _ = &OBJ_mime_mhs;
    break :blk @as(c_long, 2);
};
pub const SN_id_hex_partial_message = "id-hex-partial-message";
pub const LN_id_hex_partial_message = "id-hex-partial-message";
pub const NID_id_hex_partial_message = @as(c_int, 507);
pub const OBJ_id_hex_partial_message = blk: {
    _ = &OBJ_mime_mhs_headings;
    break :blk @as(c_long, 1);
};
pub const SN_id_hex_multipart_message = "id-hex-multipart-message";
pub const LN_id_hex_multipart_message = "id-hex-multipart-message";
pub const NID_id_hex_multipart_message = @as(c_int, 508);
pub const OBJ_id_hex_multipart_message = blk: {
    _ = &OBJ_mime_mhs_headings;
    break :blk @as(c_long, 2);
};
pub const SN_zlib_compression = "ZLIB";
pub const LN_zlib_compression = "zlib compression";
pub const NID_zlib_compression = @as(c_int, 125);
pub const OBJ_zlib_compression = blk: {
    _ = &OBJ_id_smime_alg;
    break :blk @as(c_long, 8);
};
pub const OBJ_csor = blk: {
    _ = @as(c_long, 2);
    _ = @as(c_long, 16);
    _ = @as(c_long, 840);
    _ = @as(c_long, 1);
    _ = @as(c_long, 101);
    break :blk @as(c_long, 3);
};
pub const OBJ_nistAlgorithms = blk: {
    _ = &OBJ_csor;
    break :blk @as(c_long, 4);
};
pub const OBJ_aes = blk: {
    _ = &OBJ_nistAlgorithms;
    break :blk @as(c_long, 1);
};
pub const SN_aes_128_ecb = "AES-128-ECB";
pub const LN_aes_128_ecb = "aes-128-ecb";
pub const NID_aes_128_ecb = @as(c_int, 418);
pub const OBJ_aes_128_ecb = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 1);
};
pub const SN_aes_128_cbc = "AES-128-CBC";
pub const LN_aes_128_cbc = "aes-128-cbc";
pub const NID_aes_128_cbc = @as(c_int, 419);
pub const OBJ_aes_128_cbc = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 2);
};
pub const SN_aes_128_ofb128 = "AES-128-OFB";
pub const LN_aes_128_ofb128 = "aes-128-ofb";
pub const NID_aes_128_ofb128 = @as(c_int, 420);
pub const OBJ_aes_128_ofb128 = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 3);
};
pub const SN_aes_128_cfb128 = "AES-128-CFB";
pub const LN_aes_128_cfb128 = "aes-128-cfb";
pub const NID_aes_128_cfb128 = @as(c_int, 421);
pub const OBJ_aes_128_cfb128 = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 4);
};
pub const SN_id_aes128_wrap = "id-aes128-wrap";
pub const NID_id_aes128_wrap = @as(c_int, 788);
pub const OBJ_id_aes128_wrap = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 5);
};
pub const SN_aes_128_gcm = "id-aes128-GCM";
pub const LN_aes_128_gcm = "aes-128-gcm";
pub const NID_aes_128_gcm = @as(c_int, 895);
pub const OBJ_aes_128_gcm = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 6);
};
pub const SN_aes_128_ccm = "id-aes128-CCM";
pub const LN_aes_128_ccm = "aes-128-ccm";
pub const NID_aes_128_ccm = @as(c_int, 896);
pub const OBJ_aes_128_ccm = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 7);
};
pub const SN_id_aes128_wrap_pad = "id-aes128-wrap-pad";
pub const NID_id_aes128_wrap_pad = @as(c_int, 897);
pub const OBJ_id_aes128_wrap_pad = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 8);
};
pub const SN_aes_192_ecb = "AES-192-ECB";
pub const LN_aes_192_ecb = "aes-192-ecb";
pub const NID_aes_192_ecb = @as(c_int, 422);
pub const OBJ_aes_192_ecb = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 21);
};
pub const SN_aes_192_cbc = "AES-192-CBC";
pub const LN_aes_192_cbc = "aes-192-cbc";
pub const NID_aes_192_cbc = @as(c_int, 423);
pub const OBJ_aes_192_cbc = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 22);
};
pub const SN_aes_192_ofb128 = "AES-192-OFB";
pub const LN_aes_192_ofb128 = "aes-192-ofb";
pub const NID_aes_192_ofb128 = @as(c_int, 424);
pub const OBJ_aes_192_ofb128 = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 23);
};
pub const SN_aes_192_cfb128 = "AES-192-CFB";
pub const LN_aes_192_cfb128 = "aes-192-cfb";
pub const NID_aes_192_cfb128 = @as(c_int, 425);
pub const OBJ_aes_192_cfb128 = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 24);
};
pub const SN_id_aes192_wrap = "id-aes192-wrap";
pub const NID_id_aes192_wrap = @as(c_int, 789);
pub const OBJ_id_aes192_wrap = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 25);
};
pub const SN_aes_192_gcm = "id-aes192-GCM";
pub const LN_aes_192_gcm = "aes-192-gcm";
pub const NID_aes_192_gcm = @as(c_int, 898);
pub const OBJ_aes_192_gcm = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 26);
};
pub const SN_aes_192_ccm = "id-aes192-CCM";
pub const LN_aes_192_ccm = "aes-192-ccm";
pub const NID_aes_192_ccm = @as(c_int, 899);
pub const OBJ_aes_192_ccm = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 27);
};
pub const SN_id_aes192_wrap_pad = "id-aes192-wrap-pad";
pub const NID_id_aes192_wrap_pad = @as(c_int, 900);
pub const OBJ_id_aes192_wrap_pad = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 28);
};
pub const SN_aes_256_ecb = "AES-256-ECB";
pub const LN_aes_256_ecb = "aes-256-ecb";
pub const NID_aes_256_ecb = @as(c_int, 426);
pub const OBJ_aes_256_ecb = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 41);
};
pub const SN_aes_256_cbc = "AES-256-CBC";
pub const LN_aes_256_cbc = "aes-256-cbc";
pub const NID_aes_256_cbc = @as(c_int, 427);
pub const OBJ_aes_256_cbc = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 42);
};
pub const SN_aes_256_ofb128 = "AES-256-OFB";
pub const LN_aes_256_ofb128 = "aes-256-ofb";
pub const NID_aes_256_ofb128 = @as(c_int, 428);
pub const OBJ_aes_256_ofb128 = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 43);
};
pub const SN_aes_256_cfb128 = "AES-256-CFB";
pub const LN_aes_256_cfb128 = "aes-256-cfb";
pub const NID_aes_256_cfb128 = @as(c_int, 429);
pub const OBJ_aes_256_cfb128 = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 44);
};
pub const SN_id_aes256_wrap = "id-aes256-wrap";
pub const NID_id_aes256_wrap = @as(c_int, 790);
pub const OBJ_id_aes256_wrap = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 45);
};
pub const SN_aes_256_gcm = "id-aes256-GCM";
pub const LN_aes_256_gcm = "aes-256-gcm";
pub const NID_aes_256_gcm = @as(c_int, 901);
pub const OBJ_aes_256_gcm = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 46);
};
pub const SN_aes_256_ccm = "id-aes256-CCM";
pub const LN_aes_256_ccm = "aes-256-ccm";
pub const NID_aes_256_ccm = @as(c_int, 902);
pub const OBJ_aes_256_ccm = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 47);
};
pub const SN_id_aes256_wrap_pad = "id-aes256-wrap-pad";
pub const NID_id_aes256_wrap_pad = @as(c_int, 903);
pub const OBJ_id_aes256_wrap_pad = blk: {
    _ = &OBJ_aes;
    break :blk @as(c_long, 48);
};
pub const SN_aes_128_xts = "AES-128-XTS";
pub const LN_aes_128_xts = "aes-128-xts";
pub const NID_aes_128_xts = @as(c_int, 913);
pub const OBJ_aes_128_xts = blk: {
    _ = &OBJ_ieee_siswg;
    _ = @as(c_long, 0);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_aes_256_xts = "AES-256-XTS";
pub const LN_aes_256_xts = "aes-256-xts";
pub const NID_aes_256_xts = @as(c_int, 914);
pub const OBJ_aes_256_xts = blk: {
    _ = &OBJ_ieee_siswg;
    _ = @as(c_long, 0);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_aes_128_cfb1 = "AES-128-CFB1";
pub const LN_aes_128_cfb1 = "aes-128-cfb1";
pub const NID_aes_128_cfb1 = @as(c_int, 650);
pub const SN_aes_192_cfb1 = "AES-192-CFB1";
pub const LN_aes_192_cfb1 = "aes-192-cfb1";
pub const NID_aes_192_cfb1 = @as(c_int, 651);
pub const SN_aes_256_cfb1 = "AES-256-CFB1";
pub const LN_aes_256_cfb1 = "aes-256-cfb1";
pub const NID_aes_256_cfb1 = @as(c_int, 652);
pub const SN_aes_128_cfb8 = "AES-128-CFB8";
pub const LN_aes_128_cfb8 = "aes-128-cfb8";
pub const NID_aes_128_cfb8 = @as(c_int, 653);
pub const SN_aes_192_cfb8 = "AES-192-CFB8";
pub const LN_aes_192_cfb8 = "aes-192-cfb8";
pub const NID_aes_192_cfb8 = @as(c_int, 654);
pub const SN_aes_256_cfb8 = "AES-256-CFB8";
pub const LN_aes_256_cfb8 = "aes-256-cfb8";
pub const NID_aes_256_cfb8 = @as(c_int, 655);
pub const SN_aes_128_ctr = "AES-128-CTR";
pub const LN_aes_128_ctr = "aes-128-ctr";
pub const NID_aes_128_ctr = @as(c_int, 904);
pub const SN_aes_192_ctr = "AES-192-CTR";
pub const LN_aes_192_ctr = "aes-192-ctr";
pub const NID_aes_192_ctr = @as(c_int, 905);
pub const SN_aes_256_ctr = "AES-256-CTR";
pub const LN_aes_256_ctr = "aes-256-ctr";
pub const NID_aes_256_ctr = @as(c_int, 906);
pub const SN_aes_128_ocb = "AES-128-OCB";
pub const LN_aes_128_ocb = "aes-128-ocb";
pub const NID_aes_128_ocb = @as(c_int, 958);
pub const SN_aes_192_ocb = "AES-192-OCB";
pub const LN_aes_192_ocb = "aes-192-ocb";
pub const NID_aes_192_ocb = @as(c_int, 959);
pub const SN_aes_256_ocb = "AES-256-OCB";
pub const LN_aes_256_ocb = "aes-256-ocb";
pub const NID_aes_256_ocb = @as(c_int, 960);
pub const SN_des_cfb1 = "DES-CFB1";
pub const LN_des_cfb1 = "des-cfb1";
pub const NID_des_cfb1 = @as(c_int, 656);
pub const SN_des_cfb8 = "DES-CFB8";
pub const LN_des_cfb8 = "des-cfb8";
pub const NID_des_cfb8 = @as(c_int, 657);
pub const SN_des_ede3_cfb1 = "DES-EDE3-CFB1";
pub const LN_des_ede3_cfb1 = "des-ede3-cfb1";
pub const NID_des_ede3_cfb1 = @as(c_int, 658);
pub const SN_des_ede3_cfb8 = "DES-EDE3-CFB8";
pub const LN_des_ede3_cfb8 = "des-ede3-cfb8";
pub const NID_des_ede3_cfb8 = @as(c_int, 659);
pub const OBJ_nist_hashalgs = blk: {
    _ = &OBJ_nistAlgorithms;
    break :blk @as(c_long, 2);
};
pub const SN_sha256 = "SHA256";
pub const LN_sha256 = "sha256";
pub const NID_sha256 = @as(c_int, 672);
pub const OBJ_sha256 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 1);
};
pub const SN_sha384 = "SHA384";
pub const LN_sha384 = "sha384";
pub const NID_sha384 = @as(c_int, 673);
pub const OBJ_sha384 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 2);
};
pub const SN_sha512 = "SHA512";
pub const LN_sha512 = "sha512";
pub const NID_sha512 = @as(c_int, 674);
pub const OBJ_sha512 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 3);
};
pub const SN_sha224 = "SHA224";
pub const LN_sha224 = "sha224";
pub const NID_sha224 = @as(c_int, 675);
pub const OBJ_sha224 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 4);
};
pub const SN_sha512_224 = "SHA512-224";
pub const LN_sha512_224 = "sha512-224";
pub const NID_sha512_224 = @as(c_int, 1094);
pub const OBJ_sha512_224 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 5);
};
pub const SN_sha512_256 = "SHA512-256";
pub const LN_sha512_256 = "sha512-256";
pub const NID_sha512_256 = @as(c_int, 1095);
pub const OBJ_sha512_256 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 6);
};
pub const SN_sha3_224 = "SHA3-224";
pub const LN_sha3_224 = "sha3-224";
pub const NID_sha3_224 = @as(c_int, 1096);
pub const OBJ_sha3_224 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 7);
};
pub const SN_sha3_256 = "SHA3-256";
pub const LN_sha3_256 = "sha3-256";
pub const NID_sha3_256 = @as(c_int, 1097);
pub const OBJ_sha3_256 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 8);
};
pub const SN_sha3_384 = "SHA3-384";
pub const LN_sha3_384 = "sha3-384";
pub const NID_sha3_384 = @as(c_int, 1098);
pub const OBJ_sha3_384 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 9);
};
pub const SN_sha3_512 = "SHA3-512";
pub const LN_sha3_512 = "sha3-512";
pub const NID_sha3_512 = @as(c_int, 1099);
pub const OBJ_sha3_512 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 10);
};
pub const SN_shake128 = "SHAKE128";
pub const LN_shake128 = "shake128";
pub const NID_shake128 = @as(c_int, 1100);
pub const OBJ_shake128 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 11);
};
pub const SN_shake256 = "SHAKE256";
pub const LN_shake256 = "shake256";
pub const NID_shake256 = @as(c_int, 1101);
pub const OBJ_shake256 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 12);
};
pub const SN_hmac_sha3_224 = "id-hmacWithSHA3-224";
pub const LN_hmac_sha3_224 = "hmac-sha3-224";
pub const NID_hmac_sha3_224 = @as(c_int, 1102);
pub const OBJ_hmac_sha3_224 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 13);
};
pub const SN_hmac_sha3_256 = "id-hmacWithSHA3-256";
pub const LN_hmac_sha3_256 = "hmac-sha3-256";
pub const NID_hmac_sha3_256 = @as(c_int, 1103);
pub const OBJ_hmac_sha3_256 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 14);
};
pub const SN_hmac_sha3_384 = "id-hmacWithSHA3-384";
pub const LN_hmac_sha3_384 = "hmac-sha3-384";
pub const NID_hmac_sha3_384 = @as(c_int, 1104);
pub const OBJ_hmac_sha3_384 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 15);
};
pub const SN_hmac_sha3_512 = "id-hmacWithSHA3-512";
pub const LN_hmac_sha3_512 = "hmac-sha3-512";
pub const NID_hmac_sha3_512 = @as(c_int, 1105);
pub const OBJ_hmac_sha3_512 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 16);
};
pub const SN_kmac128 = "KMAC128";
pub const LN_kmac128 = "kmac128";
pub const NID_kmac128 = @as(c_int, 1196);
pub const OBJ_kmac128 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 19);
};
pub const SN_kmac256 = "KMAC256";
pub const LN_kmac256 = "kmac256";
pub const NID_kmac256 = @as(c_int, 1197);
pub const OBJ_kmac256 = blk: {
    _ = &OBJ_nist_hashalgs;
    break :blk @as(c_long, 20);
};
pub const OBJ_dsa_with_sha2 = blk: {
    _ = &OBJ_nistAlgorithms;
    break :blk @as(c_long, 3);
};
pub const SN_dsa_with_SHA224 = "dsa_with_SHA224";
pub const NID_dsa_with_SHA224 = @as(c_int, 802);
pub const OBJ_dsa_with_SHA224 = blk: {
    _ = &OBJ_dsa_with_sha2;
    break :blk @as(c_long, 1);
};
pub const SN_dsa_with_SHA256 = "dsa_with_SHA256";
pub const NID_dsa_with_SHA256 = @as(c_int, 803);
pub const OBJ_dsa_with_SHA256 = blk: {
    _ = &OBJ_dsa_with_sha2;
    break :blk @as(c_long, 2);
};
pub const OBJ_sigAlgs = blk: {
    _ = &OBJ_nistAlgorithms;
    break :blk @as(c_long, 3);
};
pub const SN_dsa_with_SHA384 = "id-dsa-with-sha384";
pub const LN_dsa_with_SHA384 = "dsa_with_SHA384";
pub const NID_dsa_with_SHA384 = @as(c_int, 1106);
pub const OBJ_dsa_with_SHA384 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 3);
};
pub const SN_dsa_with_SHA512 = "id-dsa-with-sha512";
pub const LN_dsa_with_SHA512 = "dsa_with_SHA512";
pub const NID_dsa_with_SHA512 = @as(c_int, 1107);
pub const OBJ_dsa_with_SHA512 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 4);
};
pub const SN_dsa_with_SHA3_224 = "id-dsa-with-sha3-224";
pub const LN_dsa_with_SHA3_224 = "dsa_with_SHA3-224";
pub const NID_dsa_with_SHA3_224 = @as(c_int, 1108);
pub const OBJ_dsa_with_SHA3_224 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 5);
};
pub const SN_dsa_with_SHA3_256 = "id-dsa-with-sha3-256";
pub const LN_dsa_with_SHA3_256 = "dsa_with_SHA3-256";
pub const NID_dsa_with_SHA3_256 = @as(c_int, 1109);
pub const OBJ_dsa_with_SHA3_256 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 6);
};
pub const SN_dsa_with_SHA3_384 = "id-dsa-with-sha3-384";
pub const LN_dsa_with_SHA3_384 = "dsa_with_SHA3-384";
pub const NID_dsa_with_SHA3_384 = @as(c_int, 1110);
pub const OBJ_dsa_with_SHA3_384 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 7);
};
pub const SN_dsa_with_SHA3_512 = "id-dsa-with-sha3-512";
pub const LN_dsa_with_SHA3_512 = "dsa_with_SHA3-512";
pub const NID_dsa_with_SHA3_512 = @as(c_int, 1111);
pub const OBJ_dsa_with_SHA3_512 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 8);
};
pub const SN_ecdsa_with_SHA3_224 = "id-ecdsa-with-sha3-224";
pub const LN_ecdsa_with_SHA3_224 = "ecdsa_with_SHA3-224";
pub const NID_ecdsa_with_SHA3_224 = @as(c_int, 1112);
pub const OBJ_ecdsa_with_SHA3_224 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 9);
};
pub const SN_ecdsa_with_SHA3_256 = "id-ecdsa-with-sha3-256";
pub const LN_ecdsa_with_SHA3_256 = "ecdsa_with_SHA3-256";
pub const NID_ecdsa_with_SHA3_256 = @as(c_int, 1113);
pub const OBJ_ecdsa_with_SHA3_256 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 10);
};
pub const SN_ecdsa_with_SHA3_384 = "id-ecdsa-with-sha3-384";
pub const LN_ecdsa_with_SHA3_384 = "ecdsa_with_SHA3-384";
pub const NID_ecdsa_with_SHA3_384 = @as(c_int, 1114);
pub const OBJ_ecdsa_with_SHA3_384 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 11);
};
pub const SN_ecdsa_with_SHA3_512 = "id-ecdsa-with-sha3-512";
pub const LN_ecdsa_with_SHA3_512 = "ecdsa_with_SHA3-512";
pub const NID_ecdsa_with_SHA3_512 = @as(c_int, 1115);
pub const OBJ_ecdsa_with_SHA3_512 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 12);
};
pub const SN_RSA_SHA3_224 = "id-rsassa-pkcs1-v1_5-with-sha3-224";
pub const LN_RSA_SHA3_224 = "RSA-SHA3-224";
pub const NID_RSA_SHA3_224 = @as(c_int, 1116);
pub const OBJ_RSA_SHA3_224 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 13);
};
pub const SN_RSA_SHA3_256 = "id-rsassa-pkcs1-v1_5-with-sha3-256";
pub const LN_RSA_SHA3_256 = "RSA-SHA3-256";
pub const NID_RSA_SHA3_256 = @as(c_int, 1117);
pub const OBJ_RSA_SHA3_256 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 14);
};
pub const SN_RSA_SHA3_384 = "id-rsassa-pkcs1-v1_5-with-sha3-384";
pub const LN_RSA_SHA3_384 = "RSA-SHA3-384";
pub const NID_RSA_SHA3_384 = @as(c_int, 1118);
pub const OBJ_RSA_SHA3_384 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 15);
};
pub const SN_RSA_SHA3_512 = "id-rsassa-pkcs1-v1_5-with-sha3-512";
pub const LN_RSA_SHA3_512 = "RSA-SHA3-512";
pub const NID_RSA_SHA3_512 = @as(c_int, 1119);
pub const OBJ_RSA_SHA3_512 = blk: {
    _ = &OBJ_sigAlgs;
    break :blk @as(c_long, 16);
};
pub const SN_hold_instruction_code = "holdInstructionCode";
pub const LN_hold_instruction_code = "Hold Instruction Code";
pub const NID_hold_instruction_code = @as(c_int, 430);
pub const OBJ_hold_instruction_code = blk: {
    _ = &OBJ_id_ce;
    break :blk @as(c_long, 23);
};
pub const OBJ_holdInstruction = blk: {
    _ = &OBJ_X9_57;
    break :blk @as(c_long, 2);
};
pub const SN_hold_instruction_none = "holdInstructionNone";
pub const LN_hold_instruction_none = "Hold Instruction None";
pub const NID_hold_instruction_none = @as(c_int, 431);
pub const OBJ_hold_instruction_none = blk: {
    _ = &OBJ_holdInstruction;
    break :blk @as(c_long, 1);
};
pub const SN_hold_instruction_call_issuer = "holdInstructionCallIssuer";
pub const LN_hold_instruction_call_issuer = "Hold Instruction Call Issuer";
pub const NID_hold_instruction_call_issuer = @as(c_int, 432);
pub const OBJ_hold_instruction_call_issuer = blk: {
    _ = &OBJ_holdInstruction;
    break :blk @as(c_long, 2);
};
pub const SN_hold_instruction_reject = "holdInstructionReject";
pub const LN_hold_instruction_reject = "Hold Instruction Reject";
pub const NID_hold_instruction_reject = @as(c_int, 433);
pub const OBJ_hold_instruction_reject = blk: {
    _ = &OBJ_holdInstruction;
    break :blk @as(c_long, 3);
};
pub const SN_data = "data";
pub const NID_data = @as(c_int, 434);
pub const OBJ_data = blk: {
    _ = &OBJ_itu_t;
    break :blk @as(c_long, 9);
};
pub const SN_pss = "pss";
pub const NID_pss = @as(c_int, 435);
pub const OBJ_pss = blk: {
    _ = &OBJ_data;
    break :blk @as(c_long, 2342);
};
pub const SN_ucl = "ucl";
pub const NID_ucl = @as(c_int, 436);
pub const OBJ_ucl = blk: {
    _ = &OBJ_pss;
    break :blk @as(c_long, 19200300);
};
pub const SN_pilot = "pilot";
pub const NID_pilot = @as(c_int, 437);
pub const OBJ_pilot = blk: {
    _ = &OBJ_ucl;
    break :blk @as(c_long, 100);
};
pub const LN_pilotAttributeType = "pilotAttributeType";
pub const NID_pilotAttributeType = @as(c_int, 438);
pub const OBJ_pilotAttributeType = blk: {
    _ = &OBJ_pilot;
    break :blk @as(c_long, 1);
};
pub const LN_pilotAttributeSyntax = "pilotAttributeSyntax";
pub const NID_pilotAttributeSyntax = @as(c_int, 439);
pub const OBJ_pilotAttributeSyntax = blk: {
    _ = &OBJ_pilot;
    break :blk @as(c_long, 3);
};
pub const LN_pilotObjectClass = "pilotObjectClass";
pub const NID_pilotObjectClass = @as(c_int, 440);
pub const OBJ_pilotObjectClass = blk: {
    _ = &OBJ_pilot;
    break :blk @as(c_long, 4);
};
pub const LN_pilotGroups = "pilotGroups";
pub const NID_pilotGroups = @as(c_int, 441);
pub const OBJ_pilotGroups = blk: {
    _ = &OBJ_pilot;
    break :blk @as(c_long, 10);
};
pub const LN_iA5StringSyntax = "iA5StringSyntax";
pub const NID_iA5StringSyntax = @as(c_int, 442);
pub const OBJ_iA5StringSyntax = blk: {
    _ = &OBJ_pilotAttributeSyntax;
    break :blk @as(c_long, 4);
};
pub const LN_caseIgnoreIA5StringSyntax = "caseIgnoreIA5StringSyntax";
pub const NID_caseIgnoreIA5StringSyntax = @as(c_int, 443);
pub const OBJ_caseIgnoreIA5StringSyntax = blk: {
    _ = &OBJ_pilotAttributeSyntax;
    break :blk @as(c_long, 5);
};
pub const LN_pilotObject = "pilotObject";
pub const NID_pilotObject = @as(c_int, 444);
pub const OBJ_pilotObject = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 3);
};
pub const LN_pilotPerson = "pilotPerson";
pub const NID_pilotPerson = @as(c_int, 445);
pub const OBJ_pilotPerson = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 4);
};
pub const SN_account = "account";
pub const NID_account = @as(c_int, 446);
pub const OBJ_account = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 5);
};
pub const SN_document = "document";
pub const NID_document = @as(c_int, 447);
pub const OBJ_document = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 6);
};
pub const SN_room = "room";
pub const NID_room = @as(c_int, 448);
pub const OBJ_room = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 7);
};
pub const LN_documentSeries = "documentSeries";
pub const NID_documentSeries = @as(c_int, 449);
pub const OBJ_documentSeries = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 9);
};
pub const SN_Domain = "domain";
pub const LN_Domain = "Domain";
pub const NID_Domain = @as(c_int, 392);
pub const OBJ_Domain = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 13);
};
pub const LN_rFC822localPart = "rFC822localPart";
pub const NID_rFC822localPart = @as(c_int, 450);
pub const OBJ_rFC822localPart = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 14);
};
pub const LN_dNSDomain = "dNSDomain";
pub const NID_dNSDomain = @as(c_int, 451);
pub const OBJ_dNSDomain = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 15);
};
pub const LN_domainRelatedObject = "domainRelatedObject";
pub const NID_domainRelatedObject = @as(c_int, 452);
pub const OBJ_domainRelatedObject = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 17);
};
pub const LN_friendlyCountry = "friendlyCountry";
pub const NID_friendlyCountry = @as(c_int, 453);
pub const OBJ_friendlyCountry = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 18);
};
pub const LN_simpleSecurityObject = "simpleSecurityObject";
pub const NID_simpleSecurityObject = @as(c_int, 454);
pub const OBJ_simpleSecurityObject = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 19);
};
pub const LN_pilotOrganization = "pilotOrganization";
pub const NID_pilotOrganization = @as(c_int, 455);
pub const OBJ_pilotOrganization = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 20);
};
pub const LN_pilotDSA = "pilotDSA";
pub const NID_pilotDSA = @as(c_int, 456);
pub const OBJ_pilotDSA = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 21);
};
pub const LN_qualityLabelledData = "qualityLabelledData";
pub const NID_qualityLabelledData = @as(c_int, 457);
pub const OBJ_qualityLabelledData = blk: {
    _ = &OBJ_pilotObjectClass;
    break :blk @as(c_long, 22);
};
pub const SN_userId = "UID";
pub const LN_userId = "userId";
pub const NID_userId = @as(c_int, 458);
pub const OBJ_userId = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 1);
};
pub const LN_textEncodedORAddress = "textEncodedORAddress";
pub const NID_textEncodedORAddress = @as(c_int, 459);
pub const OBJ_textEncodedORAddress = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 2);
};
pub const SN_rfc822Mailbox = "mail";
pub const LN_rfc822Mailbox = "rfc822Mailbox";
pub const NID_rfc822Mailbox = @as(c_int, 460);
pub const OBJ_rfc822Mailbox = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 3);
};
pub const SN_info = "info";
pub const NID_info = @as(c_int, 461);
pub const OBJ_info = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 4);
};
pub const LN_favouriteDrink = "favouriteDrink";
pub const NID_favouriteDrink = @as(c_int, 462);
pub const OBJ_favouriteDrink = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 5);
};
pub const LN_roomNumber = "roomNumber";
pub const NID_roomNumber = @as(c_int, 463);
pub const OBJ_roomNumber = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 6);
};
pub const SN_photo = "photo";
pub const NID_photo = @as(c_int, 464);
pub const OBJ_photo = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 7);
};
pub const LN_userClass = "userClass";
pub const NID_userClass = @as(c_int, 465);
pub const OBJ_userClass = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 8);
};
pub const SN_host = "host";
pub const NID_host = @as(c_int, 466);
pub const OBJ_host = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 9);
};
pub const SN_manager = "manager";
pub const NID_manager = @as(c_int, 467);
pub const OBJ_manager = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 10);
};
pub const LN_documentIdentifier = "documentIdentifier";
pub const NID_documentIdentifier = @as(c_int, 468);
pub const OBJ_documentIdentifier = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 11);
};
pub const LN_documentTitle = "documentTitle";
pub const NID_documentTitle = @as(c_int, 469);
pub const OBJ_documentTitle = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 12);
};
pub const LN_documentVersion = "documentVersion";
pub const NID_documentVersion = @as(c_int, 470);
pub const OBJ_documentVersion = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 13);
};
pub const LN_documentAuthor = "documentAuthor";
pub const NID_documentAuthor = @as(c_int, 471);
pub const OBJ_documentAuthor = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 14);
};
pub const LN_documentLocation = "documentLocation";
pub const NID_documentLocation = @as(c_int, 472);
pub const OBJ_documentLocation = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 15);
};
pub const LN_homeTelephoneNumber = "homeTelephoneNumber";
pub const NID_homeTelephoneNumber = @as(c_int, 473);
pub const OBJ_homeTelephoneNumber = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 20);
};
pub const SN_secretary = "secretary";
pub const NID_secretary = @as(c_int, 474);
pub const OBJ_secretary = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 21);
};
pub const LN_otherMailbox = "otherMailbox";
pub const NID_otherMailbox = @as(c_int, 475);
pub const OBJ_otherMailbox = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 22);
};
pub const LN_lastModifiedTime = "lastModifiedTime";
pub const NID_lastModifiedTime = @as(c_int, 476);
pub const OBJ_lastModifiedTime = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 23);
};
pub const LN_lastModifiedBy = "lastModifiedBy";
pub const NID_lastModifiedBy = @as(c_int, 477);
pub const OBJ_lastModifiedBy = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 24);
};
pub const SN_domainComponent = "DC";
pub const LN_domainComponent = "domainComponent";
pub const NID_domainComponent = @as(c_int, 391);
pub const OBJ_domainComponent = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 25);
};
pub const LN_aRecord = "aRecord";
pub const NID_aRecord = @as(c_int, 478);
pub const OBJ_aRecord = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 26);
};
pub const LN_pilotAttributeType27 = "pilotAttributeType27";
pub const NID_pilotAttributeType27 = @as(c_int, 479);
pub const OBJ_pilotAttributeType27 = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 27);
};
pub const LN_mXRecord = "mXRecord";
pub const NID_mXRecord = @as(c_int, 480);
pub const OBJ_mXRecord = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 28);
};
pub const LN_nSRecord = "nSRecord";
pub const NID_nSRecord = @as(c_int, 481);
pub const OBJ_nSRecord = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 29);
};
pub const LN_sOARecord = "sOARecord";
pub const NID_sOARecord = @as(c_int, 482);
pub const OBJ_sOARecord = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 30);
};
pub const LN_cNAMERecord = "cNAMERecord";
pub const NID_cNAMERecord = @as(c_int, 483);
pub const OBJ_cNAMERecord = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 31);
};
pub const LN_associatedDomain = "associatedDomain";
pub const NID_associatedDomain = @as(c_int, 484);
pub const OBJ_associatedDomain = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 37);
};
pub const LN_associatedName = "associatedName";
pub const NID_associatedName = @as(c_int, 485);
pub const OBJ_associatedName = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 38);
};
pub const LN_homePostalAddress = "homePostalAddress";
pub const NID_homePostalAddress = @as(c_int, 486);
pub const OBJ_homePostalAddress = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 39);
};
pub const LN_personalTitle = "personalTitle";
pub const NID_personalTitle = @as(c_int, 487);
pub const OBJ_personalTitle = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 40);
};
pub const LN_mobileTelephoneNumber = "mobileTelephoneNumber";
pub const NID_mobileTelephoneNumber = @as(c_int, 488);
pub const OBJ_mobileTelephoneNumber = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 41);
};
pub const LN_pagerTelephoneNumber = "pagerTelephoneNumber";
pub const NID_pagerTelephoneNumber = @as(c_int, 489);
pub const OBJ_pagerTelephoneNumber = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 42);
};
pub const LN_friendlyCountryName = "friendlyCountryName";
pub const NID_friendlyCountryName = @as(c_int, 490);
pub const OBJ_friendlyCountryName = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 43);
};
pub const SN_uniqueIdentifier = "uid";
pub const LN_uniqueIdentifier = "uniqueIdentifier";
pub const NID_uniqueIdentifier = @as(c_int, 102);
pub const OBJ_uniqueIdentifier = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 44);
};
pub const LN_organizationalStatus = "organizationalStatus";
pub const NID_organizationalStatus = @as(c_int, 491);
pub const OBJ_organizationalStatus = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 45);
};
pub const LN_janetMailbox = "janetMailbox";
pub const NID_janetMailbox = @as(c_int, 492);
pub const OBJ_janetMailbox = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 46);
};
pub const LN_mailPreferenceOption = "mailPreferenceOption";
pub const NID_mailPreferenceOption = @as(c_int, 493);
pub const OBJ_mailPreferenceOption = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 47);
};
pub const LN_buildingName = "buildingName";
pub const NID_buildingName = @as(c_int, 494);
pub const OBJ_buildingName = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 48);
};
pub const LN_dSAQuality = "dSAQuality";
pub const NID_dSAQuality = @as(c_int, 495);
pub const OBJ_dSAQuality = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 49);
};
pub const LN_singleLevelQuality = "singleLevelQuality";
pub const NID_singleLevelQuality = @as(c_int, 496);
pub const OBJ_singleLevelQuality = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 50);
};
pub const LN_subtreeMinimumQuality = "subtreeMinimumQuality";
pub const NID_subtreeMinimumQuality = @as(c_int, 497);
pub const OBJ_subtreeMinimumQuality = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 51);
};
pub const LN_subtreeMaximumQuality = "subtreeMaximumQuality";
pub const NID_subtreeMaximumQuality = @as(c_int, 498);
pub const OBJ_subtreeMaximumQuality = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 52);
};
pub const LN_personalSignature = "personalSignature";
pub const NID_personalSignature = @as(c_int, 499);
pub const OBJ_personalSignature = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 53);
};
pub const LN_dITRedirect = "dITRedirect";
pub const NID_dITRedirect = @as(c_int, 500);
pub const OBJ_dITRedirect = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 54);
};
pub const SN_audio = "audio";
pub const NID_audio = @as(c_int, 501);
pub const OBJ_audio = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 55);
};
pub const LN_documentPublisher = "documentPublisher";
pub const NID_documentPublisher = @as(c_int, 502);
pub const OBJ_documentPublisher = blk: {
    _ = &OBJ_pilotAttributeType;
    break :blk @as(c_long, 56);
};
pub const SN_id_set = "id-set";
pub const LN_id_set = "Secure Electronic Transactions";
pub const NID_id_set = @as(c_int, 512);
pub const OBJ_id_set = blk: {
    _ = &OBJ_international_organizations;
    break :blk @as(c_long, 42);
};
pub const SN_set_ctype = "set-ctype";
pub const LN_set_ctype = "content types";
pub const NID_set_ctype = @as(c_int, 513);
pub const OBJ_set_ctype = blk: {
    _ = &OBJ_id_set;
    break :blk @as(c_long, 0);
};
pub const SN_set_msgExt = "set-msgExt";
pub const LN_set_msgExt = "message extensions";
pub const NID_set_msgExt = @as(c_int, 514);
pub const OBJ_set_msgExt = blk: {
    _ = &OBJ_id_set;
    break :blk @as(c_long, 1);
};
pub const SN_set_attr = "set-attr";
pub const NID_set_attr = @as(c_int, 515);
pub const OBJ_set_attr = blk: {
    _ = &OBJ_id_set;
    break :blk @as(c_long, 3);
};
pub const SN_set_policy = "set-policy";
pub const NID_set_policy = @as(c_int, 516);
pub const OBJ_set_policy = blk: {
    _ = &OBJ_id_set;
    break :blk @as(c_long, 5);
};
pub const SN_set_certExt = "set-certExt";
pub const LN_set_certExt = "certificate extensions";
pub const NID_set_certExt = @as(c_int, 517);
pub const OBJ_set_certExt = blk: {
    _ = &OBJ_id_set;
    break :blk @as(c_long, 7);
};
pub const SN_set_brand = "set-brand";
pub const NID_set_brand = @as(c_int, 518);
pub const OBJ_set_brand = blk: {
    _ = &OBJ_id_set;
    break :blk @as(c_long, 8);
};
pub const SN_setct_PANData = "setct-PANData";
pub const NID_setct_PANData = @as(c_int, 519);
pub const OBJ_setct_PANData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 0);
};
pub const SN_setct_PANToken = "setct-PANToken";
pub const NID_setct_PANToken = @as(c_int, 520);
pub const OBJ_setct_PANToken = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 1);
};
pub const SN_setct_PANOnly = "setct-PANOnly";
pub const NID_setct_PANOnly = @as(c_int, 521);
pub const OBJ_setct_PANOnly = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 2);
};
pub const SN_setct_OIData = "setct-OIData";
pub const NID_setct_OIData = @as(c_int, 522);
pub const OBJ_setct_OIData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 3);
};
pub const SN_setct_PI = "setct-PI";
pub const NID_setct_PI = @as(c_int, 523);
pub const OBJ_setct_PI = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 4);
};
pub const SN_setct_PIData = "setct-PIData";
pub const NID_setct_PIData = @as(c_int, 524);
pub const OBJ_setct_PIData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 5);
};
pub const SN_setct_PIDataUnsigned = "setct-PIDataUnsigned";
pub const NID_setct_PIDataUnsigned = @as(c_int, 525);
pub const OBJ_setct_PIDataUnsigned = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 6);
};
pub const SN_setct_HODInput = "setct-HODInput";
pub const NID_setct_HODInput = @as(c_int, 526);
pub const OBJ_setct_HODInput = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 7);
};
pub const SN_setct_AuthResBaggage = "setct-AuthResBaggage";
pub const NID_setct_AuthResBaggage = @as(c_int, 527);
pub const OBJ_setct_AuthResBaggage = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 8);
};
pub const SN_setct_AuthRevReqBaggage = "setct-AuthRevReqBaggage";
pub const NID_setct_AuthRevReqBaggage = @as(c_int, 528);
pub const OBJ_setct_AuthRevReqBaggage = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 9);
};
pub const SN_setct_AuthRevResBaggage = "setct-AuthRevResBaggage";
pub const NID_setct_AuthRevResBaggage = @as(c_int, 529);
pub const OBJ_setct_AuthRevResBaggage = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 10);
};
pub const SN_setct_CapTokenSeq = "setct-CapTokenSeq";
pub const NID_setct_CapTokenSeq = @as(c_int, 530);
pub const OBJ_setct_CapTokenSeq = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 11);
};
pub const SN_setct_PInitResData = "setct-PInitResData";
pub const NID_setct_PInitResData = @as(c_int, 531);
pub const OBJ_setct_PInitResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 12);
};
pub const SN_setct_PI_TBS = "setct-PI-TBS";
pub const NID_setct_PI_TBS = @as(c_int, 532);
pub const OBJ_setct_PI_TBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 13);
};
pub const SN_setct_PResData = "setct-PResData";
pub const NID_setct_PResData = @as(c_int, 533);
pub const OBJ_setct_PResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 14);
};
pub const SN_setct_AuthReqTBS = "setct-AuthReqTBS";
pub const NID_setct_AuthReqTBS = @as(c_int, 534);
pub const OBJ_setct_AuthReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 16);
};
pub const SN_setct_AuthResTBS = "setct-AuthResTBS";
pub const NID_setct_AuthResTBS = @as(c_int, 535);
pub const OBJ_setct_AuthResTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 17);
};
pub const SN_setct_AuthResTBSX = "setct-AuthResTBSX";
pub const NID_setct_AuthResTBSX = @as(c_int, 536);
pub const OBJ_setct_AuthResTBSX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 18);
};
pub const SN_setct_AuthTokenTBS = "setct-AuthTokenTBS";
pub const NID_setct_AuthTokenTBS = @as(c_int, 537);
pub const OBJ_setct_AuthTokenTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 19);
};
pub const SN_setct_CapTokenData = "setct-CapTokenData";
pub const NID_setct_CapTokenData = @as(c_int, 538);
pub const OBJ_setct_CapTokenData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 20);
};
pub const SN_setct_CapTokenTBS = "setct-CapTokenTBS";
pub const NID_setct_CapTokenTBS = @as(c_int, 539);
pub const OBJ_setct_CapTokenTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 21);
};
pub const SN_setct_AcqCardCodeMsg = "setct-AcqCardCodeMsg";
pub const NID_setct_AcqCardCodeMsg = @as(c_int, 540);
pub const OBJ_setct_AcqCardCodeMsg = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 22);
};
pub const SN_setct_AuthRevReqTBS = "setct-AuthRevReqTBS";
pub const NID_setct_AuthRevReqTBS = @as(c_int, 541);
pub const OBJ_setct_AuthRevReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 23);
};
pub const SN_setct_AuthRevResData = "setct-AuthRevResData";
pub const NID_setct_AuthRevResData = @as(c_int, 542);
pub const OBJ_setct_AuthRevResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 24);
};
pub const SN_setct_AuthRevResTBS = "setct-AuthRevResTBS";
pub const NID_setct_AuthRevResTBS = @as(c_int, 543);
pub const OBJ_setct_AuthRevResTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 25);
};
pub const SN_setct_CapReqTBS = "setct-CapReqTBS";
pub const NID_setct_CapReqTBS = @as(c_int, 544);
pub const OBJ_setct_CapReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 26);
};
pub const SN_setct_CapReqTBSX = "setct-CapReqTBSX";
pub const NID_setct_CapReqTBSX = @as(c_int, 545);
pub const OBJ_setct_CapReqTBSX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 27);
};
pub const SN_setct_CapResData = "setct-CapResData";
pub const NID_setct_CapResData = @as(c_int, 546);
pub const OBJ_setct_CapResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 28);
};
pub const SN_setct_CapRevReqTBS = "setct-CapRevReqTBS";
pub const NID_setct_CapRevReqTBS = @as(c_int, 547);
pub const OBJ_setct_CapRevReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 29);
};
pub const SN_setct_CapRevReqTBSX = "setct-CapRevReqTBSX";
pub const NID_setct_CapRevReqTBSX = @as(c_int, 548);
pub const OBJ_setct_CapRevReqTBSX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 30);
};
pub const SN_setct_CapRevResData = "setct-CapRevResData";
pub const NID_setct_CapRevResData = @as(c_int, 549);
pub const OBJ_setct_CapRevResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 31);
};
pub const SN_setct_CredReqTBS = "setct-CredReqTBS";
pub const NID_setct_CredReqTBS = @as(c_int, 550);
pub const OBJ_setct_CredReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 32);
};
pub const SN_setct_CredReqTBSX = "setct-CredReqTBSX";
pub const NID_setct_CredReqTBSX = @as(c_int, 551);
pub const OBJ_setct_CredReqTBSX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 33);
};
pub const SN_setct_CredResData = "setct-CredResData";
pub const NID_setct_CredResData = @as(c_int, 552);
pub const OBJ_setct_CredResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 34);
};
pub const SN_setct_CredRevReqTBS = "setct-CredRevReqTBS";
pub const NID_setct_CredRevReqTBS = @as(c_int, 553);
pub const OBJ_setct_CredRevReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 35);
};
pub const SN_setct_CredRevReqTBSX = "setct-CredRevReqTBSX";
pub const NID_setct_CredRevReqTBSX = @as(c_int, 554);
pub const OBJ_setct_CredRevReqTBSX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 36);
};
pub const SN_setct_CredRevResData = "setct-CredRevResData";
pub const NID_setct_CredRevResData = @as(c_int, 555);
pub const OBJ_setct_CredRevResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 37);
};
pub const SN_setct_PCertReqData = "setct-PCertReqData";
pub const NID_setct_PCertReqData = @as(c_int, 556);
pub const OBJ_setct_PCertReqData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 38);
};
pub const SN_setct_PCertResTBS = "setct-PCertResTBS";
pub const NID_setct_PCertResTBS = @as(c_int, 557);
pub const OBJ_setct_PCertResTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 39);
};
pub const SN_setct_BatchAdminReqData = "setct-BatchAdminReqData";
pub const NID_setct_BatchAdminReqData = @as(c_int, 558);
pub const OBJ_setct_BatchAdminReqData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 40);
};
pub const SN_setct_BatchAdminResData = "setct-BatchAdminResData";
pub const NID_setct_BatchAdminResData = @as(c_int, 559);
pub const OBJ_setct_BatchAdminResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 41);
};
pub const SN_setct_CardCInitResTBS = "setct-CardCInitResTBS";
pub const NID_setct_CardCInitResTBS = @as(c_int, 560);
pub const OBJ_setct_CardCInitResTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 42);
};
pub const SN_setct_MeAqCInitResTBS = "setct-MeAqCInitResTBS";
pub const NID_setct_MeAqCInitResTBS = @as(c_int, 561);
pub const OBJ_setct_MeAqCInitResTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 43);
};
pub const SN_setct_RegFormResTBS = "setct-RegFormResTBS";
pub const NID_setct_RegFormResTBS = @as(c_int, 562);
pub const OBJ_setct_RegFormResTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 44);
};
pub const SN_setct_CertReqData = "setct-CertReqData";
pub const NID_setct_CertReqData = @as(c_int, 563);
pub const OBJ_setct_CertReqData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 45);
};
pub const SN_setct_CertReqTBS = "setct-CertReqTBS";
pub const NID_setct_CertReqTBS = @as(c_int, 564);
pub const OBJ_setct_CertReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 46);
};
pub const SN_setct_CertResData = "setct-CertResData";
pub const NID_setct_CertResData = @as(c_int, 565);
pub const OBJ_setct_CertResData = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 47);
};
pub const SN_setct_CertInqReqTBS = "setct-CertInqReqTBS";
pub const NID_setct_CertInqReqTBS = @as(c_int, 566);
pub const OBJ_setct_CertInqReqTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 48);
};
pub const SN_setct_ErrorTBS = "setct-ErrorTBS";
pub const NID_setct_ErrorTBS = @as(c_int, 567);
pub const OBJ_setct_ErrorTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 49);
};
pub const SN_setct_PIDualSignedTBE = "setct-PIDualSignedTBE";
pub const NID_setct_PIDualSignedTBE = @as(c_int, 568);
pub const OBJ_setct_PIDualSignedTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 50);
};
pub const SN_setct_PIUnsignedTBE = "setct-PIUnsignedTBE";
pub const NID_setct_PIUnsignedTBE = @as(c_int, 569);
pub const OBJ_setct_PIUnsignedTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 51);
};
pub const SN_setct_AuthReqTBE = "setct-AuthReqTBE";
pub const NID_setct_AuthReqTBE = @as(c_int, 570);
pub const OBJ_setct_AuthReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 52);
};
pub const SN_setct_AuthResTBE = "setct-AuthResTBE";
pub const NID_setct_AuthResTBE = @as(c_int, 571);
pub const OBJ_setct_AuthResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 53);
};
pub const SN_setct_AuthResTBEX = "setct-AuthResTBEX";
pub const NID_setct_AuthResTBEX = @as(c_int, 572);
pub const OBJ_setct_AuthResTBEX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 54);
};
pub const SN_setct_AuthTokenTBE = "setct-AuthTokenTBE";
pub const NID_setct_AuthTokenTBE = @as(c_int, 573);
pub const OBJ_setct_AuthTokenTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 55);
};
pub const SN_setct_CapTokenTBE = "setct-CapTokenTBE";
pub const NID_setct_CapTokenTBE = @as(c_int, 574);
pub const OBJ_setct_CapTokenTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 56);
};
pub const SN_setct_CapTokenTBEX = "setct-CapTokenTBEX";
pub const NID_setct_CapTokenTBEX = @as(c_int, 575);
pub const OBJ_setct_CapTokenTBEX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 57);
};
pub const SN_setct_AcqCardCodeMsgTBE = "setct-AcqCardCodeMsgTBE";
pub const NID_setct_AcqCardCodeMsgTBE = @as(c_int, 576);
pub const OBJ_setct_AcqCardCodeMsgTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 58);
};
pub const SN_setct_AuthRevReqTBE = "setct-AuthRevReqTBE";
pub const NID_setct_AuthRevReqTBE = @as(c_int, 577);
pub const OBJ_setct_AuthRevReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 59);
};
pub const SN_setct_AuthRevResTBE = "setct-AuthRevResTBE";
pub const NID_setct_AuthRevResTBE = @as(c_int, 578);
pub const OBJ_setct_AuthRevResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 60);
};
pub const SN_setct_AuthRevResTBEB = "setct-AuthRevResTBEB";
pub const NID_setct_AuthRevResTBEB = @as(c_int, 579);
pub const OBJ_setct_AuthRevResTBEB = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 61);
};
pub const SN_setct_CapReqTBE = "setct-CapReqTBE";
pub const NID_setct_CapReqTBE = @as(c_int, 580);
pub const OBJ_setct_CapReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 62);
};
pub const SN_setct_CapReqTBEX = "setct-CapReqTBEX";
pub const NID_setct_CapReqTBEX = @as(c_int, 581);
pub const OBJ_setct_CapReqTBEX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 63);
};
pub const SN_setct_CapResTBE = "setct-CapResTBE";
pub const NID_setct_CapResTBE = @as(c_int, 582);
pub const OBJ_setct_CapResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 64);
};
pub const SN_setct_CapRevReqTBE = "setct-CapRevReqTBE";
pub const NID_setct_CapRevReqTBE = @as(c_int, 583);
pub const OBJ_setct_CapRevReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 65);
};
pub const SN_setct_CapRevReqTBEX = "setct-CapRevReqTBEX";
pub const NID_setct_CapRevReqTBEX = @as(c_int, 584);
pub const OBJ_setct_CapRevReqTBEX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 66);
};
pub const SN_setct_CapRevResTBE = "setct-CapRevResTBE";
pub const NID_setct_CapRevResTBE = @as(c_int, 585);
pub const OBJ_setct_CapRevResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 67);
};
pub const SN_setct_CredReqTBE = "setct-CredReqTBE";
pub const NID_setct_CredReqTBE = @as(c_int, 586);
pub const OBJ_setct_CredReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 68);
};
pub const SN_setct_CredReqTBEX = "setct-CredReqTBEX";
pub const NID_setct_CredReqTBEX = @as(c_int, 587);
pub const OBJ_setct_CredReqTBEX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 69);
};
pub const SN_setct_CredResTBE = "setct-CredResTBE";
pub const NID_setct_CredResTBE = @as(c_int, 588);
pub const OBJ_setct_CredResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 70);
};
pub const SN_setct_CredRevReqTBE = "setct-CredRevReqTBE";
pub const NID_setct_CredRevReqTBE = @as(c_int, 589);
pub const OBJ_setct_CredRevReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 71);
};
pub const SN_setct_CredRevReqTBEX = "setct-CredRevReqTBEX";
pub const NID_setct_CredRevReqTBEX = @as(c_int, 590);
pub const OBJ_setct_CredRevReqTBEX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 72);
};
pub const SN_setct_CredRevResTBE = "setct-CredRevResTBE";
pub const NID_setct_CredRevResTBE = @as(c_int, 591);
pub const OBJ_setct_CredRevResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 73);
};
pub const SN_setct_BatchAdminReqTBE = "setct-BatchAdminReqTBE";
pub const NID_setct_BatchAdminReqTBE = @as(c_int, 592);
pub const OBJ_setct_BatchAdminReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 74);
};
pub const SN_setct_BatchAdminResTBE = "setct-BatchAdminResTBE";
pub const NID_setct_BatchAdminResTBE = @as(c_int, 593);
pub const OBJ_setct_BatchAdminResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 75);
};
pub const SN_setct_RegFormReqTBE = "setct-RegFormReqTBE";
pub const NID_setct_RegFormReqTBE = @as(c_int, 594);
pub const OBJ_setct_RegFormReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 76);
};
pub const SN_setct_CertReqTBE = "setct-CertReqTBE";
pub const NID_setct_CertReqTBE = @as(c_int, 595);
pub const OBJ_setct_CertReqTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 77);
};
pub const SN_setct_CertReqTBEX = "setct-CertReqTBEX";
pub const NID_setct_CertReqTBEX = @as(c_int, 596);
pub const OBJ_setct_CertReqTBEX = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 78);
};
pub const SN_setct_CertResTBE = "setct-CertResTBE";
pub const NID_setct_CertResTBE = @as(c_int, 597);
pub const OBJ_setct_CertResTBE = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 79);
};
pub const SN_setct_CRLNotificationTBS = "setct-CRLNotificationTBS";
pub const NID_setct_CRLNotificationTBS = @as(c_int, 598);
pub const OBJ_setct_CRLNotificationTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 80);
};
pub const SN_setct_CRLNotificationResTBS = "setct-CRLNotificationResTBS";
pub const NID_setct_CRLNotificationResTBS = @as(c_int, 599);
pub const OBJ_setct_CRLNotificationResTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 81);
};
pub const SN_setct_BCIDistributionTBS = "setct-BCIDistributionTBS";
pub const NID_setct_BCIDistributionTBS = @as(c_int, 600);
pub const OBJ_setct_BCIDistributionTBS = blk: {
    _ = &OBJ_set_ctype;
    break :blk @as(c_long, 82);
};
pub const SN_setext_genCrypt = "setext-genCrypt";
pub const LN_setext_genCrypt = "generic cryptogram";
pub const NID_setext_genCrypt = @as(c_int, 601);
pub const OBJ_setext_genCrypt = blk: {
    _ = &OBJ_set_msgExt;
    break :blk @as(c_long, 1);
};
pub const SN_setext_miAuth = "setext-miAuth";
pub const LN_setext_miAuth = "merchant initiated auth";
pub const NID_setext_miAuth = @as(c_int, 602);
pub const OBJ_setext_miAuth = blk: {
    _ = &OBJ_set_msgExt;
    break :blk @as(c_long, 3);
};
pub const SN_setext_pinSecure = "setext-pinSecure";
pub const NID_setext_pinSecure = @as(c_int, 603);
pub const OBJ_setext_pinSecure = blk: {
    _ = &OBJ_set_msgExt;
    break :blk @as(c_long, 4);
};
pub const SN_setext_pinAny = "setext-pinAny";
pub const NID_setext_pinAny = @as(c_int, 604);
pub const OBJ_setext_pinAny = blk: {
    _ = &OBJ_set_msgExt;
    break :blk @as(c_long, 5);
};
pub const SN_setext_track2 = "setext-track2";
pub const NID_setext_track2 = @as(c_int, 605);
pub const OBJ_setext_track2 = blk: {
    _ = &OBJ_set_msgExt;
    break :blk @as(c_long, 7);
};
pub const SN_setext_cv = "setext-cv";
pub const LN_setext_cv = "additional verification";
pub const NID_setext_cv = @as(c_int, 606);
pub const OBJ_setext_cv = blk: {
    _ = &OBJ_set_msgExt;
    break :blk @as(c_long, 8);
};
pub const SN_set_policy_root = "set-policy-root";
pub const NID_set_policy_root = @as(c_int, 607);
pub const OBJ_set_policy_root = blk: {
    _ = &OBJ_set_policy;
    break :blk @as(c_long, 0);
};
pub const SN_setCext_hashedRoot = "setCext-hashedRoot";
pub const NID_setCext_hashedRoot = @as(c_int, 608);
pub const OBJ_setCext_hashedRoot = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 0);
};
pub const SN_setCext_certType = "setCext-certType";
pub const NID_setCext_certType = @as(c_int, 609);
pub const OBJ_setCext_certType = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 1);
};
pub const SN_setCext_merchData = "setCext-merchData";
pub const NID_setCext_merchData = @as(c_int, 610);
pub const OBJ_setCext_merchData = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 2);
};
pub const SN_setCext_cCertRequired = "setCext-cCertRequired";
pub const NID_setCext_cCertRequired = @as(c_int, 611);
pub const OBJ_setCext_cCertRequired = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 3);
};
pub const SN_setCext_tunneling = "setCext-tunneling";
pub const NID_setCext_tunneling = @as(c_int, 612);
pub const OBJ_setCext_tunneling = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 4);
};
pub const SN_setCext_setExt = "setCext-setExt";
pub const NID_setCext_setExt = @as(c_int, 613);
pub const OBJ_setCext_setExt = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 5);
};
pub const SN_setCext_setQualf = "setCext-setQualf";
pub const NID_setCext_setQualf = @as(c_int, 614);
pub const OBJ_setCext_setQualf = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 6);
};
pub const SN_setCext_PGWYcapabilities = "setCext-PGWYcapabilities";
pub const NID_setCext_PGWYcapabilities = @as(c_int, 615);
pub const OBJ_setCext_PGWYcapabilities = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 7);
};
pub const SN_setCext_TokenIdentifier = "setCext-TokenIdentifier";
pub const NID_setCext_TokenIdentifier = @as(c_int, 616);
pub const OBJ_setCext_TokenIdentifier = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 8);
};
pub const SN_setCext_Track2Data = "setCext-Track2Data";
pub const NID_setCext_Track2Data = @as(c_int, 617);
pub const OBJ_setCext_Track2Data = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 9);
};
pub const SN_setCext_TokenType = "setCext-TokenType";
pub const NID_setCext_TokenType = @as(c_int, 618);
pub const OBJ_setCext_TokenType = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 10);
};
pub const SN_setCext_IssuerCapabilities = "setCext-IssuerCapabilities";
pub const NID_setCext_IssuerCapabilities = @as(c_int, 619);
pub const OBJ_setCext_IssuerCapabilities = blk: {
    _ = &OBJ_set_certExt;
    break :blk @as(c_long, 11);
};
pub const SN_setAttr_Cert = "setAttr-Cert";
pub const NID_setAttr_Cert = @as(c_int, 620);
pub const OBJ_setAttr_Cert = blk: {
    _ = &OBJ_set_attr;
    break :blk @as(c_long, 0);
};
pub const SN_setAttr_PGWYcap = "setAttr-PGWYcap";
pub const LN_setAttr_PGWYcap = "payment gateway capabilities";
pub const NID_setAttr_PGWYcap = @as(c_int, 621);
pub const OBJ_setAttr_PGWYcap = blk: {
    _ = &OBJ_set_attr;
    break :blk @as(c_long, 1);
};
pub const SN_setAttr_TokenType = "setAttr-TokenType";
pub const NID_setAttr_TokenType = @as(c_int, 622);
pub const OBJ_setAttr_TokenType = blk: {
    _ = &OBJ_set_attr;
    break :blk @as(c_long, 2);
};
pub const SN_setAttr_IssCap = "setAttr-IssCap";
pub const LN_setAttr_IssCap = "issuer capabilities";
pub const NID_setAttr_IssCap = @as(c_int, 623);
pub const OBJ_setAttr_IssCap = blk: {
    _ = &OBJ_set_attr;
    break :blk @as(c_long, 3);
};
pub const SN_set_rootKeyThumb = "set-rootKeyThumb";
pub const NID_set_rootKeyThumb = @as(c_int, 624);
pub const OBJ_set_rootKeyThumb = blk: {
    _ = &OBJ_setAttr_Cert;
    break :blk @as(c_long, 0);
};
pub const SN_set_addPolicy = "set-addPolicy";
pub const NID_set_addPolicy = @as(c_int, 625);
pub const OBJ_set_addPolicy = blk: {
    _ = &OBJ_setAttr_Cert;
    break :blk @as(c_long, 1);
};
pub const SN_setAttr_Token_EMV = "setAttr-Token-EMV";
pub const NID_setAttr_Token_EMV = @as(c_int, 626);
pub const OBJ_setAttr_Token_EMV = blk: {
    _ = &OBJ_setAttr_TokenType;
    break :blk @as(c_long, 1);
};
pub const SN_setAttr_Token_B0Prime = "setAttr-Token-B0Prime";
pub const NID_setAttr_Token_B0Prime = @as(c_int, 627);
pub const OBJ_setAttr_Token_B0Prime = blk: {
    _ = &OBJ_setAttr_TokenType;
    break :blk @as(c_long, 2);
};
pub const SN_setAttr_IssCap_CVM = "setAttr-IssCap-CVM";
pub const NID_setAttr_IssCap_CVM = @as(c_int, 628);
pub const OBJ_setAttr_IssCap_CVM = blk: {
    _ = &OBJ_setAttr_IssCap;
    break :blk @as(c_long, 3);
};
pub const SN_setAttr_IssCap_T2 = "setAttr-IssCap-T2";
pub const NID_setAttr_IssCap_T2 = @as(c_int, 629);
pub const OBJ_setAttr_IssCap_T2 = blk: {
    _ = &OBJ_setAttr_IssCap;
    break :blk @as(c_long, 4);
};
pub const SN_setAttr_IssCap_Sig = "setAttr-IssCap-Sig";
pub const NID_setAttr_IssCap_Sig = @as(c_int, 630);
pub const OBJ_setAttr_IssCap_Sig = blk: {
    _ = &OBJ_setAttr_IssCap;
    break :blk @as(c_long, 5);
};
pub const SN_setAttr_GenCryptgrm = "setAttr-GenCryptgrm";
pub const LN_setAttr_GenCryptgrm = "generate cryptogram";
pub const NID_setAttr_GenCryptgrm = @as(c_int, 631);
pub const OBJ_setAttr_GenCryptgrm = blk: {
    _ = &OBJ_setAttr_IssCap_CVM;
    break :blk @as(c_long, 1);
};
pub const SN_setAttr_T2Enc = "setAttr-T2Enc";
pub const LN_setAttr_T2Enc = "encrypted track 2";
pub const NID_setAttr_T2Enc = @as(c_int, 632);
pub const OBJ_setAttr_T2Enc = blk: {
    _ = &OBJ_setAttr_IssCap_T2;
    break :blk @as(c_long, 1);
};
pub const SN_setAttr_T2cleartxt = "setAttr-T2cleartxt";
pub const LN_setAttr_T2cleartxt = "cleartext track 2";
pub const NID_setAttr_T2cleartxt = @as(c_int, 633);
pub const OBJ_setAttr_T2cleartxt = blk: {
    _ = &OBJ_setAttr_IssCap_T2;
    break :blk @as(c_long, 2);
};
pub const SN_setAttr_TokICCsig = "setAttr-TokICCsig";
pub const LN_setAttr_TokICCsig = "ICC or token signature";
pub const NID_setAttr_TokICCsig = @as(c_int, 634);
pub const OBJ_setAttr_TokICCsig = blk: {
    _ = &OBJ_setAttr_IssCap_Sig;
    break :blk @as(c_long, 1);
};
pub const SN_setAttr_SecDevSig = "setAttr-SecDevSig";
pub const LN_setAttr_SecDevSig = "secure device signature";
pub const NID_setAttr_SecDevSig = @as(c_int, 635);
pub const OBJ_setAttr_SecDevSig = blk: {
    _ = &OBJ_setAttr_IssCap_Sig;
    break :blk @as(c_long, 2);
};
pub const SN_set_brand_IATA_ATA = "set-brand-IATA-ATA";
pub const NID_set_brand_IATA_ATA = @as(c_int, 636);
pub const OBJ_set_brand_IATA_ATA = blk: {
    _ = &OBJ_set_brand;
    break :blk @as(c_long, 1);
};
pub const SN_set_brand_Diners = "set-brand-Diners";
pub const NID_set_brand_Diners = @as(c_int, 637);
pub const OBJ_set_brand_Diners = blk: {
    _ = &OBJ_set_brand;
    break :blk @as(c_long, 30);
};
pub const SN_set_brand_AmericanExpress = "set-brand-AmericanExpress";
pub const NID_set_brand_AmericanExpress = @as(c_int, 638);
pub const OBJ_set_brand_AmericanExpress = blk: {
    _ = &OBJ_set_brand;
    break :blk @as(c_long, 34);
};
pub const SN_set_brand_JCB = "set-brand-JCB";
pub const NID_set_brand_JCB = @as(c_int, 639);
pub const OBJ_set_brand_JCB = blk: {
    _ = &OBJ_set_brand;
    break :blk @as(c_long, 35);
};
pub const SN_set_brand_Visa = "set-brand-Visa";
pub const NID_set_brand_Visa = @as(c_int, 640);
pub const OBJ_set_brand_Visa = blk: {
    _ = &OBJ_set_brand;
    break :blk @as(c_long, 4);
};
pub const SN_set_brand_MasterCard = "set-brand-MasterCard";
pub const NID_set_brand_MasterCard = @as(c_int, 641);
pub const OBJ_set_brand_MasterCard = blk: {
    _ = &OBJ_set_brand;
    break :blk @as(c_long, 5);
};
pub const SN_set_brand_Novus = "set-brand-Novus";
pub const NID_set_brand_Novus = @as(c_int, 642);
pub const OBJ_set_brand_Novus = blk: {
    _ = &OBJ_set_brand;
    break :blk @as(c_long, 6011);
};
pub const SN_des_cdmf = "DES-CDMF";
pub const LN_des_cdmf = "des-cdmf";
pub const NID_des_cdmf = @as(c_int, 643);
pub const OBJ_des_cdmf = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 3);
    break :blk @as(c_long, 10);
};
pub const SN_rsaOAEPEncryptionSET = "rsaOAEPEncryptionSET";
pub const NID_rsaOAEPEncryptionSET = @as(c_int, 644);
pub const OBJ_rsaOAEPEncryptionSET = blk: {
    _ = &OBJ_rsadsi;
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 6);
};
pub const SN_ipsec3 = "Oakley-EC2N-3";
pub const LN_ipsec3 = "ipsec3";
pub const NID_ipsec3 = @as(c_int, 749);
pub const SN_ipsec4 = "Oakley-EC2N-4";
pub const LN_ipsec4 = "ipsec4";
pub const NID_ipsec4 = @as(c_int, 750);
pub const SN_whirlpool = "whirlpool";
pub const NID_whirlpool = @as(c_int, 804);
pub const OBJ_whirlpool = blk: {
    _ = &OBJ_iso;
    _ = @as(c_long, 0);
    _ = @as(c_long, 10118);
    _ = @as(c_long, 3);
    _ = @as(c_long, 0);
    break :blk @as(c_long, 55);
};
pub const SN_cryptopro = "cryptopro";
pub const NID_cryptopro = @as(c_int, 805);
pub const OBJ_cryptopro = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 2);
};
pub const SN_cryptocom = "cryptocom";
pub const NID_cryptocom = @as(c_int, 806);
pub const OBJ_cryptocom = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 9);
};
pub const SN_id_tc26 = "id-tc26";
pub const NID_id_tc26 = @as(c_int, 974);
pub const OBJ_id_tc26 = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 7);
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3411_94_with_GostR3410_2001 = "id-GostR3411-94-with-GostR3410-2001";
pub const LN_id_GostR3411_94_with_GostR3410_2001 = "GOST R 34.11-94 with GOST R 34.10-2001";
pub const NID_id_GostR3411_94_with_GostR3410_2001 = @as(c_int, 807);
pub const OBJ_id_GostR3411_94_with_GostR3410_2001 = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 3);
};
pub const SN_id_GostR3411_94_with_GostR3410_94 = "id-GostR3411-94-with-GostR3410-94";
pub const LN_id_GostR3411_94_with_GostR3410_94 = "GOST R 34.11-94 with GOST R 34.10-94";
pub const NID_id_GostR3411_94_with_GostR3410_94 = @as(c_int, 808);
pub const OBJ_id_GostR3411_94_with_GostR3410_94 = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 4);
};
pub const SN_id_GostR3411_94 = "md_gost94";
pub const LN_id_GostR3411_94 = "GOST R 34.11-94";
pub const NID_id_GostR3411_94 = @as(c_int, 809);
pub const OBJ_id_GostR3411_94 = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 9);
};
pub const SN_id_HMACGostR3411_94 = "id-HMACGostR3411-94";
pub const LN_id_HMACGostR3411_94 = "HMAC GOST 34.11-94";
pub const NID_id_HMACGostR3411_94 = @as(c_int, 810);
pub const OBJ_id_HMACGostR3411_94 = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 10);
};
pub const SN_id_GostR3410_2001 = "gost2001";
pub const LN_id_GostR3410_2001 = "GOST R 34.10-2001";
pub const NID_id_GostR3410_2001 = @as(c_int, 811);
pub const OBJ_id_GostR3410_2001 = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 19);
};
pub const SN_id_GostR3410_94 = "gost94";
pub const LN_id_GostR3410_94 = "GOST R 34.10-94";
pub const NID_id_GostR3410_94 = @as(c_int, 812);
pub const OBJ_id_GostR3410_94 = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 20);
};
pub const SN_id_Gost28147_89 = "gost89";
pub const LN_id_Gost28147_89 = "GOST 28147-89";
pub const NID_id_Gost28147_89 = @as(c_int, 813);
pub const OBJ_id_Gost28147_89 = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 21);
};
pub const SN_gost89_cnt = "gost89-cnt";
pub const NID_gost89_cnt = @as(c_int, 814);
pub const SN_gost89_cnt_12 = "gost89-cnt-12";
pub const NID_gost89_cnt_12 = @as(c_int, 975);
pub const SN_gost89_cbc = "gost89-cbc";
pub const NID_gost89_cbc = @as(c_int, 1009);
pub const SN_gost89_ecb = "gost89-ecb";
pub const NID_gost89_ecb = @as(c_int, 1010);
pub const SN_gost89_ctr = "gost89-ctr";
pub const NID_gost89_ctr = @as(c_int, 1011);
pub const SN_id_Gost28147_89_MAC = "gost-mac";
pub const LN_id_Gost28147_89_MAC = "GOST 28147-89 MAC";
pub const NID_id_Gost28147_89_MAC = @as(c_int, 815);
pub const OBJ_id_Gost28147_89_MAC = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 22);
};
pub const SN_gost_mac_12 = "gost-mac-12";
pub const NID_gost_mac_12 = @as(c_int, 976);
pub const SN_id_GostR3411_94_prf = "prf-gostr3411-94";
pub const LN_id_GostR3411_94_prf = "GOST R 34.11-94 PRF";
pub const NID_id_GostR3411_94_prf = @as(c_int, 816);
pub const OBJ_id_GostR3411_94_prf = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 23);
};
pub const SN_id_GostR3410_2001DH = "id-GostR3410-2001DH";
pub const LN_id_GostR3410_2001DH = "GOST R 34.10-2001 DH";
pub const NID_id_GostR3410_2001DH = @as(c_int, 817);
pub const OBJ_id_GostR3410_2001DH = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 98);
};
pub const SN_id_GostR3410_94DH = "id-GostR3410-94DH";
pub const LN_id_GostR3410_94DH = "GOST R 34.10-94 DH";
pub const NID_id_GostR3410_94DH = @as(c_int, 818);
pub const OBJ_id_GostR3410_94DH = blk: {
    _ = &OBJ_cryptopro;
    break :blk @as(c_long, 99);
};
pub const SN_id_Gost28147_89_CryptoPro_KeyMeshing = "id-Gost28147-89-CryptoPro-KeyMeshing";
pub const NID_id_Gost28147_89_CryptoPro_KeyMeshing = @as(c_int, 819);
pub const OBJ_id_Gost28147_89_CryptoPro_KeyMeshing = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 14);
    break :blk @as(c_long, 1);
};
pub const SN_id_Gost28147_89_None_KeyMeshing = "id-Gost28147-89-None-KeyMeshing";
pub const NID_id_Gost28147_89_None_KeyMeshing = @as(c_int, 820);
pub const OBJ_id_Gost28147_89_None_KeyMeshing = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 14);
    break :blk @as(c_long, 0);
};
pub const SN_id_GostR3411_94_TestParamSet = "id-GostR3411-94-TestParamSet";
pub const NID_id_GostR3411_94_TestParamSet = @as(c_int, 821);
pub const OBJ_id_GostR3411_94_TestParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 30);
    break :blk @as(c_long, 0);
};
pub const SN_id_GostR3411_94_CryptoProParamSet = "id-GostR3411-94-CryptoProParamSet";
pub const NID_id_GostR3411_94_CryptoProParamSet = @as(c_int, 822);
pub const OBJ_id_GostR3411_94_CryptoProParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 30);
    break :blk @as(c_long, 1);
};
pub const SN_id_Gost28147_89_TestParamSet = "id-Gost28147-89-TestParamSet";
pub const NID_id_Gost28147_89_TestParamSet = @as(c_int, 823);
pub const OBJ_id_Gost28147_89_TestParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 0);
};
pub const SN_id_Gost28147_89_CryptoPro_A_ParamSet = "id-Gost28147-89-CryptoPro-A-ParamSet";
pub const NID_id_Gost28147_89_CryptoPro_A_ParamSet = @as(c_int, 824);
pub const OBJ_id_Gost28147_89_CryptoPro_A_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 1);
};
pub const SN_id_Gost28147_89_CryptoPro_B_ParamSet = "id-Gost28147-89-CryptoPro-B-ParamSet";
pub const NID_id_Gost28147_89_CryptoPro_B_ParamSet = @as(c_int, 825);
pub const OBJ_id_Gost28147_89_CryptoPro_B_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 2);
};
pub const SN_id_Gost28147_89_CryptoPro_C_ParamSet = "id-Gost28147-89-CryptoPro-C-ParamSet";
pub const NID_id_Gost28147_89_CryptoPro_C_ParamSet = @as(c_int, 826);
pub const OBJ_id_Gost28147_89_CryptoPro_C_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 3);
};
pub const SN_id_Gost28147_89_CryptoPro_D_ParamSet = "id-Gost28147-89-CryptoPro-D-ParamSet";
pub const NID_id_Gost28147_89_CryptoPro_D_ParamSet = @as(c_int, 827);
pub const OBJ_id_Gost28147_89_CryptoPro_D_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 4);
};
pub const SN_id_Gost28147_89_CryptoPro_Oscar_1_1_ParamSet = "id-Gost28147-89-CryptoPro-Oscar-1-1-ParamSet";
pub const NID_id_Gost28147_89_CryptoPro_Oscar_1_1_ParamSet = @as(c_int, 828);
pub const OBJ_id_Gost28147_89_CryptoPro_Oscar_1_1_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 5);
};
pub const SN_id_Gost28147_89_CryptoPro_Oscar_1_0_ParamSet = "id-Gost28147-89-CryptoPro-Oscar-1-0-ParamSet";
pub const NID_id_Gost28147_89_CryptoPro_Oscar_1_0_ParamSet = @as(c_int, 829);
pub const OBJ_id_Gost28147_89_CryptoPro_Oscar_1_0_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 6);
};
pub const SN_id_Gost28147_89_CryptoPro_RIC_1_ParamSet = "id-Gost28147-89-CryptoPro-RIC-1-ParamSet";
pub const NID_id_Gost28147_89_CryptoPro_RIC_1_ParamSet = @as(c_int, 830);
pub const OBJ_id_Gost28147_89_CryptoPro_RIC_1_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 31);
    break :blk @as(c_long, 7);
};
pub const SN_id_GostR3410_94_TestParamSet = "id-GostR3410-94-TestParamSet";
pub const NID_id_GostR3410_94_TestParamSet = @as(c_int, 831);
pub const OBJ_id_GostR3410_94_TestParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 32);
    break :blk @as(c_long, 0);
};
pub const SN_id_GostR3410_94_CryptoPro_A_ParamSet = "id-GostR3410-94-CryptoPro-A-ParamSet";
pub const NID_id_GostR3410_94_CryptoPro_A_ParamSet = @as(c_int, 832);
pub const OBJ_id_GostR3410_94_CryptoPro_A_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 32);
    break :blk @as(c_long, 2);
};
pub const SN_id_GostR3410_94_CryptoPro_B_ParamSet = "id-GostR3410-94-CryptoPro-B-ParamSet";
pub const NID_id_GostR3410_94_CryptoPro_B_ParamSet = @as(c_int, 833);
pub const OBJ_id_GostR3410_94_CryptoPro_B_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 32);
    break :blk @as(c_long, 3);
};
pub const SN_id_GostR3410_94_CryptoPro_C_ParamSet = "id-GostR3410-94-CryptoPro-C-ParamSet";
pub const NID_id_GostR3410_94_CryptoPro_C_ParamSet = @as(c_int, 834);
pub const OBJ_id_GostR3410_94_CryptoPro_C_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 32);
    break :blk @as(c_long, 4);
};
pub const SN_id_GostR3410_94_CryptoPro_D_ParamSet = "id-GostR3410-94-CryptoPro-D-ParamSet";
pub const NID_id_GostR3410_94_CryptoPro_D_ParamSet = @as(c_int, 835);
pub const OBJ_id_GostR3410_94_CryptoPro_D_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 32);
    break :blk @as(c_long, 5);
};
pub const SN_id_GostR3410_94_CryptoPro_XchA_ParamSet = "id-GostR3410-94-CryptoPro-XchA-ParamSet";
pub const NID_id_GostR3410_94_CryptoPro_XchA_ParamSet = @as(c_int, 836);
pub const OBJ_id_GostR3410_94_CryptoPro_XchA_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 33);
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3410_94_CryptoPro_XchB_ParamSet = "id-GostR3410-94-CryptoPro-XchB-ParamSet";
pub const NID_id_GostR3410_94_CryptoPro_XchB_ParamSet = @as(c_int, 837);
pub const OBJ_id_GostR3410_94_CryptoPro_XchB_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 33);
    break :blk @as(c_long, 2);
};
pub const SN_id_GostR3410_94_CryptoPro_XchC_ParamSet = "id-GostR3410-94-CryptoPro-XchC-ParamSet";
pub const NID_id_GostR3410_94_CryptoPro_XchC_ParamSet = @as(c_int, 838);
pub const OBJ_id_GostR3410_94_CryptoPro_XchC_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 33);
    break :blk @as(c_long, 3);
};
pub const SN_id_GostR3410_2001_TestParamSet = "id-GostR3410-2001-TestParamSet";
pub const NID_id_GostR3410_2001_TestParamSet = @as(c_int, 839);
pub const OBJ_id_GostR3410_2001_TestParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 35);
    break :blk @as(c_long, 0);
};
pub const SN_id_GostR3410_2001_CryptoPro_A_ParamSet = "id-GostR3410-2001-CryptoPro-A-ParamSet";
pub const NID_id_GostR3410_2001_CryptoPro_A_ParamSet = @as(c_int, 840);
pub const OBJ_id_GostR3410_2001_CryptoPro_A_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 35);
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3410_2001_CryptoPro_B_ParamSet = "id-GostR3410-2001-CryptoPro-B-ParamSet";
pub const NID_id_GostR3410_2001_CryptoPro_B_ParamSet = @as(c_int, 841);
pub const OBJ_id_GostR3410_2001_CryptoPro_B_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 35);
    break :blk @as(c_long, 2);
};
pub const SN_id_GostR3410_2001_CryptoPro_C_ParamSet = "id-GostR3410-2001-CryptoPro-C-ParamSet";
pub const NID_id_GostR3410_2001_CryptoPro_C_ParamSet = @as(c_int, 842);
pub const OBJ_id_GostR3410_2001_CryptoPro_C_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 35);
    break :blk @as(c_long, 3);
};
pub const SN_id_GostR3410_2001_CryptoPro_XchA_ParamSet = "id-GostR3410-2001-CryptoPro-XchA-ParamSet";
pub const NID_id_GostR3410_2001_CryptoPro_XchA_ParamSet = @as(c_int, 843);
pub const OBJ_id_GostR3410_2001_CryptoPro_XchA_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 36);
    break :blk @as(c_long, 0);
};
pub const SN_id_GostR3410_2001_CryptoPro_XchB_ParamSet = "id-GostR3410-2001-CryptoPro-XchB-ParamSet";
pub const NID_id_GostR3410_2001_CryptoPro_XchB_ParamSet = @as(c_int, 844);
pub const OBJ_id_GostR3410_2001_CryptoPro_XchB_ParamSet = blk: {
    _ = &OBJ_cryptopro;
    _ = @as(c_long, 36);
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3410_94_a = "id-GostR3410-94-a";
pub const NID_id_GostR3410_94_a = @as(c_int, 845);
pub const OBJ_id_GostR3410_94_a = blk: {
    _ = &OBJ_id_GostR3410_94;
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3410_94_aBis = "id-GostR3410-94-aBis";
pub const NID_id_GostR3410_94_aBis = @as(c_int, 846);
pub const OBJ_id_GostR3410_94_aBis = blk: {
    _ = &OBJ_id_GostR3410_94;
    break :blk @as(c_long, 2);
};
pub const SN_id_GostR3410_94_b = "id-GostR3410-94-b";
pub const NID_id_GostR3410_94_b = @as(c_int, 847);
pub const OBJ_id_GostR3410_94_b = blk: {
    _ = &OBJ_id_GostR3410_94;
    break :blk @as(c_long, 3);
};
pub const SN_id_GostR3410_94_bBis = "id-GostR3410-94-bBis";
pub const NID_id_GostR3410_94_bBis = @as(c_int, 848);
pub const OBJ_id_GostR3410_94_bBis = blk: {
    _ = &OBJ_id_GostR3410_94;
    break :blk @as(c_long, 4);
};
pub const SN_id_Gost28147_89_cc = "id-Gost28147-89-cc";
pub const LN_id_Gost28147_89_cc = "GOST 28147-89 Cryptocom ParamSet";
pub const NID_id_Gost28147_89_cc = @as(c_int, 849);
pub const OBJ_id_Gost28147_89_cc = blk: {
    _ = &OBJ_cryptocom;
    _ = @as(c_long, 1);
    _ = @as(c_long, 6);
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3410_94_cc = "gost94cc";
pub const LN_id_GostR3410_94_cc = "GOST 34.10-94 Cryptocom";
pub const NID_id_GostR3410_94_cc = @as(c_int, 850);
pub const OBJ_id_GostR3410_94_cc = blk: {
    _ = &OBJ_cryptocom;
    _ = @as(c_long, 1);
    _ = @as(c_long, 5);
    break :blk @as(c_long, 3);
};
pub const SN_id_GostR3410_2001_cc = "gost2001cc";
pub const LN_id_GostR3410_2001_cc = "GOST 34.10-2001 Cryptocom";
pub const NID_id_GostR3410_2001_cc = @as(c_int, 851);
pub const OBJ_id_GostR3410_2001_cc = blk: {
    _ = &OBJ_cryptocom;
    _ = @as(c_long, 1);
    _ = @as(c_long, 5);
    break :blk @as(c_long, 4);
};
pub const SN_id_GostR3411_94_with_GostR3410_94_cc = "id-GostR3411-94-with-GostR3410-94-cc";
pub const LN_id_GostR3411_94_with_GostR3410_94_cc = "GOST R 34.11-94 with GOST R 34.10-94 Cryptocom";
pub const NID_id_GostR3411_94_with_GostR3410_94_cc = @as(c_int, 852);
pub const OBJ_id_GostR3411_94_with_GostR3410_94_cc = blk: {
    _ = &OBJ_cryptocom;
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 3);
};
pub const SN_id_GostR3411_94_with_GostR3410_2001_cc = "id-GostR3411-94-with-GostR3410-2001-cc";
pub const LN_id_GostR3411_94_with_GostR3410_2001_cc = "GOST R 34.11-94 with GOST R 34.10-2001 Cryptocom";
pub const NID_id_GostR3411_94_with_GostR3410_2001_cc = @as(c_int, 853);
pub const OBJ_id_GostR3411_94_with_GostR3410_2001_cc = blk: {
    _ = &OBJ_cryptocom;
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 4);
};
pub const SN_id_GostR3410_2001_ParamSet_cc = "id-GostR3410-2001-ParamSet-cc";
pub const LN_id_GostR3410_2001_ParamSet_cc = "GOST R 3410-2001 Parameter Set Cryptocom";
pub const NID_id_GostR3410_2001_ParamSet_cc = @as(c_int, 854);
pub const OBJ_id_GostR3410_2001_ParamSet_cc = blk: {
    _ = &OBJ_cryptocom;
    _ = @as(c_long, 1);
    _ = @as(c_long, 8);
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_algorithms = "id-tc26-algorithms";
pub const NID_id_tc26_algorithms = @as(c_int, 977);
pub const OBJ_id_tc26_algorithms = blk: {
    _ = &OBJ_id_tc26;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_sign = "id-tc26-sign";
pub const NID_id_tc26_sign = @as(c_int, 978);
pub const OBJ_id_tc26_sign = blk: {
    _ = &OBJ_id_tc26_algorithms;
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3410_2012_256 = "gost2012_256";
pub const LN_id_GostR3410_2012_256 = "GOST R 34.10-2012 with 256 bit modulus";
pub const NID_id_GostR3410_2012_256 = @as(c_int, 979);
pub const OBJ_id_GostR3410_2012_256 = blk: {
    _ = &OBJ_id_tc26_sign;
    break :blk @as(c_long, 1);
};
pub const SN_id_GostR3410_2012_512 = "gost2012_512";
pub const LN_id_GostR3410_2012_512 = "GOST R 34.10-2012 with 512 bit modulus";
pub const NID_id_GostR3410_2012_512 = @as(c_int, 980);
pub const OBJ_id_GostR3410_2012_512 = blk: {
    _ = &OBJ_id_tc26_sign;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_digest = "id-tc26-digest";
pub const NID_id_tc26_digest = @as(c_int, 981);
pub const OBJ_id_tc26_digest = blk: {
    _ = &OBJ_id_tc26_algorithms;
    break :blk @as(c_long, 2);
};
pub const SN_id_GostR3411_2012_256 = "md_gost12_256";
pub const LN_id_GostR3411_2012_256 = "GOST R 34.11-2012 with 256 bit hash";
pub const NID_id_GostR3411_2012_256 = @as(c_int, 982);
pub const OBJ_id_GostR3411_2012_256 = blk: {
    _ = &OBJ_id_tc26_digest;
    break :blk @as(c_long, 2);
};
pub const SN_id_GostR3411_2012_512 = "md_gost12_512";
pub const LN_id_GostR3411_2012_512 = "GOST R 34.11-2012 with 512 bit hash";
pub const NID_id_GostR3411_2012_512 = @as(c_int, 983);
pub const OBJ_id_GostR3411_2012_512 = blk: {
    _ = &OBJ_id_tc26_digest;
    break :blk @as(c_long, 3);
};
pub const SN_id_tc26_signwithdigest = "id-tc26-signwithdigest";
pub const NID_id_tc26_signwithdigest = @as(c_int, 984);
pub const OBJ_id_tc26_signwithdigest = blk: {
    _ = &OBJ_id_tc26_algorithms;
    break :blk @as(c_long, 3);
};
pub const SN_id_tc26_signwithdigest_gost3410_2012_256 = "id-tc26-signwithdigest-gost3410-2012-256";
pub const LN_id_tc26_signwithdigest_gost3410_2012_256 = "GOST R 34.10-2012 with GOST R 34.11-2012 (256 bit)";
pub const NID_id_tc26_signwithdigest_gost3410_2012_256 = @as(c_int, 985);
pub const OBJ_id_tc26_signwithdigest_gost3410_2012_256 = blk: {
    _ = &OBJ_id_tc26_signwithdigest;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_signwithdigest_gost3410_2012_512 = "id-tc26-signwithdigest-gost3410-2012-512";
pub const LN_id_tc26_signwithdigest_gost3410_2012_512 = "GOST R 34.10-2012 with GOST R 34.11-2012 (512 bit)";
pub const NID_id_tc26_signwithdigest_gost3410_2012_512 = @as(c_int, 986);
pub const OBJ_id_tc26_signwithdigest_gost3410_2012_512 = blk: {
    _ = &OBJ_id_tc26_signwithdigest;
    break :blk @as(c_long, 3);
};
pub const SN_id_tc26_mac = "id-tc26-mac";
pub const NID_id_tc26_mac = @as(c_int, 987);
pub const OBJ_id_tc26_mac = blk: {
    _ = &OBJ_id_tc26_algorithms;
    break :blk @as(c_long, 4);
};
pub const SN_id_tc26_hmac_gost_3411_2012_256 = "id-tc26-hmac-gost-3411-2012-256";
pub const LN_id_tc26_hmac_gost_3411_2012_256 = "HMAC GOST 34.11-2012 256 bit";
pub const NID_id_tc26_hmac_gost_3411_2012_256 = @as(c_int, 988);
pub const OBJ_id_tc26_hmac_gost_3411_2012_256 = blk: {
    _ = &OBJ_id_tc26_mac;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_hmac_gost_3411_2012_512 = "id-tc26-hmac-gost-3411-2012-512";
pub const LN_id_tc26_hmac_gost_3411_2012_512 = "HMAC GOST 34.11-2012 512 bit";
pub const NID_id_tc26_hmac_gost_3411_2012_512 = @as(c_int, 989);
pub const OBJ_id_tc26_hmac_gost_3411_2012_512 = blk: {
    _ = &OBJ_id_tc26_mac;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_cipher = "id-tc26-cipher";
pub const NID_id_tc26_cipher = @as(c_int, 990);
pub const OBJ_id_tc26_cipher = blk: {
    _ = &OBJ_id_tc26_algorithms;
    break :blk @as(c_long, 5);
};
pub const SN_id_tc26_cipher_gostr3412_2015_magma = "id-tc26-cipher-gostr3412-2015-magma";
pub const NID_id_tc26_cipher_gostr3412_2015_magma = @as(c_int, 1173);
pub const OBJ_id_tc26_cipher_gostr3412_2015_magma = blk: {
    _ = &OBJ_id_tc26_cipher;
    break :blk @as(c_long, 1);
};
pub const SN_magma_ctr_acpkm = "magma-ctr-acpkm";
pub const NID_magma_ctr_acpkm = @as(c_int, 1174);
pub const OBJ_magma_ctr_acpkm = blk: {
    _ = &OBJ_id_tc26_cipher_gostr3412_2015_magma;
    break :blk @as(c_long, 1);
};
pub const SN_magma_ctr_acpkm_omac = "magma-ctr-acpkm-omac";
pub const NID_magma_ctr_acpkm_omac = @as(c_int, 1175);
pub const OBJ_magma_ctr_acpkm_omac = blk: {
    _ = &OBJ_id_tc26_cipher_gostr3412_2015_magma;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_cipher_gostr3412_2015_kuznyechik = "id-tc26-cipher-gostr3412-2015-kuznyechik";
pub const NID_id_tc26_cipher_gostr3412_2015_kuznyechik = @as(c_int, 1176);
pub const OBJ_id_tc26_cipher_gostr3412_2015_kuznyechik = blk: {
    _ = &OBJ_id_tc26_cipher;
    break :blk @as(c_long, 2);
};
pub const SN_kuznyechik_ctr_acpkm = "kuznyechik-ctr-acpkm";
pub const NID_kuznyechik_ctr_acpkm = @as(c_int, 1177);
pub const OBJ_kuznyechik_ctr_acpkm = blk: {
    _ = &OBJ_id_tc26_cipher_gostr3412_2015_kuznyechik;
    break :blk @as(c_long, 1);
};
pub const SN_kuznyechik_ctr_acpkm_omac = "kuznyechik-ctr-acpkm-omac";
pub const NID_kuznyechik_ctr_acpkm_omac = @as(c_int, 1178);
pub const OBJ_kuznyechik_ctr_acpkm_omac = blk: {
    _ = &OBJ_id_tc26_cipher_gostr3412_2015_kuznyechik;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_agreement = "id-tc26-agreement";
pub const NID_id_tc26_agreement = @as(c_int, 991);
pub const OBJ_id_tc26_agreement = blk: {
    _ = &OBJ_id_tc26_algorithms;
    break :blk @as(c_long, 6);
};
pub const SN_id_tc26_agreement_gost_3410_2012_256 = "id-tc26-agreement-gost-3410-2012-256";
pub const NID_id_tc26_agreement_gost_3410_2012_256 = @as(c_int, 992);
pub const OBJ_id_tc26_agreement_gost_3410_2012_256 = blk: {
    _ = &OBJ_id_tc26_agreement;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_agreement_gost_3410_2012_512 = "id-tc26-agreement-gost-3410-2012-512";
pub const NID_id_tc26_agreement_gost_3410_2012_512 = @as(c_int, 993);
pub const OBJ_id_tc26_agreement_gost_3410_2012_512 = blk: {
    _ = &OBJ_id_tc26_agreement;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_wrap = "id-tc26-wrap";
pub const NID_id_tc26_wrap = @as(c_int, 1179);
pub const OBJ_id_tc26_wrap = blk: {
    _ = &OBJ_id_tc26_algorithms;
    break :blk @as(c_long, 7);
};
pub const SN_id_tc26_wrap_gostr3412_2015_magma = "id-tc26-wrap-gostr3412-2015-magma";
pub const NID_id_tc26_wrap_gostr3412_2015_magma = @as(c_int, 1180);
pub const OBJ_id_tc26_wrap_gostr3412_2015_magma = blk: {
    _ = &OBJ_id_tc26_wrap;
    break :blk @as(c_long, 1);
};
pub const SN_magma_kexp15 = "magma-kexp15";
pub const NID_magma_kexp15 = @as(c_int, 1181);
pub const OBJ_magma_kexp15 = blk: {
    _ = &OBJ_id_tc26_wrap_gostr3412_2015_magma;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_wrap_gostr3412_2015_kuznyechik = "id-tc26-wrap-gostr3412-2015-kuznyechik";
pub const NID_id_tc26_wrap_gostr3412_2015_kuznyechik = @as(c_int, 1182);
pub const OBJ_id_tc26_wrap_gostr3412_2015_kuznyechik = blk: {
    _ = &OBJ_id_tc26_wrap;
    break :blk @as(c_long, 2);
};
pub const SN_kuznyechik_kexp15 = "kuznyechik-kexp15";
pub const NID_kuznyechik_kexp15 = @as(c_int, 1183);
pub const OBJ_kuznyechik_kexp15 = blk: {
    _ = &OBJ_id_tc26_wrap_gostr3412_2015_kuznyechik;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_constants = "id-tc26-constants";
pub const NID_id_tc26_constants = @as(c_int, 994);
pub const OBJ_id_tc26_constants = blk: {
    _ = &OBJ_id_tc26;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_sign_constants = "id-tc26-sign-constants";
pub const NID_id_tc26_sign_constants = @as(c_int, 995);
pub const OBJ_id_tc26_sign_constants = blk: {
    _ = &OBJ_id_tc26_constants;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_gost_3410_2012_256_constants = "id-tc26-gost-3410-2012-256-constants";
pub const NID_id_tc26_gost_3410_2012_256_constants = @as(c_int, 1147);
pub const OBJ_id_tc26_gost_3410_2012_256_constants = blk: {
    _ = &OBJ_id_tc26_sign_constants;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_gost_3410_2012_256_paramSetA = "id-tc26-gost-3410-2012-256-paramSetA";
pub const LN_id_tc26_gost_3410_2012_256_paramSetA = "GOST R 34.10-2012 (256 bit) ParamSet A";
pub const NID_id_tc26_gost_3410_2012_256_paramSetA = @as(c_int, 1148);
pub const OBJ_id_tc26_gost_3410_2012_256_paramSetA = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_256_constants;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_gost_3410_2012_256_paramSetB = "id-tc26-gost-3410-2012-256-paramSetB";
pub const LN_id_tc26_gost_3410_2012_256_paramSetB = "GOST R 34.10-2012 (256 bit) ParamSet B";
pub const NID_id_tc26_gost_3410_2012_256_paramSetB = @as(c_int, 1184);
pub const OBJ_id_tc26_gost_3410_2012_256_paramSetB = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_256_constants;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_gost_3410_2012_256_paramSetC = "id-tc26-gost-3410-2012-256-paramSetC";
pub const LN_id_tc26_gost_3410_2012_256_paramSetC = "GOST R 34.10-2012 (256 bit) ParamSet C";
pub const NID_id_tc26_gost_3410_2012_256_paramSetC = @as(c_int, 1185);
pub const OBJ_id_tc26_gost_3410_2012_256_paramSetC = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_256_constants;
    break :blk @as(c_long, 3);
};
pub const SN_id_tc26_gost_3410_2012_256_paramSetD = "id-tc26-gost-3410-2012-256-paramSetD";
pub const LN_id_tc26_gost_3410_2012_256_paramSetD = "GOST R 34.10-2012 (256 bit) ParamSet D";
pub const NID_id_tc26_gost_3410_2012_256_paramSetD = @as(c_int, 1186);
pub const OBJ_id_tc26_gost_3410_2012_256_paramSetD = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_256_constants;
    break :blk @as(c_long, 4);
};
pub const SN_id_tc26_gost_3410_2012_512_constants = "id-tc26-gost-3410-2012-512-constants";
pub const NID_id_tc26_gost_3410_2012_512_constants = @as(c_int, 996);
pub const OBJ_id_tc26_gost_3410_2012_512_constants = blk: {
    _ = &OBJ_id_tc26_sign_constants;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_gost_3410_2012_512_paramSetTest = "id-tc26-gost-3410-2012-512-paramSetTest";
pub const LN_id_tc26_gost_3410_2012_512_paramSetTest = "GOST R 34.10-2012 (512 bit) testing parameter set";
pub const NID_id_tc26_gost_3410_2012_512_paramSetTest = @as(c_int, 997);
pub const OBJ_id_tc26_gost_3410_2012_512_paramSetTest = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_512_constants;
    break :blk @as(c_long, 0);
};
pub const SN_id_tc26_gost_3410_2012_512_paramSetA = "id-tc26-gost-3410-2012-512-paramSetA";
pub const LN_id_tc26_gost_3410_2012_512_paramSetA = "GOST R 34.10-2012 (512 bit) ParamSet A";
pub const NID_id_tc26_gost_3410_2012_512_paramSetA = @as(c_int, 998);
pub const OBJ_id_tc26_gost_3410_2012_512_paramSetA = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_512_constants;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_gost_3410_2012_512_paramSetB = "id-tc26-gost-3410-2012-512-paramSetB";
pub const LN_id_tc26_gost_3410_2012_512_paramSetB = "GOST R 34.10-2012 (512 bit) ParamSet B";
pub const NID_id_tc26_gost_3410_2012_512_paramSetB = @as(c_int, 999);
pub const OBJ_id_tc26_gost_3410_2012_512_paramSetB = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_512_constants;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_gost_3410_2012_512_paramSetC = "id-tc26-gost-3410-2012-512-paramSetC";
pub const LN_id_tc26_gost_3410_2012_512_paramSetC = "GOST R 34.10-2012 (512 bit) ParamSet C";
pub const NID_id_tc26_gost_3410_2012_512_paramSetC = @as(c_int, 1149);
pub const OBJ_id_tc26_gost_3410_2012_512_paramSetC = blk: {
    _ = &OBJ_id_tc26_gost_3410_2012_512_constants;
    break :blk @as(c_long, 3);
};
pub const SN_id_tc26_digest_constants = "id-tc26-digest-constants";
pub const NID_id_tc26_digest_constants = @as(c_int, 1000);
pub const OBJ_id_tc26_digest_constants = blk: {
    _ = &OBJ_id_tc26_constants;
    break :blk @as(c_long, 2);
};
pub const SN_id_tc26_cipher_constants = "id-tc26-cipher-constants";
pub const NID_id_tc26_cipher_constants = @as(c_int, 1001);
pub const OBJ_id_tc26_cipher_constants = blk: {
    _ = &OBJ_id_tc26_constants;
    break :blk @as(c_long, 5);
};
pub const SN_id_tc26_gost_28147_constants = "id-tc26-gost-28147-constants";
pub const NID_id_tc26_gost_28147_constants = @as(c_int, 1002);
pub const OBJ_id_tc26_gost_28147_constants = blk: {
    _ = &OBJ_id_tc26_cipher_constants;
    break :blk @as(c_long, 1);
};
pub const SN_id_tc26_gost_28147_param_Z = "id-tc26-gost-28147-param-Z";
pub const LN_id_tc26_gost_28147_param_Z = "GOST 28147-89 TC26 parameter set";
pub const NID_id_tc26_gost_28147_param_Z = @as(c_int, 1003);
pub const OBJ_id_tc26_gost_28147_param_Z = blk: {
    _ = &OBJ_id_tc26_gost_28147_constants;
    break :blk @as(c_long, 1);
};
pub const SN_INN = "INN";
pub const LN_INN = "INN";
pub const NID_INN = @as(c_int, 1004);
pub const OBJ_INN = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 3);
    _ = @as(c_long, 131);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_OGRN = "OGRN";
pub const LN_OGRN = "OGRN";
pub const NID_OGRN = @as(c_int, 1005);
pub const OBJ_OGRN = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    break :blk @as(c_long, 1);
};
pub const SN_SNILS = "SNILS";
pub const LN_SNILS = "SNILS";
pub const NID_SNILS = @as(c_int, 1006);
pub const OBJ_SNILS = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    break :blk @as(c_long, 3);
};
pub const SN_OGRNIP = "OGRNIP";
pub const LN_OGRNIP = "OGRNIP";
pub const NID_OGRNIP = @as(c_int, 1226);
pub const OBJ_OGRNIP = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    break :blk @as(c_long, 5);
};
pub const SN_subjectSignTool = "subjectSignTool";
pub const LN_subjectSignTool = "Signing Tool of Subject";
pub const NID_subjectSignTool = @as(c_int, 1007);
pub const OBJ_subjectSignTool = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    break :blk @as(c_long, 111);
};
pub const SN_issuerSignTool = "issuerSignTool";
pub const LN_issuerSignTool = "Signing Tool of Issuer";
pub const NID_issuerSignTool = @as(c_int, 1008);
pub const OBJ_issuerSignTool = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    break :blk @as(c_long, 112);
};
pub const SN_classSignTool = "classSignTool";
pub const LN_classSignTool = "Class of Signing Tool";
pub const NID_classSignTool = @as(c_int, 1227);
pub const OBJ_classSignTool = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    break :blk @as(c_long, 113);
};
pub const SN_classSignToolKC1 = "classSignToolKC1";
pub const LN_classSignToolKC1 = "Class of Signing Tool KC1";
pub const NID_classSignToolKC1 = @as(c_int, 1228);
pub const OBJ_classSignToolKC1 = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    _ = @as(c_long, 113);
    break :blk @as(c_long, 1);
};
pub const SN_classSignToolKC2 = "classSignToolKC2";
pub const LN_classSignToolKC2 = "Class of Signing Tool KC2";
pub const NID_classSignToolKC2 = @as(c_int, 1229);
pub const OBJ_classSignToolKC2 = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    _ = @as(c_long, 113);
    break :blk @as(c_long, 2);
};
pub const SN_classSignToolKC3 = "classSignToolKC3";
pub const LN_classSignToolKC3 = "Class of Signing Tool KC3";
pub const NID_classSignToolKC3 = @as(c_int, 1230);
pub const OBJ_classSignToolKC3 = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    _ = @as(c_long, 113);
    break :blk @as(c_long, 3);
};
pub const SN_classSignToolKB1 = "classSignToolKB1";
pub const LN_classSignToolKB1 = "Class of Signing Tool KB1";
pub const NID_classSignToolKB1 = @as(c_int, 1231);
pub const OBJ_classSignToolKB1 = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    _ = @as(c_long, 113);
    break :blk @as(c_long, 4);
};
pub const SN_classSignToolKB2 = "classSignToolKB2";
pub const LN_classSignToolKB2 = "Class of Signing Tool KB2";
pub const NID_classSignToolKB2 = @as(c_int, 1232);
pub const OBJ_classSignToolKB2 = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    _ = @as(c_long, 113);
    break :blk @as(c_long, 5);
};
pub const SN_classSignToolKA1 = "classSignToolKA1";
pub const LN_classSignToolKA1 = "Class of Signing Tool KA1";
pub const NID_classSignToolKA1 = @as(c_int, 1233);
pub const OBJ_classSignToolKA1 = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 643);
    _ = @as(c_long, 100);
    _ = @as(c_long, 113);
    break :blk @as(c_long, 6);
};
pub const SN_kuznyechik_ecb = "kuznyechik-ecb";
pub const NID_kuznyechik_ecb = @as(c_int, 1012);
pub const SN_kuznyechik_ctr = "kuznyechik-ctr";
pub const NID_kuznyechik_ctr = @as(c_int, 1013);
pub const SN_kuznyechik_ofb = "kuznyechik-ofb";
pub const NID_kuznyechik_ofb = @as(c_int, 1014);
pub const SN_kuznyechik_cbc = "kuznyechik-cbc";
pub const NID_kuznyechik_cbc = @as(c_int, 1015);
pub const SN_kuznyechik_cfb = "kuznyechik-cfb";
pub const NID_kuznyechik_cfb = @as(c_int, 1016);
pub const SN_kuznyechik_mac = "kuznyechik-mac";
pub const NID_kuznyechik_mac = @as(c_int, 1017);
pub const SN_magma_ecb = "magma-ecb";
pub const NID_magma_ecb = @as(c_int, 1187);
pub const SN_magma_ctr = "magma-ctr";
pub const NID_magma_ctr = @as(c_int, 1188);
pub const SN_magma_ofb = "magma-ofb";
pub const NID_magma_ofb = @as(c_int, 1189);
pub const SN_magma_cbc = "magma-cbc";
pub const NID_magma_cbc = @as(c_int, 1190);
pub const SN_magma_cfb = "magma-cfb";
pub const NID_magma_cfb = @as(c_int, 1191);
pub const SN_magma_mac = "magma-mac";
pub const NID_magma_mac = @as(c_int, 1192);
pub const SN_camellia_128_cbc = "CAMELLIA-128-CBC";
pub const LN_camellia_128_cbc = "camellia-128-cbc";
pub const NID_camellia_128_cbc = @as(c_int, 751);
pub const OBJ_camellia_128_cbc = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    _ = @as(c_long, 392);
    _ = @as(c_long, 200011);
    _ = @as(c_long, 61);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_camellia_192_cbc = "CAMELLIA-192-CBC";
pub const LN_camellia_192_cbc = "camellia-192-cbc";
pub const NID_camellia_192_cbc = @as(c_int, 752);
pub const OBJ_camellia_192_cbc = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    _ = @as(c_long, 392);
    _ = @as(c_long, 200011);
    _ = @as(c_long, 61);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 3);
};
pub const SN_camellia_256_cbc = "CAMELLIA-256-CBC";
pub const LN_camellia_256_cbc = "camellia-256-cbc";
pub const NID_camellia_256_cbc = @as(c_int, 753);
pub const OBJ_camellia_256_cbc = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    _ = @as(c_long, 392);
    _ = @as(c_long, 200011);
    _ = @as(c_long, 61);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 4);
};
pub const SN_id_camellia128_wrap = "id-camellia128-wrap";
pub const NID_id_camellia128_wrap = @as(c_int, 907);
pub const OBJ_id_camellia128_wrap = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    _ = @as(c_long, 392);
    _ = @as(c_long, 200011);
    _ = @as(c_long, 61);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 2);
};
pub const SN_id_camellia192_wrap = "id-camellia192-wrap";
pub const NID_id_camellia192_wrap = @as(c_int, 908);
pub const OBJ_id_camellia192_wrap = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    _ = @as(c_long, 392);
    _ = @as(c_long, 200011);
    _ = @as(c_long, 61);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 3);
};
pub const SN_id_camellia256_wrap = "id-camellia256-wrap";
pub const NID_id_camellia256_wrap = @as(c_int, 909);
pub const OBJ_id_camellia256_wrap = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    _ = @as(c_long, 392);
    _ = @as(c_long, 200011);
    _ = @as(c_long, 61);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    break :blk @as(c_long, 4);
};
pub const OBJ_ntt_ds = blk: {
    _ = @as(c_long, 0);
    _ = @as(c_long, 3);
    _ = @as(c_long, 4401);
    break :blk @as(c_long, 5);
};
pub const OBJ_camellia = blk: {
    _ = &OBJ_ntt_ds;
    _ = @as(c_long, 3);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 9);
};
pub const SN_camellia_128_ecb = "CAMELLIA-128-ECB";
pub const LN_camellia_128_ecb = "camellia-128-ecb";
pub const NID_camellia_128_ecb = @as(c_int, 754);
pub const OBJ_camellia_128_ecb = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 1);
};
pub const SN_camellia_128_ofb128 = "CAMELLIA-128-OFB";
pub const LN_camellia_128_ofb128 = "camellia-128-ofb";
pub const NID_camellia_128_ofb128 = @as(c_int, 766);
pub const OBJ_camellia_128_ofb128 = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 3);
};
pub const SN_camellia_128_cfb128 = "CAMELLIA-128-CFB";
pub const LN_camellia_128_cfb128 = "camellia-128-cfb";
pub const NID_camellia_128_cfb128 = @as(c_int, 757);
pub const OBJ_camellia_128_cfb128 = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 4);
};
pub const SN_camellia_128_gcm = "CAMELLIA-128-GCM";
pub const LN_camellia_128_gcm = "camellia-128-gcm";
pub const NID_camellia_128_gcm = @as(c_int, 961);
pub const OBJ_camellia_128_gcm = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 6);
};
pub const SN_camellia_128_ccm = "CAMELLIA-128-CCM";
pub const LN_camellia_128_ccm = "camellia-128-ccm";
pub const NID_camellia_128_ccm = @as(c_int, 962);
pub const OBJ_camellia_128_ccm = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 7);
};
pub const SN_camellia_128_ctr = "CAMELLIA-128-CTR";
pub const LN_camellia_128_ctr = "camellia-128-ctr";
pub const NID_camellia_128_ctr = @as(c_int, 963);
pub const OBJ_camellia_128_ctr = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 9);
};
pub const SN_camellia_128_cmac = "CAMELLIA-128-CMAC";
pub const LN_camellia_128_cmac = "camellia-128-cmac";
pub const NID_camellia_128_cmac = @as(c_int, 964);
pub const OBJ_camellia_128_cmac = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 10);
};
pub const SN_camellia_192_ecb = "CAMELLIA-192-ECB";
pub const LN_camellia_192_ecb = "camellia-192-ecb";
pub const NID_camellia_192_ecb = @as(c_int, 755);
pub const OBJ_camellia_192_ecb = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 21);
};
pub const SN_camellia_192_ofb128 = "CAMELLIA-192-OFB";
pub const LN_camellia_192_ofb128 = "camellia-192-ofb";
pub const NID_camellia_192_ofb128 = @as(c_int, 767);
pub const OBJ_camellia_192_ofb128 = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 23);
};
pub const SN_camellia_192_cfb128 = "CAMELLIA-192-CFB";
pub const LN_camellia_192_cfb128 = "camellia-192-cfb";
pub const NID_camellia_192_cfb128 = @as(c_int, 758);
pub const OBJ_camellia_192_cfb128 = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 24);
};
pub const SN_camellia_192_gcm = "CAMELLIA-192-GCM";
pub const LN_camellia_192_gcm = "camellia-192-gcm";
pub const NID_camellia_192_gcm = @as(c_int, 965);
pub const OBJ_camellia_192_gcm = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 26);
};
pub const SN_camellia_192_ccm = "CAMELLIA-192-CCM";
pub const LN_camellia_192_ccm = "camellia-192-ccm";
pub const NID_camellia_192_ccm = @as(c_int, 966);
pub const OBJ_camellia_192_ccm = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 27);
};
pub const SN_camellia_192_ctr = "CAMELLIA-192-CTR";
pub const LN_camellia_192_ctr = "camellia-192-ctr";
pub const NID_camellia_192_ctr = @as(c_int, 967);
pub const OBJ_camellia_192_ctr = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 29);
};
pub const SN_camellia_192_cmac = "CAMELLIA-192-CMAC";
pub const LN_camellia_192_cmac = "camellia-192-cmac";
pub const NID_camellia_192_cmac = @as(c_int, 968);
pub const OBJ_camellia_192_cmac = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 30);
};
pub const SN_camellia_256_ecb = "CAMELLIA-256-ECB";
pub const LN_camellia_256_ecb = "camellia-256-ecb";
pub const NID_camellia_256_ecb = @as(c_int, 756);
pub const OBJ_camellia_256_ecb = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 41);
};
pub const SN_camellia_256_ofb128 = "CAMELLIA-256-OFB";
pub const LN_camellia_256_ofb128 = "camellia-256-ofb";
pub const NID_camellia_256_ofb128 = @as(c_int, 768);
pub const OBJ_camellia_256_ofb128 = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 43);
};
pub const SN_camellia_256_cfb128 = "CAMELLIA-256-CFB";
pub const LN_camellia_256_cfb128 = "camellia-256-cfb";
pub const NID_camellia_256_cfb128 = @as(c_int, 759);
pub const OBJ_camellia_256_cfb128 = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 44);
};
pub const SN_camellia_256_gcm = "CAMELLIA-256-GCM";
pub const LN_camellia_256_gcm = "camellia-256-gcm";
pub const NID_camellia_256_gcm = @as(c_int, 969);
pub const OBJ_camellia_256_gcm = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 46);
};
pub const SN_camellia_256_ccm = "CAMELLIA-256-CCM";
pub const LN_camellia_256_ccm = "camellia-256-ccm";
pub const NID_camellia_256_ccm = @as(c_int, 970);
pub const OBJ_camellia_256_ccm = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 47);
};
pub const SN_camellia_256_ctr = "CAMELLIA-256-CTR";
pub const LN_camellia_256_ctr = "camellia-256-ctr";
pub const NID_camellia_256_ctr = @as(c_int, 971);
pub const OBJ_camellia_256_ctr = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 49);
};
pub const SN_camellia_256_cmac = "CAMELLIA-256-CMAC";
pub const LN_camellia_256_cmac = "camellia-256-cmac";
pub const NID_camellia_256_cmac = @as(c_int, 972);
pub const OBJ_camellia_256_cmac = blk: {
    _ = &OBJ_camellia;
    break :blk @as(c_long, 50);
};
pub const SN_camellia_128_cfb1 = "CAMELLIA-128-CFB1";
pub const LN_camellia_128_cfb1 = "camellia-128-cfb1";
pub const NID_camellia_128_cfb1 = @as(c_int, 760);
pub const SN_camellia_192_cfb1 = "CAMELLIA-192-CFB1";
pub const LN_camellia_192_cfb1 = "camellia-192-cfb1";
pub const NID_camellia_192_cfb1 = @as(c_int, 761);
pub const SN_camellia_256_cfb1 = "CAMELLIA-256-CFB1";
pub const LN_camellia_256_cfb1 = "camellia-256-cfb1";
pub const NID_camellia_256_cfb1 = @as(c_int, 762);
pub const SN_camellia_128_cfb8 = "CAMELLIA-128-CFB8";
pub const LN_camellia_128_cfb8 = "camellia-128-cfb8";
pub const NID_camellia_128_cfb8 = @as(c_int, 763);
pub const SN_camellia_192_cfb8 = "CAMELLIA-192-CFB8";
pub const LN_camellia_192_cfb8 = "camellia-192-cfb8";
pub const NID_camellia_192_cfb8 = @as(c_int, 764);
pub const SN_camellia_256_cfb8 = "CAMELLIA-256-CFB8";
pub const LN_camellia_256_cfb8 = "camellia-256-cfb8";
pub const NID_camellia_256_cfb8 = @as(c_int, 765);
pub const OBJ_aria = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    _ = @as(c_long, 410);
    _ = @as(c_long, 200046);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_aria_128_ecb = "ARIA-128-ECB";
pub const LN_aria_128_ecb = "aria-128-ecb";
pub const NID_aria_128_ecb = @as(c_int, 1065);
pub const OBJ_aria_128_ecb = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 1);
};
pub const SN_aria_128_cbc = "ARIA-128-CBC";
pub const LN_aria_128_cbc = "aria-128-cbc";
pub const NID_aria_128_cbc = @as(c_int, 1066);
pub const OBJ_aria_128_cbc = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 2);
};
pub const SN_aria_128_cfb128 = "ARIA-128-CFB";
pub const LN_aria_128_cfb128 = "aria-128-cfb";
pub const NID_aria_128_cfb128 = @as(c_int, 1067);
pub const OBJ_aria_128_cfb128 = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 3);
};
pub const SN_aria_128_ofb128 = "ARIA-128-OFB";
pub const LN_aria_128_ofb128 = "aria-128-ofb";
pub const NID_aria_128_ofb128 = @as(c_int, 1068);
pub const OBJ_aria_128_ofb128 = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 4);
};
pub const SN_aria_128_ctr = "ARIA-128-CTR";
pub const LN_aria_128_ctr = "aria-128-ctr";
pub const NID_aria_128_ctr = @as(c_int, 1069);
pub const OBJ_aria_128_ctr = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 5);
};
pub const SN_aria_192_ecb = "ARIA-192-ECB";
pub const LN_aria_192_ecb = "aria-192-ecb";
pub const NID_aria_192_ecb = @as(c_int, 1070);
pub const OBJ_aria_192_ecb = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 6);
};
pub const SN_aria_192_cbc = "ARIA-192-CBC";
pub const LN_aria_192_cbc = "aria-192-cbc";
pub const NID_aria_192_cbc = @as(c_int, 1071);
pub const OBJ_aria_192_cbc = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 7);
};
pub const SN_aria_192_cfb128 = "ARIA-192-CFB";
pub const LN_aria_192_cfb128 = "aria-192-cfb";
pub const NID_aria_192_cfb128 = @as(c_int, 1072);
pub const OBJ_aria_192_cfb128 = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 8);
};
pub const SN_aria_192_ofb128 = "ARIA-192-OFB";
pub const LN_aria_192_ofb128 = "aria-192-ofb";
pub const NID_aria_192_ofb128 = @as(c_int, 1073);
pub const OBJ_aria_192_ofb128 = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 9);
};
pub const SN_aria_192_ctr = "ARIA-192-CTR";
pub const LN_aria_192_ctr = "aria-192-ctr";
pub const NID_aria_192_ctr = @as(c_int, 1074);
pub const OBJ_aria_192_ctr = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 10);
};
pub const SN_aria_256_ecb = "ARIA-256-ECB";
pub const LN_aria_256_ecb = "aria-256-ecb";
pub const NID_aria_256_ecb = @as(c_int, 1075);
pub const OBJ_aria_256_ecb = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 11);
};
pub const SN_aria_256_cbc = "ARIA-256-CBC";
pub const LN_aria_256_cbc = "aria-256-cbc";
pub const NID_aria_256_cbc = @as(c_int, 1076);
pub const OBJ_aria_256_cbc = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 12);
};
pub const SN_aria_256_cfb128 = "ARIA-256-CFB";
pub const LN_aria_256_cfb128 = "aria-256-cfb";
pub const NID_aria_256_cfb128 = @as(c_int, 1077);
pub const OBJ_aria_256_cfb128 = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 13);
};
pub const SN_aria_256_ofb128 = "ARIA-256-OFB";
pub const LN_aria_256_ofb128 = "aria-256-ofb";
pub const NID_aria_256_ofb128 = @as(c_int, 1078);
pub const OBJ_aria_256_ofb128 = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 14);
};
pub const SN_aria_256_ctr = "ARIA-256-CTR";
pub const LN_aria_256_ctr = "aria-256-ctr";
pub const NID_aria_256_ctr = @as(c_int, 1079);
pub const OBJ_aria_256_ctr = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 15);
};
pub const SN_aria_128_cfb1 = "ARIA-128-CFB1";
pub const LN_aria_128_cfb1 = "aria-128-cfb1";
pub const NID_aria_128_cfb1 = @as(c_int, 1080);
pub const SN_aria_192_cfb1 = "ARIA-192-CFB1";
pub const LN_aria_192_cfb1 = "aria-192-cfb1";
pub const NID_aria_192_cfb1 = @as(c_int, 1081);
pub const SN_aria_256_cfb1 = "ARIA-256-CFB1";
pub const LN_aria_256_cfb1 = "aria-256-cfb1";
pub const NID_aria_256_cfb1 = @as(c_int, 1082);
pub const SN_aria_128_cfb8 = "ARIA-128-CFB8";
pub const LN_aria_128_cfb8 = "aria-128-cfb8";
pub const NID_aria_128_cfb8 = @as(c_int, 1083);
pub const SN_aria_192_cfb8 = "ARIA-192-CFB8";
pub const LN_aria_192_cfb8 = "aria-192-cfb8";
pub const NID_aria_192_cfb8 = @as(c_int, 1084);
pub const SN_aria_256_cfb8 = "ARIA-256-CFB8";
pub const LN_aria_256_cfb8 = "aria-256-cfb8";
pub const NID_aria_256_cfb8 = @as(c_int, 1085);
pub const SN_aria_128_ccm = "ARIA-128-CCM";
pub const LN_aria_128_ccm = "aria-128-ccm";
pub const NID_aria_128_ccm = @as(c_int, 1120);
pub const OBJ_aria_128_ccm = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 37);
};
pub const SN_aria_192_ccm = "ARIA-192-CCM";
pub const LN_aria_192_ccm = "aria-192-ccm";
pub const NID_aria_192_ccm = @as(c_int, 1121);
pub const OBJ_aria_192_ccm = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 38);
};
pub const SN_aria_256_ccm = "ARIA-256-CCM";
pub const LN_aria_256_ccm = "aria-256-ccm";
pub const NID_aria_256_ccm = @as(c_int, 1122);
pub const OBJ_aria_256_ccm = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 39);
};
pub const SN_aria_128_gcm = "ARIA-128-GCM";
pub const LN_aria_128_gcm = "aria-128-gcm";
pub const NID_aria_128_gcm = @as(c_int, 1123);
pub const OBJ_aria_128_gcm = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 34);
};
pub const SN_aria_192_gcm = "ARIA-192-GCM";
pub const LN_aria_192_gcm = "aria-192-gcm";
pub const NID_aria_192_gcm = @as(c_int, 1124);
pub const OBJ_aria_192_gcm = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 35);
};
pub const SN_aria_256_gcm = "ARIA-256-GCM";
pub const LN_aria_256_gcm = "aria-256-gcm";
pub const NID_aria_256_gcm = @as(c_int, 1125);
pub const OBJ_aria_256_gcm = blk: {
    _ = &OBJ_aria;
    break :blk @as(c_long, 36);
};
pub const SN_kisa = "KISA";
pub const LN_kisa = "kisa";
pub const NID_kisa = @as(c_int, 773);
pub const OBJ_kisa = blk: {
    _ = &OBJ_member_body;
    _ = @as(c_long, 410);
    break :blk @as(c_long, 200004);
};
pub const SN_seed_ecb = "SEED-ECB";
pub const LN_seed_ecb = "seed-ecb";
pub const NID_seed_ecb = @as(c_int, 776);
pub const OBJ_seed_ecb = blk: {
    _ = &OBJ_kisa;
    _ = @as(c_long, 1);
    break :blk @as(c_long, 3);
};
pub const SN_seed_cbc = "SEED-CBC";
pub const LN_seed_cbc = "seed-cbc";
pub const NID_seed_cbc = @as(c_int, 777);
pub const OBJ_seed_cbc = blk: {
    _ = &OBJ_kisa;
    _ = @as(c_long, 1);
    break :blk @as(c_long, 4);
};
pub const SN_seed_cfb128 = "SEED-CFB";
pub const LN_seed_cfb128 = "seed-cfb";
pub const NID_seed_cfb128 = @as(c_int, 779);
pub const OBJ_seed_cfb128 = blk: {
    _ = &OBJ_kisa;
    _ = @as(c_long, 1);
    break :blk @as(c_long, 5);
};
pub const SN_seed_ofb128 = "SEED-OFB";
pub const LN_seed_ofb128 = "seed-ofb";
pub const NID_seed_ofb128 = @as(c_int, 778);
pub const OBJ_seed_ofb128 = blk: {
    _ = &OBJ_kisa;
    _ = @as(c_long, 1);
    break :blk @as(c_long, 6);
};
pub const SN_sm4_ecb = "SM4-ECB";
pub const LN_sm4_ecb = "sm4-ecb";
pub const NID_sm4_ecb = @as(c_int, 1133);
pub const OBJ_sm4_ecb = blk: {
    _ = &OBJ_sm_scheme;
    _ = @as(c_long, 104);
    break :blk @as(c_long, 1);
};
pub const SN_sm4_cbc = "SM4-CBC";
pub const LN_sm4_cbc = "sm4-cbc";
pub const NID_sm4_cbc = @as(c_int, 1134);
pub const OBJ_sm4_cbc = blk: {
    _ = &OBJ_sm_scheme;
    _ = @as(c_long, 104);
    break :blk @as(c_long, 2);
};
pub const SN_sm4_ofb128 = "SM4-OFB";
pub const LN_sm4_ofb128 = "sm4-ofb";
pub const NID_sm4_ofb128 = @as(c_int, 1135);
pub const OBJ_sm4_ofb128 = blk: {
    _ = &OBJ_sm_scheme;
    _ = @as(c_long, 104);
    break :blk @as(c_long, 3);
};
pub const SN_sm4_cfb128 = "SM4-CFB";
pub const LN_sm4_cfb128 = "sm4-cfb";
pub const NID_sm4_cfb128 = @as(c_int, 1137);
pub const OBJ_sm4_cfb128 = blk: {
    _ = &OBJ_sm_scheme;
    _ = @as(c_long, 104);
    break :blk @as(c_long, 4);
};
pub const SN_sm4_cfb1 = "SM4-CFB1";
pub const LN_sm4_cfb1 = "sm4-cfb1";
pub const NID_sm4_cfb1 = @as(c_int, 1136);
pub const OBJ_sm4_cfb1 = blk: {
    _ = &OBJ_sm_scheme;
    _ = @as(c_long, 104);
    break :blk @as(c_long, 5);
};
pub const SN_sm4_cfb8 = "SM4-CFB8";
pub const LN_sm4_cfb8 = "sm4-cfb8";
pub const NID_sm4_cfb8 = @as(c_int, 1138);
pub const OBJ_sm4_cfb8 = blk: {
    _ = &OBJ_sm_scheme;
    _ = @as(c_long, 104);
    break :blk @as(c_long, 6);
};
pub const SN_sm4_ctr = "SM4-CTR";
pub const LN_sm4_ctr = "sm4-ctr";
pub const NID_sm4_ctr = @as(c_int, 1139);
pub const OBJ_sm4_ctr = blk: {
    _ = &OBJ_sm_scheme;
    _ = @as(c_long, 104);
    break :blk @as(c_long, 7);
};
pub const SN_hmac = "HMAC";
pub const LN_hmac = "hmac";
pub const NID_hmac = @as(c_int, 855);
pub const SN_cmac = "CMAC";
pub const LN_cmac = "cmac";
pub const NID_cmac = @as(c_int, 894);
pub const SN_rc4_hmac_md5 = "RC4-HMAC-MD5";
pub const LN_rc4_hmac_md5 = "rc4-hmac-md5";
pub const NID_rc4_hmac_md5 = @as(c_int, 915);
pub const SN_aes_128_cbc_hmac_sha1 = "AES-128-CBC-HMAC-SHA1";
pub const LN_aes_128_cbc_hmac_sha1 = "aes-128-cbc-hmac-sha1";
pub const NID_aes_128_cbc_hmac_sha1 = @as(c_int, 916);
pub const SN_aes_192_cbc_hmac_sha1 = "AES-192-CBC-HMAC-SHA1";
pub const LN_aes_192_cbc_hmac_sha1 = "aes-192-cbc-hmac-sha1";
pub const NID_aes_192_cbc_hmac_sha1 = @as(c_int, 917);
pub const SN_aes_256_cbc_hmac_sha1 = "AES-256-CBC-HMAC-SHA1";
pub const LN_aes_256_cbc_hmac_sha1 = "aes-256-cbc-hmac-sha1";
pub const NID_aes_256_cbc_hmac_sha1 = @as(c_int, 918);
pub const SN_aes_128_cbc_hmac_sha256 = "AES-128-CBC-HMAC-SHA256";
pub const LN_aes_128_cbc_hmac_sha256 = "aes-128-cbc-hmac-sha256";
pub const NID_aes_128_cbc_hmac_sha256 = @as(c_int, 948);
pub const SN_aes_192_cbc_hmac_sha256 = "AES-192-CBC-HMAC-SHA256";
pub const LN_aes_192_cbc_hmac_sha256 = "aes-192-cbc-hmac-sha256";
pub const NID_aes_192_cbc_hmac_sha256 = @as(c_int, 949);
pub const SN_aes_256_cbc_hmac_sha256 = "AES-256-CBC-HMAC-SHA256";
pub const LN_aes_256_cbc_hmac_sha256 = "aes-256-cbc-hmac-sha256";
pub const NID_aes_256_cbc_hmac_sha256 = @as(c_int, 950);
pub const SN_chacha20_poly1305 = "ChaCha20-Poly1305";
pub const LN_chacha20_poly1305 = "chacha20-poly1305";
pub const NID_chacha20_poly1305 = @as(c_int, 1018);
pub const SN_chacha20 = "ChaCha20";
pub const LN_chacha20 = "chacha20";
pub const NID_chacha20 = @as(c_int, 1019);
pub const SN_dhpublicnumber = "dhpublicnumber";
pub const LN_dhpublicnumber = "X9.42 DH";
pub const NID_dhpublicnumber = @as(c_int, 920);
pub const OBJ_dhpublicnumber = blk: {
    _ = &OBJ_ISO_US;
    _ = @as(c_long, 10046);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 1);
};
pub const SN_brainpoolP160r1 = "brainpoolP160r1";
pub const NID_brainpoolP160r1 = @as(c_int, 921);
pub const OBJ_brainpoolP160r1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_brainpoolP160t1 = "brainpoolP160t1";
pub const NID_brainpoolP160t1 = @as(c_int, 922);
pub const OBJ_brainpoolP160t1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_brainpoolP192r1 = "brainpoolP192r1";
pub const NID_brainpoolP192r1 = @as(c_int, 923);
pub const OBJ_brainpoolP192r1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 3);
};
pub const SN_brainpoolP192t1 = "brainpoolP192t1";
pub const NID_brainpoolP192t1 = @as(c_int, 924);
pub const OBJ_brainpoolP192t1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 4);
};
pub const SN_brainpoolP224r1 = "brainpoolP224r1";
pub const NID_brainpoolP224r1 = @as(c_int, 925);
pub const OBJ_brainpoolP224r1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 5);
};
pub const SN_brainpoolP224t1 = "brainpoolP224t1";
pub const NID_brainpoolP224t1 = @as(c_int, 926);
pub const OBJ_brainpoolP224t1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 6);
};
pub const SN_brainpoolP256r1 = "brainpoolP256r1";
pub const NID_brainpoolP256r1 = @as(c_int, 927);
pub const OBJ_brainpoolP256r1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 7);
};
pub const SN_brainpoolP256t1 = "brainpoolP256t1";
pub const NID_brainpoolP256t1 = @as(c_int, 928);
pub const OBJ_brainpoolP256t1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 8);
};
pub const SN_brainpoolP320r1 = "brainpoolP320r1";
pub const NID_brainpoolP320r1 = @as(c_int, 929);
pub const OBJ_brainpoolP320r1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 9);
};
pub const SN_brainpoolP320t1 = "brainpoolP320t1";
pub const NID_brainpoolP320t1 = @as(c_int, 930);
pub const OBJ_brainpoolP320t1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 10);
};
pub const SN_brainpoolP384r1 = "brainpoolP384r1";
pub const NID_brainpoolP384r1 = @as(c_int, 931);
pub const OBJ_brainpoolP384r1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 11);
};
pub const SN_brainpoolP384t1 = "brainpoolP384t1";
pub const NID_brainpoolP384t1 = @as(c_int, 932);
pub const OBJ_brainpoolP384t1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 12);
};
pub const SN_brainpoolP512r1 = "brainpoolP512r1";
pub const NID_brainpoolP512r1 = @as(c_int, 933);
pub const OBJ_brainpoolP512r1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 13);
};
pub const SN_brainpoolP512t1 = "brainpoolP512t1";
pub const NID_brainpoolP512t1 = @as(c_int, 934);
pub const OBJ_brainpoolP512t1 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 36);
    _ = @as(c_long, 3);
    _ = @as(c_long, 3);
    _ = @as(c_long, 2);
    _ = @as(c_long, 8);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 14);
};
pub const OBJ_x9_63_scheme = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 133);
    _ = @as(c_long, 16);
    _ = @as(c_long, 840);
    _ = @as(c_long, 63);
    break :blk @as(c_long, 0);
};
pub const OBJ_secg_scheme = blk: {
    _ = &OBJ_certicom_arc;
    break :blk @as(c_long, 1);
};
pub const SN_dhSinglePass_stdDH_sha1kdf_scheme = "dhSinglePass-stdDH-sha1kdf-scheme";
pub const NID_dhSinglePass_stdDH_sha1kdf_scheme = @as(c_int, 936);
pub const OBJ_dhSinglePass_stdDH_sha1kdf_scheme = blk: {
    _ = &OBJ_x9_63_scheme;
    break :blk @as(c_long, 2);
};
pub const SN_dhSinglePass_stdDH_sha224kdf_scheme = "dhSinglePass-stdDH-sha224kdf-scheme";
pub const NID_dhSinglePass_stdDH_sha224kdf_scheme = @as(c_int, 937);
pub const OBJ_dhSinglePass_stdDH_sha224kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 11);
    break :blk @as(c_long, 0);
};
pub const SN_dhSinglePass_stdDH_sha256kdf_scheme = "dhSinglePass-stdDH-sha256kdf-scheme";
pub const NID_dhSinglePass_stdDH_sha256kdf_scheme = @as(c_int, 938);
pub const OBJ_dhSinglePass_stdDH_sha256kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 11);
    break :blk @as(c_long, 1);
};
pub const SN_dhSinglePass_stdDH_sha384kdf_scheme = "dhSinglePass-stdDH-sha384kdf-scheme";
pub const NID_dhSinglePass_stdDH_sha384kdf_scheme = @as(c_int, 939);
pub const OBJ_dhSinglePass_stdDH_sha384kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 11);
    break :blk @as(c_long, 2);
};
pub const SN_dhSinglePass_stdDH_sha512kdf_scheme = "dhSinglePass-stdDH-sha512kdf-scheme";
pub const NID_dhSinglePass_stdDH_sha512kdf_scheme = @as(c_int, 940);
pub const OBJ_dhSinglePass_stdDH_sha512kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 11);
    break :blk @as(c_long, 3);
};
pub const SN_dhSinglePass_cofactorDH_sha1kdf_scheme = "dhSinglePass-cofactorDH-sha1kdf-scheme";
pub const NID_dhSinglePass_cofactorDH_sha1kdf_scheme = @as(c_int, 941);
pub const OBJ_dhSinglePass_cofactorDH_sha1kdf_scheme = blk: {
    _ = &OBJ_x9_63_scheme;
    break :blk @as(c_long, 3);
};
pub const SN_dhSinglePass_cofactorDH_sha224kdf_scheme = "dhSinglePass-cofactorDH-sha224kdf-scheme";
pub const NID_dhSinglePass_cofactorDH_sha224kdf_scheme = @as(c_int, 942);
pub const OBJ_dhSinglePass_cofactorDH_sha224kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 14);
    break :blk @as(c_long, 0);
};
pub const SN_dhSinglePass_cofactorDH_sha256kdf_scheme = "dhSinglePass-cofactorDH-sha256kdf-scheme";
pub const NID_dhSinglePass_cofactorDH_sha256kdf_scheme = @as(c_int, 943);
pub const OBJ_dhSinglePass_cofactorDH_sha256kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 14);
    break :blk @as(c_long, 1);
};
pub const SN_dhSinglePass_cofactorDH_sha384kdf_scheme = "dhSinglePass-cofactorDH-sha384kdf-scheme";
pub const NID_dhSinglePass_cofactorDH_sha384kdf_scheme = @as(c_int, 944);
pub const OBJ_dhSinglePass_cofactorDH_sha384kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 14);
    break :blk @as(c_long, 2);
};
pub const SN_dhSinglePass_cofactorDH_sha512kdf_scheme = "dhSinglePass-cofactorDH-sha512kdf-scheme";
pub const NID_dhSinglePass_cofactorDH_sha512kdf_scheme = @as(c_int, 945);
pub const OBJ_dhSinglePass_cofactorDH_sha512kdf_scheme = blk: {
    _ = &OBJ_secg_scheme;
    _ = @as(c_long, 14);
    break :blk @as(c_long, 3);
};
pub const SN_dh_std_kdf = "dh-std-kdf";
pub const NID_dh_std_kdf = @as(c_int, 946);
pub const SN_dh_cofactor_kdf = "dh-cofactor-kdf";
pub const NID_dh_cofactor_kdf = @as(c_int, 947);
pub const SN_ct_precert_scts = "ct_precert_scts";
pub const LN_ct_precert_scts = "CT Precertificate SCTs";
pub const NID_ct_precert_scts = @as(c_int, 951);
pub const OBJ_ct_precert_scts = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 11129);
    _ = @as(c_long, 2);
    _ = @as(c_long, 4);
    break :blk @as(c_long, 2);
};
pub const SN_ct_precert_poison = "ct_precert_poison";
pub const LN_ct_precert_poison = "CT Precertificate Poison";
pub const NID_ct_precert_poison = @as(c_int, 952);
pub const OBJ_ct_precert_poison = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 11129);
    _ = @as(c_long, 2);
    _ = @as(c_long, 4);
    break :blk @as(c_long, 3);
};
pub const SN_ct_precert_signer = "ct_precert_signer";
pub const LN_ct_precert_signer = "CT Precertificate Signer";
pub const NID_ct_precert_signer = @as(c_int, 953);
pub const OBJ_ct_precert_signer = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 11129);
    _ = @as(c_long, 2);
    _ = @as(c_long, 4);
    break :blk @as(c_long, 4);
};
pub const SN_ct_cert_scts = "ct_cert_scts";
pub const LN_ct_cert_scts = "CT Certificate SCTs";
pub const NID_ct_cert_scts = @as(c_int, 954);
pub const OBJ_ct_cert_scts = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 11129);
    _ = @as(c_long, 2);
    _ = @as(c_long, 4);
    break :blk @as(c_long, 5);
};
pub const SN_jurisdictionLocalityName = "jurisdictionL";
pub const LN_jurisdictionLocalityName = "jurisdictionLocalityName";
pub const NID_jurisdictionLocalityName = @as(c_int, 955);
pub const OBJ_jurisdictionLocalityName = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 60);
    _ = @as(c_long, 2);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_jurisdictionStateOrProvinceName = "jurisdictionST";
pub const LN_jurisdictionStateOrProvinceName = "jurisdictionStateOrProvinceName";
pub const NID_jurisdictionStateOrProvinceName = @as(c_int, 956);
pub const OBJ_jurisdictionStateOrProvinceName = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 60);
    _ = @as(c_long, 2);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_jurisdictionCountryName = "jurisdictionC";
pub const LN_jurisdictionCountryName = "jurisdictionCountryName";
pub const NID_jurisdictionCountryName = @as(c_int, 957);
pub const OBJ_jurisdictionCountryName = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 311);
    _ = @as(c_long, 60);
    _ = @as(c_long, 2);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 3);
};
pub const SN_id_scrypt = "id-scrypt";
pub const LN_id_scrypt = "scrypt";
pub const NID_id_scrypt = @as(c_int, 973);
pub const OBJ_id_scrypt = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 4);
    _ = @as(c_long, 1);
    _ = @as(c_long, 11591);
    _ = @as(c_long, 4);
    break :blk @as(c_long, 11);
};
pub const SN_tls1_prf = "TLS1-PRF";
pub const LN_tls1_prf = "tls1-prf";
pub const NID_tls1_prf = @as(c_int, 1021);
pub const SN_hkdf = "HKDF";
pub const LN_hkdf = "hkdf";
pub const NID_hkdf = @as(c_int, 1036);
pub const SN_sshkdf = "SSHKDF";
pub const LN_sshkdf = "sshkdf";
pub const NID_sshkdf = @as(c_int, 1203);
pub const SN_sskdf = "SSKDF";
pub const LN_sskdf = "sskdf";
pub const NID_sskdf = @as(c_int, 1205);
pub const SN_x942kdf = "X942KDF";
pub const LN_x942kdf = "x942kdf";
pub const NID_x942kdf = @as(c_int, 1207);
pub const SN_x963kdf = "X963KDF";
pub const LN_x963kdf = "x963kdf";
pub const NID_x963kdf = @as(c_int, 1206);
pub const SN_id_pkinit = "id-pkinit";
pub const NID_id_pkinit = @as(c_int, 1031);
pub const OBJ_id_pkinit = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 6);
    _ = @as(c_long, 1);
    _ = @as(c_long, 5);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 3);
};
pub const SN_pkInitClientAuth = "pkInitClientAuth";
pub const LN_pkInitClientAuth = "PKINIT Client Auth";
pub const NID_pkInitClientAuth = @as(c_int, 1032);
pub const OBJ_pkInitClientAuth = blk: {
    _ = &OBJ_id_pkinit;
    break :blk @as(c_long, 4);
};
pub const SN_pkInitKDC = "pkInitKDC";
pub const LN_pkInitKDC = "Signing KDC Response";
pub const NID_pkInitKDC = @as(c_int, 1033);
pub const OBJ_pkInitKDC = blk: {
    _ = &OBJ_id_pkinit;
    break :blk @as(c_long, 5);
};
pub const SN_X25519 = "X25519";
pub const NID_X25519 = @as(c_int, 1034);
pub const OBJ_X25519 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 101);
    break :blk @as(c_long, 110);
};
pub const SN_X448 = "X448";
pub const NID_X448 = @as(c_int, 1035);
pub const OBJ_X448 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 101);
    break :blk @as(c_long, 111);
};
pub const SN_ED25519 = "ED25519";
pub const NID_ED25519 = @as(c_int, 1087);
pub const OBJ_ED25519 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 101);
    break :blk @as(c_long, 112);
};
pub const SN_ED448 = "ED448";
pub const NID_ED448 = @as(c_int, 1088);
pub const OBJ_ED448 = blk: {
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 101);
    break :blk @as(c_long, 113);
};
pub const SN_kx_rsa = "KxRSA";
pub const LN_kx_rsa = "kx-rsa";
pub const NID_kx_rsa = @as(c_int, 1037);
pub const SN_kx_ecdhe = "KxECDHE";
pub const LN_kx_ecdhe = "kx-ecdhe";
pub const NID_kx_ecdhe = @as(c_int, 1038);
pub const SN_kx_dhe = "KxDHE";
pub const LN_kx_dhe = "kx-dhe";
pub const NID_kx_dhe = @as(c_int, 1039);
pub const SN_kx_ecdhe_psk = "KxECDHE-PSK";
pub const LN_kx_ecdhe_psk = "kx-ecdhe-psk";
pub const NID_kx_ecdhe_psk = @as(c_int, 1040);
pub const SN_kx_dhe_psk = "KxDHE-PSK";
pub const LN_kx_dhe_psk = "kx-dhe-psk";
pub const NID_kx_dhe_psk = @as(c_int, 1041);
pub const SN_kx_rsa_psk = "KxRSA_PSK";
pub const LN_kx_rsa_psk = "kx-rsa-psk";
pub const NID_kx_rsa_psk = @as(c_int, 1042);
pub const SN_kx_psk = "KxPSK";
pub const LN_kx_psk = "kx-psk";
pub const NID_kx_psk = @as(c_int, 1043);
pub const SN_kx_srp = "KxSRP";
pub const LN_kx_srp = "kx-srp";
pub const NID_kx_srp = @as(c_int, 1044);
pub const SN_kx_gost = "KxGOST";
pub const LN_kx_gost = "kx-gost";
pub const NID_kx_gost = @as(c_int, 1045);
pub const SN_kx_gost18 = "KxGOST18";
pub const LN_kx_gost18 = "kx-gost18";
pub const NID_kx_gost18 = @as(c_int, 1218);
pub const SN_kx_any = "KxANY";
pub const LN_kx_any = "kx-any";
pub const NID_kx_any = @as(c_int, 1063);
pub const SN_auth_rsa = "AuthRSA";
pub const LN_auth_rsa = "auth-rsa";
pub const NID_auth_rsa = @as(c_int, 1046);
pub const SN_auth_ecdsa = "AuthECDSA";
pub const LN_auth_ecdsa = "auth-ecdsa";
pub const NID_auth_ecdsa = @as(c_int, 1047);
pub const SN_auth_psk = "AuthPSK";
pub const LN_auth_psk = "auth-psk";
pub const NID_auth_psk = @as(c_int, 1048);
pub const SN_auth_dss = "AuthDSS";
pub const LN_auth_dss = "auth-dss";
pub const NID_auth_dss = @as(c_int, 1049);
pub const SN_auth_gost01 = "AuthGOST01";
pub const LN_auth_gost01 = "auth-gost01";
pub const NID_auth_gost01 = @as(c_int, 1050);
pub const SN_auth_gost12 = "AuthGOST12";
pub const LN_auth_gost12 = "auth-gost12";
pub const NID_auth_gost12 = @as(c_int, 1051);
pub const SN_auth_srp = "AuthSRP";
pub const LN_auth_srp = "auth-srp";
pub const NID_auth_srp = @as(c_int, 1052);
pub const SN_auth_null = "AuthNULL";
pub const LN_auth_null = "auth-null";
pub const NID_auth_null = @as(c_int, 1053);
pub const SN_auth_any = "AuthANY";
pub const LN_auth_any = "auth-any";
pub const NID_auth_any = @as(c_int, 1064);
pub const SN_poly1305 = "Poly1305";
pub const LN_poly1305 = "poly1305";
pub const NID_poly1305 = @as(c_int, 1061);
pub const SN_siphash = "SipHash";
pub const LN_siphash = "siphash";
pub const NID_siphash = @as(c_int, 1062);
pub const SN_ffdhe2048 = "ffdhe2048";
pub const NID_ffdhe2048 = @as(c_int, 1126);
pub const SN_ffdhe3072 = "ffdhe3072";
pub const NID_ffdhe3072 = @as(c_int, 1127);
pub const SN_ffdhe4096 = "ffdhe4096";
pub const NID_ffdhe4096 = @as(c_int, 1128);
pub const SN_ffdhe6144 = "ffdhe6144";
pub const NID_ffdhe6144 = @as(c_int, 1129);
pub const SN_ffdhe8192 = "ffdhe8192";
pub const NID_ffdhe8192 = @as(c_int, 1130);
pub const SN_modp_1536 = "modp_1536";
pub const NID_modp_1536 = @as(c_int, 1212);
pub const SN_modp_2048 = "modp_2048";
pub const NID_modp_2048 = @as(c_int, 1213);
pub const SN_modp_3072 = "modp_3072";
pub const NID_modp_3072 = @as(c_int, 1214);
pub const SN_modp_4096 = "modp_4096";
pub const NID_modp_4096 = @as(c_int, 1215);
pub const SN_modp_6144 = "modp_6144";
pub const NID_modp_6144 = @as(c_int, 1216);
pub const SN_modp_8192 = "modp_8192";
pub const NID_modp_8192 = @as(c_int, 1217);
pub const SN_ISO_UA = "ISO-UA";
pub const NID_ISO_UA = @as(c_int, 1150);
pub const OBJ_ISO_UA = blk: {
    _ = &OBJ_member_body;
    break :blk @as(c_long, 804);
};
pub const SN_ua_pki = "ua-pki";
pub const NID_ua_pki = @as(c_int, 1151);
pub const OBJ_ua_pki = blk: {
    _ = &OBJ_ISO_UA;
    _ = @as(c_long, 2);
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_dstu28147 = "dstu28147";
pub const LN_dstu28147 = "DSTU Gost 28147-2009";
pub const NID_dstu28147 = @as(c_int, 1152);
pub const OBJ_dstu28147 = blk: {
    _ = &OBJ_ua_pki;
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_dstu28147_ofb = "dstu28147-ofb";
pub const LN_dstu28147_ofb = "DSTU Gost 28147-2009 OFB mode";
pub const NID_dstu28147_ofb = @as(c_int, 1153);
pub const OBJ_dstu28147_ofb = blk: {
    _ = &OBJ_dstu28147;
    break :blk @as(c_long, 2);
};
pub const SN_dstu28147_cfb = "dstu28147-cfb";
pub const LN_dstu28147_cfb = "DSTU Gost 28147-2009 CFB mode";
pub const NID_dstu28147_cfb = @as(c_int, 1154);
pub const OBJ_dstu28147_cfb = blk: {
    _ = &OBJ_dstu28147;
    break :blk @as(c_long, 3);
};
pub const SN_dstu28147_wrap = "dstu28147-wrap";
pub const LN_dstu28147_wrap = "DSTU Gost 28147-2009 key wrap";
pub const NID_dstu28147_wrap = @as(c_int, 1155);
pub const OBJ_dstu28147_wrap = blk: {
    _ = &OBJ_dstu28147;
    break :blk @as(c_long, 5);
};
pub const SN_hmacWithDstu34311 = "hmacWithDstu34311";
pub const LN_hmacWithDstu34311 = "HMAC DSTU Gost 34311-95";
pub const NID_hmacWithDstu34311 = @as(c_int, 1156);
pub const OBJ_hmacWithDstu34311 = blk: {
    _ = &OBJ_ua_pki;
    _ = @as(c_long, 1);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 2);
};
pub const SN_dstu34311 = "dstu34311";
pub const LN_dstu34311 = "DSTU Gost 34311-95";
pub const NID_dstu34311 = @as(c_int, 1157);
pub const OBJ_dstu34311 = blk: {
    _ = &OBJ_ua_pki;
    _ = @as(c_long, 1);
    _ = @as(c_long, 2);
    break :blk @as(c_long, 1);
};
pub const SN_dstu4145le = "dstu4145le";
pub const LN_dstu4145le = "DSTU 4145-2002 little endian";
pub const NID_dstu4145le = @as(c_int, 1158);
pub const OBJ_dstu4145le = blk: {
    _ = &OBJ_ua_pki;
    _ = @as(c_long, 1);
    _ = @as(c_long, 3);
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_dstu4145be = "dstu4145be";
pub const LN_dstu4145be = "DSTU 4145-2002 big endian";
pub const NID_dstu4145be = @as(c_int, 1159);
pub const OBJ_dstu4145be = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 1);
    break :blk @as(c_long, 1);
};
pub const SN_uacurve0 = "uacurve0";
pub const LN_uacurve0 = "DSTU curve 0";
pub const NID_uacurve0 = @as(c_int, 1160);
pub const OBJ_uacurve0 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 0);
};
pub const SN_uacurve1 = "uacurve1";
pub const LN_uacurve1 = "DSTU curve 1";
pub const NID_uacurve1 = @as(c_int, 1161);
pub const OBJ_uacurve1 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 1);
};
pub const SN_uacurve2 = "uacurve2";
pub const LN_uacurve2 = "DSTU curve 2";
pub const NID_uacurve2 = @as(c_int, 1162);
pub const OBJ_uacurve2 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 2);
};
pub const SN_uacurve3 = "uacurve3";
pub const LN_uacurve3 = "DSTU curve 3";
pub const NID_uacurve3 = @as(c_int, 1163);
pub const OBJ_uacurve3 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 3);
};
pub const SN_uacurve4 = "uacurve4";
pub const LN_uacurve4 = "DSTU curve 4";
pub const NID_uacurve4 = @as(c_int, 1164);
pub const OBJ_uacurve4 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 4);
};
pub const SN_uacurve5 = "uacurve5";
pub const LN_uacurve5 = "DSTU curve 5";
pub const NID_uacurve5 = @as(c_int, 1165);
pub const OBJ_uacurve5 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 5);
};
pub const SN_uacurve6 = "uacurve6";
pub const LN_uacurve6 = "DSTU curve 6";
pub const NID_uacurve6 = @as(c_int, 1166);
pub const OBJ_uacurve6 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 6);
};
pub const SN_uacurve7 = "uacurve7";
pub const LN_uacurve7 = "DSTU curve 7";
pub const NID_uacurve7 = @as(c_int, 1167);
pub const OBJ_uacurve7 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 7);
};
pub const SN_uacurve8 = "uacurve8";
pub const LN_uacurve8 = "DSTU curve 8";
pub const NID_uacurve8 = @as(c_int, 1168);
pub const OBJ_uacurve8 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 8);
};
pub const SN_uacurve9 = "uacurve9";
pub const LN_uacurve9 = "DSTU curve 9";
pub const NID_uacurve9 = @as(c_int, 1169);
pub const OBJ_uacurve9 = blk: {
    _ = &OBJ_dstu4145le;
    _ = @as(c_long, 2);
    break :blk @as(c_long, 9);
};
pub const SN_aes_128_siv = "AES-128-SIV";
pub const LN_aes_128_siv = "aes-128-siv";
pub const NID_aes_128_siv = @as(c_int, 1198);
pub const SN_aes_192_siv = "AES-192-SIV";
pub const LN_aes_192_siv = "aes-192-siv";
pub const NID_aes_192_siv = @as(c_int, 1199);
pub const SN_aes_256_siv = "AES-256-SIV";
pub const LN_aes_256_siv = "aes-256-siv";
pub const NID_aes_256_siv = @as(c_int, 1200);
pub const SN_id_tc26_cipher_gostr3412_2015_magma_ctracpkm = SN_magma_ctr_acpkm;
pub const NID_id_tc26_cipher_gostr3412_2015_magma_ctracpkm = NID_magma_ctr_acpkm;
pub const OBJ_id_tc26_cipher_gostr3412_2015_magma_ctracpkm = OBJ_magma_ctr_acpkm;
pub const SN_id_tc26_cipher_gostr3412_2015_magma_ctracpkm_omac = SN_magma_ctr_acpkm_omac;
pub const NID_id_tc26_cipher_gostr3412_2015_magma_ctracpkm_omac = NID_magma_ctr_acpkm_omac;
pub const OBJ_id_tc26_cipher_gostr3412_2015_magma_ctracpkm_omac = OBJ_magma_ctr_acpkm_omac;
pub const SN_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm = SN_kuznyechik_ctr_acpkm;
pub const NID_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm = NID_kuznyechik_ctr_acpkm;
pub const OBJ_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm = OBJ_kuznyechik_ctr_acpkm;
pub const SN_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm_omac = SN_kuznyechik_ctr_acpkm_omac;
pub const NID_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm_omac = NID_kuznyechik_ctr_acpkm_omac;
pub const OBJ_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm_omac = OBJ_kuznyechik_ctr_acpkm_omac;
pub const SN_id_tc26_wrap_gostr3412_2015_magma_kexp15 = SN_magma_kexp15;
pub const NID_id_tc26_wrap_gostr3412_2015_magma_kexp15 = NID_magma_kexp15;
pub const OBJ_id_tc26_wrap_gostr3412_2015_magma_kexp15 = OBJ_magma_kexp15;
pub const SN_id_tc26_wrap_gostr3412_2015_kuznyechik_kexp15 = SN_kuznyechik_kexp15;
pub const NID_id_tc26_wrap_gostr3412_2015_kuznyechik_kexp15 = NID_kuznyechik_kexp15;
pub const OBJ_id_tc26_wrap_gostr3412_2015_kuznyechik_kexp15 = OBJ_kuznyechik_kexp15;
pub const SN_grasshopper_ecb = SN_kuznyechik_ecb;
pub const NID_grasshopper_ecb = NID_kuznyechik_ecb;
pub const SN_grasshopper_ctr = SN_kuznyechik_ctr;
pub const NID_grasshopper_ctr = NID_kuznyechik_ctr;
pub const SN_grasshopper_ofb = SN_kuznyechik_ofb;
pub const NID_grasshopper_ofb = NID_kuznyechik_ofb;
pub const SN_grasshopper_cbc = SN_kuznyechik_cbc;
pub const NID_grasshopper_cbc = NID_kuznyechik_cbc;
pub const SN_grasshopper_cfb = SN_kuznyechik_cfb;
pub const NID_grasshopper_cfb = NID_kuznyechik_cfb;
pub const SN_grasshopper_mac = SN_kuznyechik_mac;
pub const NID_grasshopper_mac = NID_kuznyechik_mac;
pub const OPENSSL_ASN1_H = "";
pub const HEADER_ASN1_H = "";
pub const OPENSSL_ASN1ERR_H = "";
pub const ASN1_R_ADDING_OBJECT = @as(c_int, 171);
pub const ASN1_R_ASN1_PARSE_ERROR = @as(c_int, 203);
pub const ASN1_R_ASN1_SIG_PARSE_ERROR = @as(c_int, 204);
pub const ASN1_R_AUX_ERROR = @as(c_int, 100);
pub const ASN1_R_BAD_OBJECT_HEADER = @as(c_int, 102);
pub const ASN1_R_BAD_TEMPLATE = @as(c_int, 230);
pub const ASN1_R_BMPSTRING_IS_WRONG_LENGTH = @as(c_int, 214);
pub const ASN1_R_BN_LIB = @as(c_int, 105);
pub const ASN1_R_BOOLEAN_IS_WRONG_LENGTH = @as(c_int, 106);
pub const ASN1_R_BUFFER_TOO_SMALL = @as(c_int, 107);
pub const ASN1_R_CIPHER_HAS_NO_OBJECT_IDENTIFIER = @as(c_int, 108);
pub const ASN1_R_CONTEXT_NOT_INITIALISED = @as(c_int, 217);
pub const ASN1_R_DATA_IS_WRONG = @as(c_int, 109);
pub const ASN1_R_DECODE_ERROR = @as(c_int, 110);
pub const ASN1_R_DEPTH_EXCEEDED = @as(c_int, 174);
pub const ASN1_R_DIGEST_AND_KEY_TYPE_NOT_SUPPORTED = @as(c_int, 198);
pub const ASN1_R_ENCODE_ERROR = @as(c_int, 112);
pub const ASN1_R_ERROR_GETTING_TIME = @as(c_int, 173);
pub const ASN1_R_ERROR_LOADING_SECTION = @as(c_int, 172);
pub const ASN1_R_ERROR_SETTING_CIPHER_PARAMS = @as(c_int, 114);
pub const ASN1_R_EXPECTING_AN_INTEGER = @as(c_int, 115);
pub const ASN1_R_EXPECTING_AN_OBJECT = @as(c_int, 116);
pub const ASN1_R_EXPLICIT_LENGTH_MISMATCH = @as(c_int, 119);
pub const ASN1_R_EXPLICIT_TAG_NOT_CONSTRUCTED = @as(c_int, 120);
pub const ASN1_R_FIELD_MISSING = @as(c_int, 121);
pub const ASN1_R_FIRST_NUM_TOO_LARGE = @as(c_int, 122);
pub const ASN1_R_HEADER_TOO_LONG = @as(c_int, 123);
pub const ASN1_R_ILLEGAL_BITSTRING_FORMAT = @as(c_int, 175);
pub const ASN1_R_ILLEGAL_BOOLEAN = @as(c_int, 176);
pub const ASN1_R_ILLEGAL_CHARACTERS = @as(c_int, 124);
pub const ASN1_R_ILLEGAL_FORMAT = @as(c_int, 177);
pub const ASN1_R_ILLEGAL_HEX = @as(c_int, 178);
pub const ASN1_R_ILLEGAL_IMPLICIT_TAG = @as(c_int, 179);
pub const ASN1_R_ILLEGAL_INTEGER = @as(c_int, 180);
pub const ASN1_R_ILLEGAL_NEGATIVE_VALUE = @as(c_int, 226);
pub const ASN1_R_ILLEGAL_NESTED_TAGGING = @as(c_int, 181);
pub const ASN1_R_ILLEGAL_NULL = @as(c_int, 125);
pub const ASN1_R_ILLEGAL_NULL_VALUE = @as(c_int, 182);
pub const ASN1_R_ILLEGAL_OBJECT = @as(c_int, 183);
pub const ASN1_R_ILLEGAL_OPTIONAL_ANY = @as(c_int, 126);
pub const ASN1_R_ILLEGAL_OPTIONS_ON_ITEM_TEMPLATE = @as(c_int, 170);
pub const ASN1_R_ILLEGAL_PADDING = @as(c_int, 221);
pub const ASN1_R_ILLEGAL_TAGGED_ANY = @as(c_int, 127);
pub const ASN1_R_ILLEGAL_TIME_VALUE = @as(c_int, 184);
pub const ASN1_R_ILLEGAL_ZERO_CONTENT = @as(c_int, 222);
pub const ASN1_R_INTEGER_NOT_ASCII_FORMAT = @as(c_int, 185);
pub const ASN1_R_INTEGER_TOO_LARGE_FOR_LONG = @as(c_int, 128);
pub const ASN1_R_INVALID_BIT_STRING_BITS_LEFT = @as(c_int, 220);
pub const ASN1_R_INVALID_BMPSTRING_LENGTH = @as(c_int, 129);
pub const ASN1_R_INVALID_DIGIT = @as(c_int, 130);
pub const ASN1_R_INVALID_MIME_TYPE = @as(c_int, 205);
pub const ASN1_R_INVALID_MODIFIER = @as(c_int, 186);
pub const ASN1_R_INVALID_NUMBER = @as(c_int, 187);
pub const ASN1_R_INVALID_OBJECT_ENCODING = @as(c_int, 216);
pub const ASN1_R_INVALID_SCRYPT_PARAMETERS = @as(c_int, 227);
pub const ASN1_R_INVALID_SEPARATOR = @as(c_int, 131);
pub const ASN1_R_INVALID_STRING_TABLE_VALUE = @as(c_int, 218);
pub const ASN1_R_INVALID_UNIVERSALSTRING_LENGTH = @as(c_int, 133);
pub const ASN1_R_INVALID_UTF8STRING = @as(c_int, 134);
pub const ASN1_R_INVALID_VALUE = @as(c_int, 219);
pub const ASN1_R_LENGTH_TOO_LONG = @as(c_int, 231);
pub const ASN1_R_LIST_ERROR = @as(c_int, 188);
pub const ASN1_R_MIME_NO_CONTENT_TYPE = @as(c_int, 206);
pub const ASN1_R_MIME_PARSE_ERROR = @as(c_int, 207);
pub const ASN1_R_MIME_SIG_PARSE_ERROR = @as(c_int, 208);
pub const ASN1_R_MISSING_EOC = @as(c_int, 137);
pub const ASN1_R_MISSING_SECOND_NUMBER = @as(c_int, 138);
pub const ASN1_R_MISSING_VALUE = @as(c_int, 189);
pub const ASN1_R_MSTRING_NOT_UNIVERSAL = @as(c_int, 139);
pub const ASN1_R_MSTRING_WRONG_TAG = @as(c_int, 140);
pub const ASN1_R_NESTED_ASN1_STRING = @as(c_int, 197);
pub const ASN1_R_NESTED_TOO_DEEP = @as(c_int, 201);
pub const ASN1_R_NON_HEX_CHARACTERS = @as(c_int, 141);
pub const ASN1_R_NOT_ASCII_FORMAT = @as(c_int, 190);
pub const ASN1_R_NOT_ENOUGH_DATA = @as(c_int, 142);
pub const ASN1_R_NO_CONTENT_TYPE = @as(c_int, 209);
pub const ASN1_R_NO_MATCHING_CHOICE_TYPE = @as(c_int, 143);
pub const ASN1_R_NO_MULTIPART_BODY_FAILURE = @as(c_int, 210);
pub const ASN1_R_NO_MULTIPART_BOUNDARY = @as(c_int, 211);
pub const ASN1_R_NO_SIG_CONTENT_TYPE = @as(c_int, 212);
pub const ASN1_R_NULL_IS_WRONG_LENGTH = @as(c_int, 144);
pub const ASN1_R_OBJECT_NOT_ASCII_FORMAT = @as(c_int, 191);
pub const ASN1_R_ODD_NUMBER_OF_CHARS = @as(c_int, 145);
pub const ASN1_R_SECOND_NUMBER_TOO_LARGE = @as(c_int, 147);
pub const ASN1_R_SEQUENCE_LENGTH_MISMATCH = @as(c_int, 148);
pub const ASN1_R_SEQUENCE_NOT_CONSTRUCTED = @as(c_int, 149);
pub const ASN1_R_SEQUENCE_OR_SET_NEEDS_CONFIG = @as(c_int, 192);
pub const ASN1_R_SHORT_LINE = @as(c_int, 150);
pub const ASN1_R_SIG_INVALID_MIME_TYPE = @as(c_int, 213);
pub const ASN1_R_STREAMING_NOT_SUPPORTED = @as(c_int, 202);
pub const ASN1_R_STRING_TOO_LONG = @as(c_int, 151);
pub const ASN1_R_STRING_TOO_SHORT = @as(c_int, 152);
pub const ASN1_R_THE_ASN1_OBJECT_IDENTIFIER_IS_NOT_KNOWN_FOR_THIS_MD = @as(c_int, 154);
pub const ASN1_R_TIME_NOT_ASCII_FORMAT = @as(c_int, 193);
pub const ASN1_R_TOO_LARGE = @as(c_int, 223);
pub const ASN1_R_TOO_LONG = @as(c_int, 155);
pub const ASN1_R_TOO_SMALL = @as(c_int, 224);
pub const ASN1_R_TYPE_NOT_CONSTRUCTED = @as(c_int, 156);
pub const ASN1_R_TYPE_NOT_PRIMITIVE = @as(c_int, 195);
pub const ASN1_R_UNEXPECTED_EOC = @as(c_int, 159);
pub const ASN1_R_UNIVERSALSTRING_IS_WRONG_LENGTH = @as(c_int, 215);
pub const ASN1_R_UNKNOWN_DIGEST = @as(c_int, 229);
pub const ASN1_R_UNKNOWN_FORMAT = @as(c_int, 160);
pub const ASN1_R_UNKNOWN_MESSAGE_DIGEST_ALGORITHM = @as(c_int, 161);
pub const ASN1_R_UNKNOWN_OBJECT_TYPE = @as(c_int, 162);
pub const ASN1_R_UNKNOWN_PUBLIC_KEY_TYPE = @as(c_int, 163);
pub const ASN1_R_UNKNOWN_SIGNATURE_ALGORITHM = @as(c_int, 199);
pub const ASN1_R_UNKNOWN_TAG = @as(c_int, 194);
pub const ASN1_R_UNSUPPORTED_ANY_DEFINED_BY_TYPE = @as(c_int, 164);
pub const ASN1_R_UNSUPPORTED_CIPHER = @as(c_int, 228);
pub const ASN1_R_UNSUPPORTED_PUBLIC_KEY_TYPE = @as(c_int, 167);
pub const ASN1_R_UNSUPPORTED_TYPE = @as(c_int, 196);
pub const ASN1_R_WRONG_INTEGER_TYPE = @as(c_int, 225);
pub const ASN1_R_WRONG_PUBLIC_KEY_TYPE = @as(c_int, 200);
pub const ASN1_R_WRONG_TAG = @as(c_int, 168);
pub const V_ASN1_UNIVERSAL = @as(c_int, 0x00);
pub const V_ASN1_APPLICATION = @as(c_int, 0x40);
pub const V_ASN1_CONTEXT_SPECIFIC = @as(c_int, 0x80);
pub const V_ASN1_PRIVATE = @as(c_int, 0xc0);
pub const V_ASN1_CONSTRUCTED = @as(c_int, 0x20);
pub const V_ASN1_PRIMITIVE_TAG = @as(c_int, 0x1f);
pub const V_ASN1_PRIMATIVE_TAG = V_ASN1_PRIMITIVE_TAG;
pub const V_ASN1_APP_CHOOSE = -@as(c_int, 2);
pub const V_ASN1_OTHER = -@as(c_int, 3);
pub const V_ASN1_ANY = -@as(c_int, 4);
pub const V_ASN1_UNDEF = -@as(c_int, 1);
pub const V_ASN1_EOC = @as(c_int, 0);
pub const V_ASN1_BOOLEAN = @as(c_int, 1);
pub const V_ASN1_INTEGER = @as(c_int, 2);
pub const V_ASN1_BIT_STRING = @as(c_int, 3);
pub const V_ASN1_OCTET_STRING = @as(c_int, 4);
pub const V_ASN1_NULL = @as(c_int, 5);
pub const V_ASN1_OBJECT = @as(c_int, 6);
pub const V_ASN1_OBJECT_DESCRIPTOR = @as(c_int, 7);
pub const V_ASN1_EXTERNAL = @as(c_int, 8);
pub const V_ASN1_REAL = @as(c_int, 9);
pub const V_ASN1_ENUMERATED = @as(c_int, 10);
pub const V_ASN1_UTF8STRING = @as(c_int, 12);
pub const V_ASN1_SEQUENCE = @as(c_int, 16);
pub const V_ASN1_SET = @as(c_int, 17);
pub const V_ASN1_NUMERICSTRING = @as(c_int, 18);
pub const V_ASN1_PRINTABLESTRING = @as(c_int, 19);
pub const V_ASN1_T61STRING = @as(c_int, 20);
pub const V_ASN1_TELETEXSTRING = @as(c_int, 20);
pub const V_ASN1_VIDEOTEXSTRING = @as(c_int, 21);
pub const V_ASN1_IA5STRING = @as(c_int, 22);
pub const V_ASN1_UTCTIME = @as(c_int, 23);
pub const V_ASN1_GENERALIZEDTIME = @as(c_int, 24);
pub const V_ASN1_GRAPHICSTRING = @as(c_int, 25);
pub const V_ASN1_ISO64STRING = @as(c_int, 26);
pub const V_ASN1_VISIBLESTRING = @as(c_int, 26);
pub const V_ASN1_GENERALSTRING = @as(c_int, 27);
pub const V_ASN1_UNIVERSALSTRING = @as(c_int, 28);
pub const V_ASN1_BMPSTRING = @as(c_int, 30);
pub const V_ASN1_NEG = @as(c_int, 0x100);
pub const V_ASN1_NEG_INTEGER = @as(c_int, 2) | V_ASN1_NEG;
pub const V_ASN1_NEG_ENUMERATED = @as(c_int, 10) | V_ASN1_NEG;
pub const B_ASN1_NUMERICSTRING = @as(c_int, 0x0001);
pub const B_ASN1_PRINTABLESTRING = @as(c_int, 0x0002);
pub const B_ASN1_T61STRING = @as(c_int, 0x0004);
pub const B_ASN1_TELETEXSTRING = @as(c_int, 0x0004);
pub const B_ASN1_VIDEOTEXSTRING = @as(c_int, 0x0008);
pub const B_ASN1_IA5STRING = @as(c_int, 0x0010);
pub const B_ASN1_GRAPHICSTRING = @as(c_int, 0x0020);
pub const B_ASN1_ISO64STRING = @as(c_int, 0x0040);
pub const B_ASN1_VISIBLESTRING = @as(c_int, 0x0040);
pub const B_ASN1_GENERALSTRING = @as(c_int, 0x0080);
pub const B_ASN1_UNIVERSALSTRING = @as(c_int, 0x0100);
pub const B_ASN1_OCTET_STRING = @as(c_int, 0x0200);
pub const B_ASN1_BIT_STRING = @as(c_int, 0x0400);
pub const B_ASN1_BMPSTRING = @as(c_int, 0x0800);
pub const B_ASN1_UNKNOWN = @as(c_int, 0x1000);
pub const B_ASN1_UTF8STRING = @as(c_int, 0x2000);
pub const B_ASN1_UTCTIME = @as(c_int, 0x4000);
pub const B_ASN1_GENERALIZEDTIME = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hex);
pub const B_ASN1_SEQUENCE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10000, .hex);
pub const MBSTRING_FLAG = @as(c_int, 0x1000);
pub const MBSTRING_UTF8 = MBSTRING_FLAG;
pub const MBSTRING_ASC = MBSTRING_FLAG | @as(c_int, 1);
pub const MBSTRING_BMP = MBSTRING_FLAG | @as(c_int, 2);
pub const MBSTRING_UNIV = MBSTRING_FLAG | @as(c_int, 4);
pub const SMIME_OLDMIME = @as(c_int, 0x400);
pub const SMIME_CRLFEOL = @as(c_int, 0x800);
pub const SMIME_STREAM = @as(c_int, 0x1000);
pub inline fn sk_X509_ALGOR_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_X509_ALGOR_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_X509_ALGOR_sk_type(sk));
}
pub inline fn sk_X509_ALGOR_value(sk: anytype, idx: anytype) [*c]X509_ALGOR {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]X509_ALGOR, OPENSSL_sk_value(ossl_check_const_X509_ALGOR_sk_type(sk), idx));
}
pub const sk_X509_ALGOR_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:132:9
pub const sk_X509_ALGOR_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:133:9
pub const sk_X509_ALGOR_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:134:9
pub inline fn sk_X509_ALGOR_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_X509_ALGOR_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_X509_ALGOR_sk_type(sk), n);
}
pub inline fn sk_X509_ALGOR_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_X509_ALGOR_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_X509_ALGOR_sk_type(sk));
}
pub inline fn sk_X509_ALGOR_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_X509_ALGOR_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_X509_ALGOR_sk_type(sk));
}
pub inline fn sk_X509_ALGOR_delete(sk: anytype, i: anytype) [*c]X509_ALGOR {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]X509_ALGOR, OPENSSL_sk_delete(ossl_check_X509_ALGOR_sk_type(sk), i));
}
pub inline fn sk_X509_ALGOR_delete_ptr(sk: anytype, ptr: anytype) [*c]X509_ALGOR {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]X509_ALGOR, OPENSSL_sk_delete_ptr(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr)));
}
pub inline fn sk_X509_ALGOR_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr));
}
pub inline fn sk_X509_ALGOR_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr));
}
pub inline fn sk_X509_ALGOR_pop(sk: anytype) [*c]X509_ALGOR {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]X509_ALGOR, OPENSSL_sk_pop(ossl_check_X509_ALGOR_sk_type(sk)));
}
pub inline fn sk_X509_ALGOR_shift(sk: anytype) [*c]X509_ALGOR {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]X509_ALGOR, OPENSSL_sk_shift(ossl_check_X509_ALGOR_sk_type(sk)));
}
pub inline fn sk_X509_ALGOR_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_freefunc_type(freefunc));
}
pub inline fn sk_X509_ALGOR_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr), idx);
}
pub inline fn sk_X509_ALGOR_set(sk: anytype, idx: anytype, ptr: anytype) [*c]X509_ALGOR {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]X509_ALGOR, OPENSSL_sk_set(ossl_check_X509_ALGOR_sk_type(sk), idx, ossl_check_X509_ALGOR_type(ptr)));
}
pub inline fn sk_X509_ALGOR_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr));
}
pub inline fn sk_X509_ALGOR_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr));
}
pub inline fn sk_X509_ALGOR_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_type(ptr), pnum);
}
pub inline fn sk_X509_ALGOR_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_X509_ALGOR_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_X509_ALGOR_sk_type(sk));
}
pub inline fn sk_X509_ALGOR_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_X509_ALGOR_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_X509_ALGOR_sk_type(sk));
}
pub const sk_X509_ALGOR_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:152:9
pub const sk_X509_ALGOR_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:153:9
pub inline fn sk_X509_ALGOR_set_cmp_func(sk: anytype, cmp: anytype) sk_X509_ALGOR_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_X509_ALGOR_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_X509_ALGOR_sk_type(sk), ossl_check_X509_ALGOR_compfunc_type(cmp)));
}
pub const ASN1_STRING_FLAG_BITS_LEFT = @as(c_int, 0x08);
pub const ASN1_STRING_FLAG_NDEF = @as(c_int, 0x010);
pub const ASN1_STRING_FLAG_CONT = @as(c_int, 0x020);
pub const ASN1_STRING_FLAG_MSTRING = @as(c_int, 0x040);
pub const ASN1_STRING_FLAG_EMBED = @as(c_int, 0x080);
pub const ASN1_STRING_FLAG_X509_TIME = @as(c_int, 0x100);
pub const ASN1_LONG_UNDEF = @as(c_long, 0x7fffffff);
pub const STABLE_FLAGS_MALLOC = @as(c_int, 0x01);
pub const STABLE_FLAGS_CLEAR = STABLE_FLAGS_MALLOC;
pub const STABLE_NO_MASK = @as(c_int, 0x02);
pub const DIRSTRING_TYPE = ((B_ASN1_PRINTABLESTRING | B_ASN1_T61STRING) | B_ASN1_BMPSTRING) | B_ASN1_UTF8STRING;
pub const PKCS9STRING_TYPE = DIRSTRING_TYPE | B_ASN1_IA5STRING;
pub inline fn sk_ASN1_STRING_TABLE_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_ASN1_STRING_TABLE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_ASN1_STRING_TABLE_sk_type(sk));
}
pub inline fn sk_ASN1_STRING_TABLE_value(sk: anytype, idx: anytype) [*c]ASN1_STRING_TABLE {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]ASN1_STRING_TABLE, OPENSSL_sk_value(ossl_check_const_ASN1_STRING_TABLE_sk_type(sk), idx));
}
pub const sk_ASN1_STRING_TABLE_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:234:9
pub const sk_ASN1_STRING_TABLE_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:235:9
pub const sk_ASN1_STRING_TABLE_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:236:9
pub inline fn sk_ASN1_STRING_TABLE_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_ASN1_STRING_TABLE_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_ASN1_STRING_TABLE_sk_type(sk), n);
}
pub inline fn sk_ASN1_STRING_TABLE_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_ASN1_STRING_TABLE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_ASN1_STRING_TABLE_sk_type(sk));
}
pub inline fn sk_ASN1_STRING_TABLE_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_ASN1_STRING_TABLE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_ASN1_STRING_TABLE_sk_type(sk));
}
pub inline fn sk_ASN1_STRING_TABLE_delete(sk: anytype, i: anytype) [*c]ASN1_STRING_TABLE {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]ASN1_STRING_TABLE, OPENSSL_sk_delete(ossl_check_ASN1_STRING_TABLE_sk_type(sk), i));
}
pub inline fn sk_ASN1_STRING_TABLE_delete_ptr(sk: anytype, ptr: anytype) [*c]ASN1_STRING_TABLE {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_STRING_TABLE, OPENSSL_sk_delete_ptr(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr)));
}
pub inline fn sk_ASN1_STRING_TABLE_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr));
}
pub inline fn sk_ASN1_STRING_TABLE_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr));
}
pub inline fn sk_ASN1_STRING_TABLE_pop(sk: anytype) [*c]ASN1_STRING_TABLE {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_STRING_TABLE, OPENSSL_sk_pop(ossl_check_ASN1_STRING_TABLE_sk_type(sk)));
}
pub inline fn sk_ASN1_STRING_TABLE_shift(sk: anytype) [*c]ASN1_STRING_TABLE {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_STRING_TABLE, OPENSSL_sk_shift(ossl_check_ASN1_STRING_TABLE_sk_type(sk)));
}
pub inline fn sk_ASN1_STRING_TABLE_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_freefunc_type(freefunc));
}
pub inline fn sk_ASN1_STRING_TABLE_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr), idx);
}
pub inline fn sk_ASN1_STRING_TABLE_set(sk: anytype, idx: anytype, ptr: anytype) [*c]ASN1_STRING_TABLE {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_STRING_TABLE, OPENSSL_sk_set(ossl_check_ASN1_STRING_TABLE_sk_type(sk), idx, ossl_check_ASN1_STRING_TABLE_type(ptr)));
}
pub inline fn sk_ASN1_STRING_TABLE_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr));
}
pub inline fn sk_ASN1_STRING_TABLE_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr));
}
pub inline fn sk_ASN1_STRING_TABLE_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_type(ptr), pnum);
}
pub inline fn sk_ASN1_STRING_TABLE_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_ASN1_STRING_TABLE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_ASN1_STRING_TABLE_sk_type(sk));
}
pub inline fn sk_ASN1_STRING_TABLE_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_ASN1_STRING_TABLE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_ASN1_STRING_TABLE_sk_type(sk));
}
pub const sk_ASN1_STRING_TABLE_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:254:9
pub const sk_ASN1_STRING_TABLE_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:255:9
pub inline fn sk_ASN1_STRING_TABLE_set_cmp_func(sk: anytype, cmp: anytype) sk_ASN1_STRING_TABLE_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_ASN1_STRING_TABLE_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_ASN1_STRING_TABLE_sk_type(sk), ossl_check_ASN1_STRING_TABLE_compfunc_type(cmp)));
}
pub const ub_name = @import("std").zig.c_translation.promoteIntLiteral(c_int, 32768, .decimal);
pub const ub_common_name = @as(c_int, 64);
pub const ub_locality_name = @as(c_int, 128);
pub const ub_state_name = @as(c_int, 128);
pub const ub_organization_name = @as(c_int, 64);
pub const ub_organization_unit_name = @as(c_int, 64);
pub const ub_title = @as(c_int, 64);
pub const ub_email_address = @as(c_int, 128);
pub inline fn DECLARE_ASN1_FUNCTIONS_attr(attr: anytype, @"type": anytype) @TypeOf(DECLARE_ASN1_FUNCTIONS_name_attr(attr, @"type", @"type")) {
    _ = &attr;
    _ = &@"type";
    return DECLARE_ASN1_FUNCTIONS_name_attr(attr, @"type", @"type");
}
pub const DECLARE_ASN1_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:288:10
pub inline fn DECLARE_ASN1_ALLOC_FUNCTIONS_attr(attr: anytype, @"type": anytype) @TypeOf(DECLARE_ASN1_ALLOC_FUNCTIONS_name_attr(attr, @"type", @"type")) {
    _ = &attr;
    _ = &@"type";
    return DECLARE_ASN1_ALLOC_FUNCTIONS_name_attr(attr, @"type", @"type");
}
pub const DECLARE_ASN1_ALLOC_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:293:10
pub inline fn DECLARE_ASN1_FUNCTIONS_name_attr(attr: anytype, @"type": anytype, name: anytype) @TypeOf(DECLARE_ASN1_ALLOC_FUNCTIONS_name_attr(attr, @"type", name) ++ DECLARE_ASN1_ENCODE_FUNCTIONS_name_attr(attr, @"type", name)) {
    _ = &attr;
    _ = &@"type";
    _ = &name;
    return DECLARE_ASN1_ALLOC_FUNCTIONS_name_attr(attr, @"type", name) ++ DECLARE_ASN1_ENCODE_FUNCTIONS_name_attr(attr, @"type", name);
}
pub const DECLARE_ASN1_FUNCTIONS_name = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:299:10
pub inline fn DECLARE_ASN1_ENCODE_FUNCTIONS_attr(attr: anytype, @"type": anytype, itname: anytype, name: anytype) @TypeOf(DECLARE_ASN1_ENCODE_FUNCTIONS_only_attr(attr, @"type", name) ++ DECLARE_ASN1_ITEM_attr(attr, itname)) {
    _ = &attr;
    _ = &@"type";
    _ = &itname;
    _ = &name;
    return DECLARE_ASN1_ENCODE_FUNCTIONS_only_attr(attr, @"type", name) ++ DECLARE_ASN1_ITEM_attr(attr, itname);
}
pub const DECLARE_ASN1_ENCODE_FUNCTIONS = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:305:10
pub inline fn DECLARE_ASN1_ENCODE_FUNCTIONS_name_attr(attr: anytype, @"type": anytype, name: anytype) @TypeOf(DECLARE_ASN1_ENCODE_FUNCTIONS_attr(attr, @"type", name, name)) {
    _ = &attr;
    _ = &@"type";
    _ = &name;
    return DECLARE_ASN1_ENCODE_FUNCTIONS_attr(attr, @"type", name, name);
}
pub const DECLARE_ASN1_ENCODE_FUNCTIONS_name = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:310:10
pub const DECLARE_ASN1_ENCODE_FUNCTIONS_only_attr = @compileError("unable to translate macro: undefined identifier `d2i_`");
// /usr/include/openssl/asn1.h:313:10
pub const DECLARE_ASN1_ENCODE_FUNCTIONS_only = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:316:10
pub const DECLARE_ASN1_NDEF_FUNCTION_attr = @compileError("unable to translate macro: undefined identifier `i2d_`");
// /usr/include/openssl/asn1.h:319:10
pub const DECLARE_ASN1_NDEF_FUNCTION = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:321:10
pub const DECLARE_ASN1_ALLOC_FUNCTIONS_name_attr = @compileError("unable to translate macro: undefined identifier `_new`");
// /usr/include/openssl/asn1.h:324:10
pub const DECLARE_ASN1_ALLOC_FUNCTIONS_name = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:327:10
pub inline fn DECLARE_ASN1_DUP_FUNCTION_attr(attr: anytype, @"type": anytype) @TypeOf(DECLARE_ASN1_DUP_FUNCTION_name_attr(attr, @"type", @"type")) {
    _ = &attr;
    _ = &@"type";
    return DECLARE_ASN1_DUP_FUNCTION_name_attr(attr, @"type", @"type");
}
pub const DECLARE_ASN1_DUP_FUNCTION = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:332:10
pub const DECLARE_ASN1_DUP_FUNCTION_name_attr = @compileError("unable to translate macro: undefined identifier `_dup`");
// /usr/include/openssl/asn1.h:335:10
pub const DECLARE_ASN1_DUP_FUNCTION_name = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:337:10
pub inline fn DECLARE_ASN1_PRINT_FUNCTION_attr(attr: anytype, stname: anytype) @TypeOf(DECLARE_ASN1_PRINT_FUNCTION_fname_attr(attr, stname, stname)) {
    _ = &attr;
    _ = &stname;
    return DECLARE_ASN1_PRINT_FUNCTION_fname_attr(attr, stname, stname);
}
pub const DECLARE_ASN1_PRINT_FUNCTION = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:342:10
pub const DECLARE_ASN1_PRINT_FUNCTION_fname_attr = @compileError("unable to translate macro: undefined identifier `_print_ctx`");
// /usr/include/openssl/asn1.h:345:10
pub const DECLARE_ASN1_PRINT_FUNCTION_fname = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:348:10
pub const D2I_OF = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:351:10
pub const I2D_OF = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:352:10
pub const CHECKED_D2I_OF = @compileError("unable to translate C expr: expected ')' instead got 'A number'");
// /usr/include/openssl/asn1.h:354:10
pub const CHECKED_I2D_OF = @compileError("unable to translate C expr: expected ')' instead got 'A number'");
// /usr/include/openssl/asn1.h:356:10
pub const CHECKED_NEW_OF = @compileError("unable to translate C expr: expected ')' instead got '('");
// /usr/include/openssl/asn1.h:358:10
pub const CHECKED_PTR_OF = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:360:10
pub const CHECKED_PPTR_OF = @compileError("unable to translate C expr: expected ')' instead got '*'");
// /usr/include/openssl/asn1.h:362:10
pub const TYPEDEF_D2I_OF = @compileError("unable to translate macro: undefined identifier `d2i_of_`");
// /usr/include/openssl/asn1.h:365:10
pub const TYPEDEF_I2D_OF = @compileError("unable to translate macro: undefined identifier `i2d_of_`");
// /usr/include/openssl/asn1.h:366:10
pub const TYPEDEF_D2I2D_OF = @compileError("unable to translate C expr: unexpected token ';'");
// /usr/include/openssl/asn1.h:367:10
pub inline fn ASN1_ITEM_ptr(iptr: anytype) @TypeOf(iptr()) {
    _ = &iptr;
    return iptr();
}
pub const ASN1_ITEM_ref = @compileError("unable to translate macro: undefined identifier `_it`");
// /usr/include/openssl/asn1.h:421:10
pub const ASN1_ITEM_rptr = @compileError("unable to translate macro: undefined identifier `_it`");
// /usr/include/openssl/asn1.h:423:10
pub const DECLARE_ASN1_ITEM_attr = @compileError("unable to translate macro: undefined identifier `_it`");
// /usr/include/openssl/asn1.h:425:10
pub const DECLARE_ASN1_ITEM = @compileError("unable to translate C expr: unexpected token 'extern'");
// /usr/include/openssl/asn1.h:427:10
pub const ASN1_STRFLGS_ESC_2253 = @as(c_int, 1);
pub const ASN1_STRFLGS_ESC_CTRL = @as(c_int, 2);
pub const ASN1_STRFLGS_ESC_MSB = @as(c_int, 4);
pub const ASN1_DTFLGS_TYPE_MASK = @as(c_ulong, 0x0F);
pub const ASN1_DTFLGS_RFC822 = @as(c_ulong, 0x00);
pub const ASN1_DTFLGS_ISO8601 = @as(c_ulong, 0x01);
pub const ASN1_STRFLGS_ESC_QUOTE = @as(c_int, 8);
pub const CHARTYPE_PRINTABLESTRING = @as(c_int, 0x10);
pub const CHARTYPE_FIRST_ESC_2253 = @as(c_int, 0x20);
pub const CHARTYPE_LAST_ESC_2253 = @as(c_int, 0x40);
pub const ASN1_STRFLGS_UTF8_CONVERT = @as(c_int, 0x10);
pub const ASN1_STRFLGS_IGNORE_TYPE = @as(c_int, 0x20);
pub const ASN1_STRFLGS_SHOW_TYPE = @as(c_int, 0x40);
pub const ASN1_STRFLGS_DUMP_ALL = @as(c_int, 0x80);
pub const ASN1_STRFLGS_DUMP_UNKNOWN = @as(c_int, 0x100);
pub const ASN1_STRFLGS_DUMP_DER = @as(c_int, 0x200);
pub const ASN1_STRFLGS_ESC_2254 = @as(c_int, 0x400);
pub const ASN1_STRFLGS_RFC2253 = ((((ASN1_STRFLGS_ESC_2253 | ASN1_STRFLGS_ESC_CTRL) | ASN1_STRFLGS_ESC_MSB) | ASN1_STRFLGS_UTF8_CONVERT) | ASN1_STRFLGS_DUMP_UNKNOWN) | ASN1_STRFLGS_DUMP_DER;
pub inline fn sk_ASN1_TYPE_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_ASN1_TYPE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_ASN1_TYPE_sk_type(sk));
}
pub inline fn sk_ASN1_TYPE_value(sk: anytype, idx: anytype) [*c]ASN1_TYPE {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]ASN1_TYPE, OPENSSL_sk_value(ossl_check_const_ASN1_TYPE_sk_type(sk), idx));
}
pub const sk_ASN1_TYPE_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:554:9
pub const sk_ASN1_TYPE_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:555:9
pub const sk_ASN1_TYPE_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:556:9
pub inline fn sk_ASN1_TYPE_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_ASN1_TYPE_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_ASN1_TYPE_sk_type(sk), n);
}
pub inline fn sk_ASN1_TYPE_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_ASN1_TYPE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_ASN1_TYPE_sk_type(sk));
}
pub inline fn sk_ASN1_TYPE_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_ASN1_TYPE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_ASN1_TYPE_sk_type(sk));
}
pub inline fn sk_ASN1_TYPE_delete(sk: anytype, i: anytype) [*c]ASN1_TYPE {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]ASN1_TYPE, OPENSSL_sk_delete(ossl_check_ASN1_TYPE_sk_type(sk), i));
}
pub inline fn sk_ASN1_TYPE_delete_ptr(sk: anytype, ptr: anytype) [*c]ASN1_TYPE {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_TYPE, OPENSSL_sk_delete_ptr(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr)));
}
pub inline fn sk_ASN1_TYPE_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr));
}
pub inline fn sk_ASN1_TYPE_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr));
}
pub inline fn sk_ASN1_TYPE_pop(sk: anytype) [*c]ASN1_TYPE {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_TYPE, OPENSSL_sk_pop(ossl_check_ASN1_TYPE_sk_type(sk)));
}
pub inline fn sk_ASN1_TYPE_shift(sk: anytype) [*c]ASN1_TYPE {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_TYPE, OPENSSL_sk_shift(ossl_check_ASN1_TYPE_sk_type(sk)));
}
pub inline fn sk_ASN1_TYPE_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_freefunc_type(freefunc));
}
pub inline fn sk_ASN1_TYPE_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr), idx);
}
pub inline fn sk_ASN1_TYPE_set(sk: anytype, idx: anytype, ptr: anytype) [*c]ASN1_TYPE {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_TYPE, OPENSSL_sk_set(ossl_check_ASN1_TYPE_sk_type(sk), idx, ossl_check_ASN1_TYPE_type(ptr)));
}
pub inline fn sk_ASN1_TYPE_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr));
}
pub inline fn sk_ASN1_TYPE_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr));
}
pub inline fn sk_ASN1_TYPE_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_type(ptr), pnum);
}
pub inline fn sk_ASN1_TYPE_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_ASN1_TYPE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_ASN1_TYPE_sk_type(sk));
}
pub inline fn sk_ASN1_TYPE_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_ASN1_TYPE_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_ASN1_TYPE_sk_type(sk));
}
pub const sk_ASN1_TYPE_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:574:9
pub const sk_ASN1_TYPE_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:575:9
pub inline fn sk_ASN1_TYPE_set_cmp_func(sk: anytype, cmp: anytype) sk_ASN1_TYPE_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_ASN1_TYPE_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_ASN1_TYPE_sk_type(sk), ossl_check_ASN1_TYPE_compfunc_type(cmp)));
}
pub const B_ASN1_TIME = B_ASN1_UTCTIME | B_ASN1_GENERALIZEDTIME;
pub const B_ASN1_PRINTABLE = ((((((((B_ASN1_NUMERICSTRING | B_ASN1_PRINTABLESTRING) | B_ASN1_T61STRING) | B_ASN1_IA5STRING) | B_ASN1_BIT_STRING) | B_ASN1_UNIVERSALSTRING) | B_ASN1_BMPSTRING) | B_ASN1_UTF8STRING) | B_ASN1_SEQUENCE) | B_ASN1_UNKNOWN;
pub const B_ASN1_DIRECTORYSTRING = (((B_ASN1_PRINTABLESTRING | B_ASN1_TELETEXSTRING) | B_ASN1_BMPSTRING) | B_ASN1_UNIVERSALSTRING) | B_ASN1_UTF8STRING;
pub const B_ASN1_DISPLAYTEXT = ((B_ASN1_IA5STRING | B_ASN1_VISIBLESTRING) | B_ASN1_BMPSTRING) | B_ASN1_UTF8STRING;
pub inline fn sk_ASN1_OBJECT_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_ASN1_OBJECT_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_ASN1_OBJECT_sk_type(sk));
}
pub inline fn sk_ASN1_OBJECT_value(sk: anytype, idx: anytype) [*c]ASN1_OBJECT {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]ASN1_OBJECT, OPENSSL_sk_value(ossl_check_const_ASN1_OBJECT_sk_type(sk), idx));
}
pub const sk_ASN1_OBJECT_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:634:9
pub const sk_ASN1_OBJECT_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:635:9
pub const sk_ASN1_OBJECT_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:636:9
pub inline fn sk_ASN1_OBJECT_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_ASN1_OBJECT_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_ASN1_OBJECT_sk_type(sk), n);
}
pub inline fn sk_ASN1_OBJECT_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_ASN1_OBJECT_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_ASN1_OBJECT_sk_type(sk));
}
pub inline fn sk_ASN1_OBJECT_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_ASN1_OBJECT_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_ASN1_OBJECT_sk_type(sk));
}
pub inline fn sk_ASN1_OBJECT_delete(sk: anytype, i: anytype) [*c]ASN1_OBJECT {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]ASN1_OBJECT, OPENSSL_sk_delete(ossl_check_ASN1_OBJECT_sk_type(sk), i));
}
pub inline fn sk_ASN1_OBJECT_delete_ptr(sk: anytype, ptr: anytype) [*c]ASN1_OBJECT {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_OBJECT, OPENSSL_sk_delete_ptr(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr)));
}
pub inline fn sk_ASN1_OBJECT_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr));
}
pub inline fn sk_ASN1_OBJECT_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr));
}
pub inline fn sk_ASN1_OBJECT_pop(sk: anytype) [*c]ASN1_OBJECT {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_OBJECT, OPENSSL_sk_pop(ossl_check_ASN1_OBJECT_sk_type(sk)));
}
pub inline fn sk_ASN1_OBJECT_shift(sk: anytype) [*c]ASN1_OBJECT {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_OBJECT, OPENSSL_sk_shift(ossl_check_ASN1_OBJECT_sk_type(sk)));
}
pub inline fn sk_ASN1_OBJECT_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_freefunc_type(freefunc));
}
pub inline fn sk_ASN1_OBJECT_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr), idx);
}
pub inline fn sk_ASN1_OBJECT_set(sk: anytype, idx: anytype, ptr: anytype) [*c]ASN1_OBJECT {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_OBJECT, OPENSSL_sk_set(ossl_check_ASN1_OBJECT_sk_type(sk), idx, ossl_check_ASN1_OBJECT_type(ptr)));
}
pub inline fn sk_ASN1_OBJECT_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr));
}
pub inline fn sk_ASN1_OBJECT_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr));
}
pub inline fn sk_ASN1_OBJECT_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_type(ptr), pnum);
}
pub inline fn sk_ASN1_OBJECT_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_ASN1_OBJECT_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_ASN1_OBJECT_sk_type(sk));
}
pub inline fn sk_ASN1_OBJECT_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_ASN1_OBJECT_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_ASN1_OBJECT_sk_type(sk));
}
pub const sk_ASN1_OBJECT_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:654:9
pub const sk_ASN1_OBJECT_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:655:9
pub inline fn sk_ASN1_OBJECT_set_cmp_func(sk: anytype, cmp: anytype) sk_ASN1_OBJECT_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_ASN1_OBJECT_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_ASN1_OBJECT_sk_type(sk), ossl_check_ASN1_OBJECT_compfunc_type(cmp)));
}
pub inline fn sk_ASN1_INTEGER_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_ASN1_INTEGER_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_ASN1_INTEGER_sk_type(sk));
}
pub inline fn sk_ASN1_INTEGER_value(sk: anytype, idx: anytype) [*c]ASN1_INTEGER {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]ASN1_INTEGER, OPENSSL_sk_value(ossl_check_const_ASN1_INTEGER_sk_type(sk), idx));
}
pub const sk_ASN1_INTEGER_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:700:9
pub const sk_ASN1_INTEGER_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:701:9
pub const sk_ASN1_INTEGER_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:702:9
pub inline fn sk_ASN1_INTEGER_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_ASN1_INTEGER_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_ASN1_INTEGER_sk_type(sk), n);
}
pub inline fn sk_ASN1_INTEGER_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_ASN1_INTEGER_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_ASN1_INTEGER_sk_type(sk));
}
pub inline fn sk_ASN1_INTEGER_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_ASN1_INTEGER_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_ASN1_INTEGER_sk_type(sk));
}
pub inline fn sk_ASN1_INTEGER_delete(sk: anytype, i: anytype) [*c]ASN1_INTEGER {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]ASN1_INTEGER, OPENSSL_sk_delete(ossl_check_ASN1_INTEGER_sk_type(sk), i));
}
pub inline fn sk_ASN1_INTEGER_delete_ptr(sk: anytype, ptr: anytype) [*c]ASN1_INTEGER {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_INTEGER, OPENSSL_sk_delete_ptr(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr)));
}
pub inline fn sk_ASN1_INTEGER_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr));
}
pub inline fn sk_ASN1_INTEGER_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr));
}
pub inline fn sk_ASN1_INTEGER_pop(sk: anytype) [*c]ASN1_INTEGER {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_INTEGER, OPENSSL_sk_pop(ossl_check_ASN1_INTEGER_sk_type(sk)));
}
pub inline fn sk_ASN1_INTEGER_shift(sk: anytype) [*c]ASN1_INTEGER {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_INTEGER, OPENSSL_sk_shift(ossl_check_ASN1_INTEGER_sk_type(sk)));
}
pub inline fn sk_ASN1_INTEGER_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_freefunc_type(freefunc));
}
pub inline fn sk_ASN1_INTEGER_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr), idx);
}
pub inline fn sk_ASN1_INTEGER_set(sk: anytype, idx: anytype, ptr: anytype) [*c]ASN1_INTEGER {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_INTEGER, OPENSSL_sk_set(ossl_check_ASN1_INTEGER_sk_type(sk), idx, ossl_check_ASN1_INTEGER_type(ptr)));
}
pub inline fn sk_ASN1_INTEGER_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr));
}
pub inline fn sk_ASN1_INTEGER_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr));
}
pub inline fn sk_ASN1_INTEGER_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_type(ptr), pnum);
}
pub inline fn sk_ASN1_INTEGER_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_ASN1_INTEGER_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_ASN1_INTEGER_sk_type(sk));
}
pub inline fn sk_ASN1_INTEGER_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_ASN1_INTEGER_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_ASN1_INTEGER_sk_type(sk));
}
pub const sk_ASN1_INTEGER_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:720:9
pub const sk_ASN1_INTEGER_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:721:9
pub inline fn sk_ASN1_INTEGER_set_cmp_func(sk: anytype, cmp: anytype) sk_ASN1_INTEGER_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_ASN1_INTEGER_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_ASN1_INTEGER_sk_type(sk), ossl_check_ASN1_INTEGER_compfunc_type(cmp)));
}
pub inline fn sk_ASN1_UTF8STRING_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_ASN1_UTF8STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_ASN1_UTF8STRING_sk_type(sk));
}
pub inline fn sk_ASN1_UTF8STRING_value(sk: anytype, idx: anytype) [*c]ASN1_UTF8STRING {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]ASN1_UTF8STRING, OPENSSL_sk_value(ossl_check_const_ASN1_UTF8STRING_sk_type(sk), idx));
}
pub const sk_ASN1_UTF8STRING_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:762:9
pub const sk_ASN1_UTF8STRING_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:763:9
pub const sk_ASN1_UTF8STRING_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:764:9
pub inline fn sk_ASN1_UTF8STRING_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_ASN1_UTF8STRING_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_ASN1_UTF8STRING_sk_type(sk), n);
}
pub inline fn sk_ASN1_UTF8STRING_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_ASN1_UTF8STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_ASN1_UTF8STRING_sk_type(sk));
}
pub inline fn sk_ASN1_UTF8STRING_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_ASN1_UTF8STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_ASN1_UTF8STRING_sk_type(sk));
}
pub inline fn sk_ASN1_UTF8STRING_delete(sk: anytype, i: anytype) [*c]ASN1_UTF8STRING {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]ASN1_UTF8STRING, OPENSSL_sk_delete(ossl_check_ASN1_UTF8STRING_sk_type(sk), i));
}
pub inline fn sk_ASN1_UTF8STRING_delete_ptr(sk: anytype, ptr: anytype) [*c]ASN1_UTF8STRING {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_UTF8STRING, OPENSSL_sk_delete_ptr(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr)));
}
pub inline fn sk_ASN1_UTF8STRING_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr));
}
pub inline fn sk_ASN1_UTF8STRING_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr));
}
pub inline fn sk_ASN1_UTF8STRING_pop(sk: anytype) [*c]ASN1_UTF8STRING {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_UTF8STRING, OPENSSL_sk_pop(ossl_check_ASN1_UTF8STRING_sk_type(sk)));
}
pub inline fn sk_ASN1_UTF8STRING_shift(sk: anytype) [*c]ASN1_UTF8STRING {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_UTF8STRING, OPENSSL_sk_shift(ossl_check_ASN1_UTF8STRING_sk_type(sk)));
}
pub inline fn sk_ASN1_UTF8STRING_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_freefunc_type(freefunc));
}
pub inline fn sk_ASN1_UTF8STRING_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr), idx);
}
pub inline fn sk_ASN1_UTF8STRING_set(sk: anytype, idx: anytype, ptr: anytype) [*c]ASN1_UTF8STRING {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_UTF8STRING, OPENSSL_sk_set(ossl_check_ASN1_UTF8STRING_sk_type(sk), idx, ossl_check_ASN1_UTF8STRING_type(ptr)));
}
pub inline fn sk_ASN1_UTF8STRING_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr));
}
pub inline fn sk_ASN1_UTF8STRING_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr));
}
pub inline fn sk_ASN1_UTF8STRING_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_type(ptr), pnum);
}
pub inline fn sk_ASN1_UTF8STRING_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_ASN1_UTF8STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_ASN1_UTF8STRING_sk_type(sk));
}
pub inline fn sk_ASN1_UTF8STRING_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_ASN1_UTF8STRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_ASN1_UTF8STRING_sk_type(sk));
}
pub const sk_ASN1_UTF8STRING_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:782:9
pub const sk_ASN1_UTF8STRING_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:783:9
pub inline fn sk_ASN1_UTF8STRING_set_cmp_func(sk: anytype, cmp: anytype) sk_ASN1_UTF8STRING_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_ASN1_UTF8STRING_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_ASN1_UTF8STRING_sk_type(sk), ossl_check_ASN1_UTF8STRING_compfunc_type(cmp)));
}
pub inline fn sk_ASN1_GENERALSTRING_num(sk: anytype) @TypeOf(OPENSSL_sk_num(ossl_check_const_ASN1_GENERALSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_num(ossl_check_const_ASN1_GENERALSTRING_sk_type(sk));
}
pub inline fn sk_ASN1_GENERALSTRING_value(sk: anytype, idx: anytype) [*c]ASN1_GENERALSTRING {
    _ = &sk;
    _ = &idx;
    return @import("std").zig.c_translation.cast([*c]ASN1_GENERALSTRING, OPENSSL_sk_value(ossl_check_const_ASN1_GENERALSTRING_sk_type(sk), idx));
}
pub const sk_ASN1_GENERALSTRING_new = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:799:9
pub const sk_ASN1_GENERALSTRING_new_null = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:800:9
pub const sk_ASN1_GENERALSTRING_new_reserve = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:801:9
pub inline fn sk_ASN1_GENERALSTRING_reserve(sk: anytype, n: anytype) @TypeOf(OPENSSL_sk_reserve(ossl_check_ASN1_GENERALSTRING_sk_type(sk), n)) {
    _ = &sk;
    _ = &n;
    return OPENSSL_sk_reserve(ossl_check_ASN1_GENERALSTRING_sk_type(sk), n);
}
pub inline fn sk_ASN1_GENERALSTRING_free(sk: anytype) @TypeOf(OPENSSL_sk_free(ossl_check_ASN1_GENERALSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_free(ossl_check_ASN1_GENERALSTRING_sk_type(sk));
}
pub inline fn sk_ASN1_GENERALSTRING_zero(sk: anytype) @TypeOf(OPENSSL_sk_zero(ossl_check_ASN1_GENERALSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_zero(ossl_check_ASN1_GENERALSTRING_sk_type(sk));
}
pub inline fn sk_ASN1_GENERALSTRING_delete(sk: anytype, i: anytype) [*c]ASN1_GENERALSTRING {
    _ = &sk;
    _ = &i;
    return @import("std").zig.c_translation.cast([*c]ASN1_GENERALSTRING, OPENSSL_sk_delete(ossl_check_ASN1_GENERALSTRING_sk_type(sk), i));
}
pub inline fn sk_ASN1_GENERALSTRING_delete_ptr(sk: anytype, ptr: anytype) [*c]ASN1_GENERALSTRING {
    _ = &sk;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_GENERALSTRING, OPENSSL_sk_delete_ptr(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr)));
}
pub inline fn sk_ASN1_GENERALSTRING_push(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_push(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_push(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr));
}
pub inline fn sk_ASN1_GENERALSTRING_unshift(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_unshift(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_unshift(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr));
}
pub inline fn sk_ASN1_GENERALSTRING_pop(sk: anytype) [*c]ASN1_GENERALSTRING {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_GENERALSTRING, OPENSSL_sk_pop(ossl_check_ASN1_GENERALSTRING_sk_type(sk)));
}
pub inline fn sk_ASN1_GENERALSTRING_shift(sk: anytype) [*c]ASN1_GENERALSTRING {
    _ = &sk;
    return @import("std").zig.c_translation.cast([*c]ASN1_GENERALSTRING, OPENSSL_sk_shift(ossl_check_ASN1_GENERALSTRING_sk_type(sk)));
}
pub inline fn sk_ASN1_GENERALSTRING_pop_free(sk: anytype, freefunc: anytype) @TypeOf(OPENSSL_sk_pop_free(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_freefunc_type(freefunc))) {
    _ = &sk;
    _ = &freefunc;
    return OPENSSL_sk_pop_free(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_freefunc_type(freefunc));
}
pub inline fn sk_ASN1_GENERALSTRING_insert(sk: anytype, ptr: anytype, idx: anytype) @TypeOf(OPENSSL_sk_insert(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr), idx)) {
    _ = &sk;
    _ = &ptr;
    _ = &idx;
    return OPENSSL_sk_insert(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr), idx);
}
pub inline fn sk_ASN1_GENERALSTRING_set(sk: anytype, idx: anytype, ptr: anytype) [*c]ASN1_GENERALSTRING {
    _ = &sk;
    _ = &idx;
    _ = &ptr;
    return @import("std").zig.c_translation.cast([*c]ASN1_GENERALSTRING, OPENSSL_sk_set(ossl_check_ASN1_GENERALSTRING_sk_type(sk), idx, ossl_check_ASN1_GENERALSTRING_type(ptr)));
}
pub inline fn sk_ASN1_GENERALSTRING_find(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr));
}
pub inline fn sk_ASN1_GENERALSTRING_find_ex(sk: anytype, ptr: anytype) @TypeOf(OPENSSL_sk_find_ex(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr))) {
    _ = &sk;
    _ = &ptr;
    return OPENSSL_sk_find_ex(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr));
}
pub inline fn sk_ASN1_GENERALSTRING_find_all(sk: anytype, ptr: anytype, pnum: anytype) @TypeOf(OPENSSL_sk_find_all(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr), pnum)) {
    _ = &sk;
    _ = &ptr;
    _ = &pnum;
    return OPENSSL_sk_find_all(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_type(ptr), pnum);
}
pub inline fn sk_ASN1_GENERALSTRING_sort(sk: anytype) @TypeOf(OPENSSL_sk_sort(ossl_check_ASN1_GENERALSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_sort(ossl_check_ASN1_GENERALSTRING_sk_type(sk));
}
pub inline fn sk_ASN1_GENERALSTRING_is_sorted(sk: anytype) @TypeOf(OPENSSL_sk_is_sorted(ossl_check_const_ASN1_GENERALSTRING_sk_type(sk))) {
    _ = &sk;
    return OPENSSL_sk_is_sorted(ossl_check_const_ASN1_GENERALSTRING_sk_type(sk));
}
pub const sk_ASN1_GENERALSTRING_dup = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:819:9
pub const sk_ASN1_GENERALSTRING_deep_copy = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:820:9
pub inline fn sk_ASN1_GENERALSTRING_set_cmp_func(sk: anytype, cmp: anytype) sk_ASN1_GENERALSTRING_compfunc {
    _ = &sk;
    _ = &cmp;
    return @import("std").zig.c_translation.cast(sk_ASN1_GENERALSTRING_compfunc, OPENSSL_sk_set_cmp_func(ossl_check_ASN1_GENERALSTRING_sk_type(sk), ossl_check_ASN1_GENERALSTRING_compfunc_type(cmp)));
}
pub const ASN1_dup_of = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:906:10
pub const M_ASN1_new_of = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:924:10
pub inline fn M_ASN1_free_of(x: anytype, @"type": anytype) @TypeOf(ASN1_item_free(CHECKED_PTR_OF(@"type", x), ASN1_ITEM_rptr(@"type"))) {
    _ = &x;
    _ = &@"type";
    return ASN1_item_free(CHECKED_PTR_OF(@"type", x), ASN1_ITEM_rptr(@"type"));
}
pub const ASN1_d2i_fp_of = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:931:11
pub const ASN1_i2d_fp_of = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/asn1.h:942:11
pub const ASN1_d2i_bio_of = @compileError("unable to translate C expr: unexpected token ')'");
// /usr/include/openssl/asn1.h:955:11
pub const ASN1_i2d_bio_of = @compileError("unable to translate C expr: unexpected token 'const'");
// /usr/include/openssl/asn1.h:966:11
pub const ASN1_PCTX_FLAGS_SHOW_ABSENT = @as(c_int, 0x001);
pub const ASN1_PCTX_FLAGS_SHOW_SEQUENCE = @as(c_int, 0x002);
pub const ASN1_PCTX_FLAGS_SHOW_SSOF = @as(c_int, 0x004);
pub const ASN1_PCTX_FLAGS_SHOW_TYPE = @as(c_int, 0x008);
pub const ASN1_PCTX_FLAGS_NO_ANY_TYPE = @as(c_int, 0x010);
pub const ASN1_PCTX_FLAGS_NO_MSTRING_TYPE = @as(c_int, 0x020);
pub const ASN1_PCTX_FLAGS_NO_FIELD_NAME = @as(c_int, 0x040);
pub const ASN1_PCTX_FLAGS_SHOW_FIELD_STRUCT_NAME = @as(c_int, 0x080);
pub const ASN1_PCTX_FLAGS_NO_STRUCT_NAME = @as(c_int, 0x100);
pub inline fn DECLARE_ASN1_FUNCTIONS_fname(@"type": anytype, itname: anytype, name: anytype) @TypeOf(DECLARE_ASN1_ALLOC_FUNCTIONS_name(@"type", name) ++ DECLARE_ASN1_ENCODE_FUNCTIONS(@"type", itname, name)) {
    _ = &@"type";
    _ = &itname;
    _ = &name;
    return DECLARE_ASN1_ALLOC_FUNCTIONS_name(@"type", name) ++ DECLARE_ASN1_ENCODE_FUNCTIONS(@"type", itname, name);
}
pub inline fn DECLARE_ASN1_FUNCTIONS_const(@"type": anytype) @TypeOf(DECLARE_ASN1_FUNCTIONS(@"type")) {
    _ = &@"type";
    return DECLARE_ASN1_FUNCTIONS(@"type");
}
pub inline fn DECLARE_ASN1_ENCODE_FUNCTIONS_const(@"type": anytype, name: anytype) @TypeOf(DECLARE_ASN1_ENCODE_FUNCTIONS(@"type", name)) {
    _ = &@"type";
    _ = &name;
    return DECLARE_ASN1_ENCODE_FUNCTIONS(@"type", name);
}
pub inline fn I2D_OF_const(@"type": anytype) @TypeOf(I2D_OF(@"type")) {
    _ = &@"type";
    return I2D_OF(@"type");
}
pub inline fn ASN1_dup_of_const(@"type": anytype, i2d: anytype, d2i: anytype, x: anytype) @TypeOf(ASN1_dup_of(@"type", i2d, d2i, x)) {
    _ = &@"type";
    _ = &i2d;
    _ = &d2i;
    _ = &x;
    return ASN1_dup_of(@"type", i2d, d2i, x);
}
pub inline fn ASN1_i2d_fp_of_const(@"type": anytype, i2d: anytype, out: anytype, x: anytype) @TypeOf(ASN1_i2d_fp_of(@"type", i2d, out, x)) {
    _ = &@"type";
    _ = &i2d;
    _ = &out;
    _ = &x;
    return ASN1_i2d_fp_of(@"type", i2d, out, x);
}
pub inline fn ASN1_i2d_bio_of_const(@"type": anytype, i2d: anytype, out: anytype, x: anytype) @TypeOf(ASN1_i2d_bio_of(@"type", i2d, out, x)) {
    _ = &@"type";
    _ = &i2d;
    _ = &out;
    _ = &x;
    return ASN1_i2d_bio_of(@"type", i2d, out, x);
}
pub const OPENSSL_OBJECTSERR_H = "";
pub const OBJ_R_OID_EXISTS = @as(c_int, 102);
pub const OBJ_R_UNKNOWN_NID = @as(c_int, 101);
pub const OBJ_R_UNKNOWN_OBJECT_NAME = @as(c_int, 103);
pub const OBJ_NAME_TYPE_UNDEF = @as(c_int, 0x00);
pub const OBJ_NAME_TYPE_MD_METH = @as(c_int, 0x01);
pub const OBJ_NAME_TYPE_CIPHER_METH = @as(c_int, 0x02);
pub const OBJ_NAME_TYPE_PKEY_METH = @as(c_int, 0x03);
pub const OBJ_NAME_TYPE_COMP_METH = @as(c_int, 0x04);
pub const OBJ_NAME_TYPE_MAC_METH = @as(c_int, 0x05);
pub const OBJ_NAME_TYPE_KDF_METH = @as(c_int, 0x06);
pub const OBJ_NAME_TYPE_NUM = @as(c_int, 0x07);
pub const OBJ_NAME_ALIAS = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000, .hex);
pub const OBJ_BSEARCH_VALUE_ON_NOMATCH = @as(c_int, 0x01);
pub const OBJ_BSEARCH_FIRST_VALUE_ON_MATCH = @as(c_int, 0x02);
pub inline fn OBJ_create_and_add_object(a: anytype, b: anytype, c: anytype) @TypeOf(OBJ_create(a, b, c)) {
    _ = &a;
    _ = &b;
    _ = &c;
    return OBJ_create(a, b, c);
}
pub const _DECLARE_OBJ_BSEARCH_CMP_FN = @compileError("unable to translate macro: undefined identifier `_cmp_BSEARCH_CMP_FN`");
// /usr/include/openssl/objects.h:84:10
pub const DECLARE_OBJ_BSEARCH_CMP_FN = @compileError("unable to translate C expr: unexpected token 'static'");
// /usr/include/openssl/objects.h:89:10
pub const DECLARE_OBJ_BSEARCH_GLOBAL_CMP_FN = @compileError("unable to translate macro: undefined identifier `key`");
// /usr/include/openssl/objects.h:91:10
pub const IMPLEMENT_OBJ_BSEARCH_CMP_FN = @compileError("unable to translate macro: undefined identifier `_cmp_BSEARCH_CMP_FN`");
// /usr/include/openssl/objects.h:121:10
pub const IMPLEMENT_OBJ_BSEARCH_GLOBAL_CMP_FN = @compileError("unable to translate macro: undefined identifier `_cmp_BSEARCH_CMP_FN`");
// /usr/include/openssl/objects.h:135:10
pub const OBJ_bsearch = @compileError("unable to translate macro: undefined identifier `_type_1`");
// /usr/include/openssl/objects.h:149:10
pub const OBJ_bsearch_ex = @compileError("unable to translate macro: undefined identifier `_type_1`");
// /usr/include/openssl/objects.h:156:10
pub const OBJ_cleanup = @compileError("unable to translate C expr: unexpected token 'while'");
// /usr/include/openssl/objects.h:167:10
pub const EVP_PK_RSA = @as(c_int, 0x0001);
pub const EVP_PK_DSA = @as(c_int, 0x0002);
pub const EVP_PK_DH = @as(c_int, 0x0004);
pub const EVP_PK_EC = @as(c_int, 0x0008);
pub const EVP_PKT_SIGN = @as(c_int, 0x0010);
pub const EVP_PKT_ENC = @as(c_int, 0x0020);
pub const EVP_PKT_EXCH = @as(c_int, 0x0040);
pub const EVP_PKS_RSA = @as(c_int, 0x0100);
pub const EVP_PKS_DSA = @as(c_int, 0x0200);
pub const EVP_PKS_EC = @as(c_int, 0x0400);
pub const EVP_PKEY_NONE = NID_undef;
pub const EVP_PKEY_RSA = NID_rsaEncryption;
pub const EVP_PKEY_RSA2 = NID_rsa;
pub const EVP_PKEY_RSA_PSS = NID_rsassaPss;
pub const EVP_PKEY_DSA = NID_dsa;
pub const EVP_PKEY_DSA1 = NID_dsa_2;
pub const EVP_PKEY_DSA2 = NID_dsaWithSHA;
pub const EVP_PKEY_DSA3 = NID_dsaWithSHA1;
pub const EVP_PKEY_DSA4 = NID_dsaWithSHA1_2;
pub const EVP_PKEY_DH = NID_dhKeyAgreement;
pub const EVP_PKEY_DHX = NID_dhpublicnumber;
pub const EVP_PKEY_EC = NID_X9_62_id_ecPublicKey;
pub const EVP_PKEY_SM2 = NID_sm2;
pub const EVP_PKEY_HMAC = NID_hmac;
pub const EVP_PKEY_CMAC = NID_cmac;
pub const EVP_PKEY_SCRYPT = NID_id_scrypt;
pub const EVP_PKEY_TLS1_PRF = NID_tls1_prf;
pub const EVP_PKEY_HKDF = NID_hkdf;
pub const EVP_PKEY_POLY1305 = NID_poly1305;
pub const EVP_PKEY_SIPHASH = NID_siphash;
pub const EVP_PKEY_X25519 = NID_X25519;
pub const EVP_PKEY_ED25519 = NID_ED25519;
pub const EVP_PKEY_X448 = NID_X448;
pub const EVP_PKEY_ED448 = NID_ED448;
pub const EVP_PKEY_KEYMGMT = -@as(c_int, 1);
pub const EVP_PKEY_KEY_PARAMETERS = OSSL_KEYMGMT_SELECT_ALL_PARAMETERS;
pub const EVP_PKEY_PRIVATE_KEY = EVP_PKEY_KEY_PARAMETERS | OSSL_KEYMGMT_SELECT_PRIVATE_KEY;
pub const EVP_PKEY_PUBLIC_KEY = EVP_PKEY_KEY_PARAMETERS | OSSL_KEYMGMT_SELECT_PUBLIC_KEY;
pub const EVP_PKEY_KEYPAIR = EVP_PKEY_PUBLIC_KEY | OSSL_KEYMGMT_SELECT_PRIVATE_KEY;
pub const EVP_PKEY_MO_SIGN = @as(c_int, 0x0001);
pub const EVP_PKEY_MO_VERIFY = @as(c_int, 0x0002);
pub const EVP_PKEY_MO_ENCRYPT = @as(c_int, 0x0004);
pub const EVP_PKEY_MO_DECRYPT = @as(c_int, 0x0008);
pub const EVP_MD_FLAG_ONESHOT = @as(c_int, 0x0001);
pub const EVP_MD_FLAG_XOF = @as(c_int, 0x0002);
pub const EVP_MD_FLAG_DIGALGID_MASK = @as(c_int, 0x0018);
pub const EVP_MD_FLAG_DIGALGID_NULL = @as(c_int, 0x0000);
pub const EVP_MD_FLAG_DIGALGID_ABSENT = @as(c_int, 0x0008);
pub const EVP_MD_FLAG_DIGALGID_CUSTOM = @as(c_int, 0x0018);
pub const EVP_MD_FLAG_FIPS = @as(c_int, 0x0400);
pub const EVP_MD_CTRL_DIGALGID = @as(c_int, 0x1);
pub const EVP_MD_CTRL_MICALG = @as(c_int, 0x2);
pub const EVP_MD_CTRL_XOF_LEN = @as(c_int, 0x3);
pub const EVP_MD_CTRL_TLSTREE = @as(c_int, 0x4);
pub const EVP_MD_CTRL_ALG_CTRL = @as(c_int, 0x1000);
pub const EVP_MD_CTX_FLAG_ONESHOT = @as(c_int, 0x0001);
pub const EVP_MD_CTX_FLAG_CLEANED = @as(c_int, 0x0002);
pub const EVP_MD_CTX_FLAG_REUSE = @as(c_int, 0x0004);
pub const EVP_MD_CTX_FLAG_NON_FIPS_ALLOW = @as(c_int, 0x0008);
pub const EVP_MD_CTX_FLAG_PAD_MASK = @as(c_int, 0xF0);
pub const EVP_MD_CTX_FLAG_PAD_PKCS1 = @as(c_int, 0x00);
pub const EVP_MD_CTX_FLAG_PAD_X931 = @as(c_int, 0x10);
pub const EVP_MD_CTX_FLAG_PAD_PSS = @as(c_int, 0x20);
pub const EVP_MD_CTX_FLAG_NO_INIT = @as(c_int, 0x0100);
pub const EVP_MD_CTX_FLAG_FINALISE = @as(c_int, 0x0200);
pub const EVP_CIPH_STREAM_CIPHER = @as(c_int, 0x0);
pub const EVP_CIPH_ECB_MODE = @as(c_int, 0x1);
pub const EVP_CIPH_CBC_MODE = @as(c_int, 0x2);
pub const EVP_CIPH_CFB_MODE = @as(c_int, 0x3);
pub const EVP_CIPH_OFB_MODE = @as(c_int, 0x4);
pub const EVP_CIPH_CTR_MODE = @as(c_int, 0x5);
pub const EVP_CIPH_GCM_MODE = @as(c_int, 0x6);
pub const EVP_CIPH_CCM_MODE = @as(c_int, 0x7);
pub const EVP_CIPH_XTS_MODE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10001, .hex);
pub const EVP_CIPH_WRAP_MODE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10002, .hex);
pub const EVP_CIPH_OCB_MODE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10003, .hex);
pub const EVP_CIPH_SIV_MODE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x10004, .hex);
pub const EVP_CIPH_MODE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0xF0007, .hex);
pub const EVP_CIPH_VARIABLE_LENGTH = @as(c_int, 0x8);
pub const EVP_CIPH_CUSTOM_IV = @as(c_int, 0x10);
pub const EVP_CIPH_ALWAYS_CALL_INIT = @as(c_int, 0x20);
pub const EVP_CIPH_CTRL_INIT = @as(c_int, 0x40);
pub const EVP_CIPH_CUSTOM_KEY_LENGTH = @as(c_int, 0x80);
pub const EVP_CIPH_NO_PADDING = @as(c_int, 0x100);
pub const EVP_CIPH_RAND_KEY = @as(c_int, 0x200);
pub const EVP_CIPH_CUSTOM_COPY = @as(c_int, 0x400);
pub const EVP_CIPH_CUSTOM_IV_LENGTH = @as(c_int, 0x800);
pub const EVP_CIPH_FLAG_DEFAULT_ASN1 = @as(c_int, 0);
pub const EVP_CIPH_FLAG_LENGTH_BITS = @as(c_int, 0x2000);
pub const EVP_CIPH_FLAG_FIPS = @as(c_int, 0);
pub const EVP_CIPH_FLAG_NON_FIPS_ALLOW = @as(c_int, 0);
pub const EVP_CIPH_FLAG_CTS = @as(c_int, 0x4000);
pub const EVP_CIPH_FLAG_CUSTOM_CIPHER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x100000, .hex);
pub const EVP_CIPH_FLAG_AEAD_CIPHER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x200000, .hex);
pub const EVP_CIPH_FLAG_TLS1_1_MULTIBLOCK = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x400000, .hex);
pub const EVP_CIPH_FLAG_PIPELINE = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x800000, .hex);
pub const EVP_CIPH_FLAG_CUSTOM_ASN1 = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x1000000, .hex);
pub const EVP_CIPH_FLAG_CIPHER_WITH_MAC = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x2000000, .hex);
pub const EVP_CIPH_FLAG_GET_WRAP_CIPHER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x4000000, .hex);
pub const EVP_CIPH_FLAG_INVERSE_CIPHER = @import("std").zig.c_translation.promoteIntLiteral(c_int, 0x8000000, .hex);
pub const EVP_CIPHER_CTX_FLAG_WRAP_ALLOW = @as(c_int, 0x1);
pub const EVP_CTRL_INIT = @as(c_int, 0x0);
pub const EVP_CTRL_SET_KEY_LENGTH = @as(c_int, 0x1);
pub const EVP_CTRL_GET_RC2_KEY_BITS = @as(c_int, 0x2);
pub const EVP_CTRL_SET_RC2_KEY_BITS = @as(c_int, 0x3);
pub const EVP_CTRL_GET_RC5_ROUNDS = @as(c_int, 0x4);
pub const EVP_CTRL_SET_RC5_ROUNDS = @as(c_int, 0x5);
pub const EVP_CTRL_RAND_KEY = @as(c_int, 0x6);
pub const EVP_CTRL_PBE_PRF_NID = @as(c_int, 0x7);
pub const EVP_CTRL_COPY = @as(c_int, 0x8);
pub const EVP_CTRL_AEAD_SET_IVLEN = @as(c_int, 0x9);
pub const EVP_CTRL_AEAD_GET_TAG = @as(c_int, 0x10);
pub const EVP_CTRL_AEAD_SET_TAG = @as(c_int, 0x11);
pub const EVP_CTRL_AEAD_SET_IV_FIXED = @as(c_int, 0x12);
pub const EVP_CTRL_GCM_SET_IVLEN = EVP_CTRL_AEAD_SET_IVLEN;
pub const EVP_CTRL_GCM_GET_TAG = EVP_CTRL_AEAD_GET_TAG;
pub const EVP_CTRL_GCM_SET_TAG = EVP_CTRL_AEAD_SET_TAG;
pub const EVP_CTRL_GCM_SET_IV_FIXED = EVP_CTRL_AEAD_SET_IV_FIXED;
pub const EVP_CTRL_GCM_IV_GEN = @as(c_int, 0x13);
pub const EVP_CTRL_CCM_SET_IVLEN = EVP_CTRL_AEAD_SET_IVLEN;
pub const EVP_CTRL_CCM_GET_TAG = EVP_CTRL_AEAD_GET_TAG;
pub const EVP_CTRL_CCM_SET_TAG = EVP_CTRL_AEAD_SET_TAG;
pub const EVP_CTRL_CCM_SET_IV_FIXED = EVP_CTRL_AEAD_SET_IV_FIXED;
pub const EVP_CTRL_CCM_SET_L = @as(c_int, 0x14);
pub const EVP_CTRL_CCM_SET_MSGLEN = @as(c_int, 0x15);
pub const EVP_CTRL_AEAD_TLS1_AAD = @as(c_int, 0x16);
pub const EVP_CTRL_AEAD_SET_MAC_KEY = @as(c_int, 0x17);
pub const EVP_CTRL_GCM_SET_IV_INV = @as(c_int, 0x18);
pub const EVP_CTRL_TLS1_1_MULTIBLOCK_AAD = @as(c_int, 0x19);
pub const EVP_CTRL_TLS1_1_MULTIBLOCK_ENCRYPT = @as(c_int, 0x1a);
pub const EVP_CTRL_TLS1_1_MULTIBLOCK_DECRYPT = @as(c_int, 0x1b);
pub const EVP_CTRL_TLS1_1_MULTIBLOCK_MAX_BUFSIZE = @as(c_int, 0x1c);
pub const EVP_CTRL_SSL3_MASTER_SECRET = @as(c_int, 0x1d);
pub const EVP_CTRL_SET_SBOX = @as(c_int, 0x1e);
pub const EVP_CTRL_SBOX_USED = @as(c_int, 0x1f);
pub const EVP_CTRL_KEY_MESH = @as(c_int, 0x20);
pub const EVP_CTRL_BLOCK_PADDING_MODE = @as(c_int, 0x21);
pub const EVP_CTRL_SET_PIPELINE_OUTPUT_BUFS = @as(c_int, 0x22);
pub const EVP_CTRL_SET_PIPELINE_INPUT_BUFS = @as(c_int, 0x23);
pub const EVP_CTRL_SET_PIPELINE_INPUT_LENS = @as(c_int, 0x24);
pub const EVP_CTRL_GET_IVLEN = @as(c_int, 0x25);
pub const EVP_CTRL_SET_SPEED = @as(c_int, 0x27);
pub const EVP_CTRL_PROCESS_UNPROTECTED = @as(c_int, 0x28);
pub const EVP_CTRL_GET_WRAP_CIPHER = @as(c_int, 0x29);
pub const EVP_CTRL_TLSTREE = @as(c_int, 0x2A);
pub const EVP_PADDING_PKCS7 = @as(c_int, 1);
pub const EVP_PADDING_ISO7816_4 = @as(c_int, 2);
pub const EVP_PADDING_ANSI923 = @as(c_int, 3);
pub const EVP_PADDING_ISO10126 = @as(c_int, 4);
pub const EVP_PADDING_ZERO = @as(c_int, 5);
pub const EVP_AEAD_TLS1_AAD_LEN = @as(c_int, 13);
pub const EVP_GCM_TLS_FIXED_IV_LEN = @as(c_int, 4);
pub const EVP_GCM_TLS_EXPLICIT_IV_LEN = @as(c_int, 8);
pub const EVP_GCM_TLS_TAG_LEN = @as(c_int, 16);
pub const EVP_CCM_TLS_FIXED_IV_LEN = @as(c_int, 4);
pub const EVP_CCM_TLS_EXPLICIT_IV_LEN = @as(c_int, 8);
pub const EVP_CCM_TLS_IV_LEN = @as(c_int, 12);
pub const EVP_CCM_TLS_TAG_LEN = @as(c_int, 16);
pub const EVP_CCM8_TLS_TAG_LEN = @as(c_int, 8);
pub const EVP_CHACHAPOLY_TLS_TAG_LEN = @as(c_int, 16);
pub inline fn EVP_PKEY_assign_RSA(pkey: anytype, rsa: anytype) @TypeOf(EVP_PKEY_assign(pkey, EVP_PKEY_RSA, rsa)) {
    _ = &pkey;
    _ = &rsa;
    return EVP_PKEY_assign(pkey, EVP_PKEY_RSA, rsa);
}
pub inline fn EVP_PKEY_assign_DSA(pkey: anytype, dsa: anytype) @TypeOf(EVP_PKEY_assign(pkey, EVP_PKEY_DSA, dsa)) {
    _ = &pkey;
    _ = &dsa;
    return EVP_PKEY_assign(pkey, EVP_PKEY_DSA, dsa);
}
pub inline fn EVP_PKEY_assign_DH(pkey: anytype, dh: anytype) @TypeOf(EVP_PKEY_assign(pkey, EVP_PKEY_DH, dh)) {
    _ = &pkey;
    _ = &dh;
    return EVP_PKEY_assign(pkey, EVP_PKEY_DH, dh);
}
pub inline fn EVP_PKEY_assign_EC_KEY(pkey: anytype, eckey: anytype) @TypeOf(EVP_PKEY_assign(pkey, EVP_PKEY_EC, eckey)) {
    _ = &pkey;
    _ = &eckey;
    return EVP_PKEY_assign(pkey, EVP_PKEY_EC, eckey);
}
pub inline fn EVP_PKEY_assign_SIPHASH(pkey: anytype, shkey: anytype) @TypeOf(EVP_PKEY_assign(pkey, EVP_PKEY_SIPHASH, shkey)) {
    _ = &pkey;
    _ = &shkey;
    return EVP_PKEY_assign(pkey, EVP_PKEY_SIPHASH, shkey);
}
pub inline fn EVP_PKEY_assign_POLY1305(pkey: anytype, polykey: anytype) @TypeOf(EVP_PKEY_assign(pkey, EVP_PKEY_POLY1305, polykey)) {
    _ = &pkey;
    _ = &polykey;
    return EVP_PKEY_assign(pkey, EVP_PKEY_POLY1305, polykey);
}
pub inline fn EVP_get_digestbynid(a: anytype) @TypeOf(EVP_get_digestbyname(OBJ_nid2sn(a))) {
    _ = &a;
    return EVP_get_digestbyname(OBJ_nid2sn(a));
}
pub inline fn EVP_get_digestbyobj(a: anytype) @TypeOf(EVP_get_digestbynid(OBJ_obj2nid(a))) {
    _ = &a;
    return EVP_get_digestbynid(OBJ_obj2nid(a));
}
pub inline fn EVP_get_cipherbynid(a: anytype) @TypeOf(EVP_get_cipherbyname(OBJ_nid2sn(a))) {
    _ = &a;
    return EVP_get_cipherbyname(OBJ_nid2sn(a));
}
pub inline fn EVP_get_cipherbyobj(a: anytype) @TypeOf(EVP_get_cipherbynid(OBJ_obj2nid(a))) {
    _ = &a;
    return EVP_get_cipherbynid(OBJ_obj2nid(a));
}
pub const EVP_MD_type = EVP_MD_get_type;
pub const EVP_MD_nid = EVP_MD_get_type;
pub const EVP_MD_name = EVP_MD_get0_name;
pub const EVP_MD_pkey_type = EVP_MD_get_pkey_type;
pub const EVP_MD_size = EVP_MD_get_size;
pub const EVP_MD_block_size = EVP_MD_get_block_size;
pub const EVP_MD_flags = EVP_MD_get_flags;
pub inline fn EVP_MD_CTX_get0_name(e: anytype) @TypeOf(EVP_MD_get0_name(EVP_MD_CTX_get0_md(e))) {
    _ = &e;
    return EVP_MD_get0_name(EVP_MD_CTX_get0_md(e));
}
pub inline fn EVP_MD_CTX_get_size(e: anytype) @TypeOf(EVP_MD_get_size(EVP_MD_CTX_get0_md(e))) {
    _ = &e;
    return EVP_MD_get_size(EVP_MD_CTX_get0_md(e));
}
pub const EVP_MD_CTX_size = EVP_MD_CTX_get_size;
pub inline fn EVP_MD_CTX_get_block_size(e: anytype) @TypeOf(EVP_MD_get_block_size(EVP_MD_CTX_get0_md(e))) {
    _ = &e;
    return EVP_MD_get_block_size(EVP_MD_CTX_get0_md(e));
}
pub const EVP_MD_CTX_block_size = EVP_MD_CTX_get_block_size;
pub inline fn EVP_MD_CTX_get_type(e: anytype) @TypeOf(EVP_MD_get_type(EVP_MD_CTX_get0_md(e))) {
    _ = &e;
    return EVP_MD_get_type(EVP_MD_CTX_get0_md(e));
}
pub const EVP_MD_CTX_type = EVP_MD_CTX_get_type;
pub const EVP_MD_CTX_pkey_ctx = EVP_MD_CTX_get_pkey_ctx;
pub const EVP_MD_CTX_md_data = EVP_MD_CTX_get0_md_data;
pub const EVP_CIPHER_nid = EVP_CIPHER_get_nid;
pub const EVP_CIPHER_name = EVP_CIPHER_get0_name;
pub const EVP_CIPHER_block_size = EVP_CIPHER_get_block_size;
pub const EVP_CIPHER_key_length = EVP_CIPHER_get_key_length;
pub const EVP_CIPHER_iv_length = EVP_CIPHER_get_iv_length;
pub const EVP_CIPHER_flags = EVP_CIPHER_get_flags;
pub const EVP_CIPHER_mode = EVP_CIPHER_get_mode;
pub const EVP_CIPHER_type = EVP_CIPHER_get_type;
pub const EVP_CIPHER_CTX_encrypting = EVP_CIPHER_CTX_is_encrypting;
pub const EVP_CIPHER_CTX_nid = EVP_CIPHER_CTX_get_nid;
pub const EVP_CIPHER_CTX_block_size = EVP_CIPHER_CTX_get_block_size;
pub const EVP_CIPHER_CTX_key_length = EVP_CIPHER_CTX_get_key_length;
pub const EVP_CIPHER_CTX_iv_length = EVP_CIPHER_CTX_get_iv_length;
pub const EVP_CIPHER_CTX_tag_length = EVP_CIPHER_CTX_get_tag_length;
pub const EVP_CIPHER_CTX_num = EVP_CIPHER_CTX_get_num;
pub inline fn EVP_CIPHER_CTX_get0_name(c: anytype) @TypeOf(EVP_CIPHER_get0_name(EVP_CIPHER_CTX_get0_cipher(c))) {
    _ = &c;
    return EVP_CIPHER_get0_name(EVP_CIPHER_CTX_get0_cipher(c));
}
pub inline fn EVP_CIPHER_CTX_get_type(c: anytype) @TypeOf(EVP_CIPHER_get_type(EVP_CIPHER_CTX_get0_cipher(c))) {
    _ = &c;
    return EVP_CIPHER_get_type(EVP_CIPHER_CTX_get0_cipher(c));
}
pub const EVP_CIPHER_CTX_type = EVP_CIPHER_CTX_get_type;
pub inline fn EVP_CIPHER_CTX_flags(c: anytype) @TypeOf(EVP_CIPHER_get_flags(EVP_CIPHER_CTX_get0_cipher(c))) {
    _ = &c;
    return EVP_CIPHER_get_flags(EVP_CIPHER_CTX_get0_cipher(c));
}
pub inline fn EVP_CIPHER_CTX_get_mode(c: anytype) @TypeOf(EVP_CIPHER_get_mode(EVP_CIPHER_CTX_get0_cipher(c))) {
    _ = &c;
    return EVP_CIPHER_get_mode(EVP_CIPHER_CTX_get0_cipher(c));
}
pub const EVP_CIPHER_CTX_mode = EVP_CIPHER_CTX_get_mode;
pub inline fn EVP_ENCODE_LENGTH(l: anytype) @TypeOf(((@import("std").zig.c_translation.MacroArithmetic.div(l + @as(c_int, 2), @as(c_int, 3)) * @as(c_int, 4)) + ((@import("std").zig.c_translation.MacroArithmetic.div(l, @as(c_int, 48)) + @as(c_int, 1)) * @as(c_int, 2))) + @as(c_int, 80)) {
    _ = &l;
    return ((@import("std").zig.c_translation.MacroArithmetic.div(l + @as(c_int, 2), @as(c_int, 3)) * @as(c_int, 4)) + ((@import("std").zig.c_translation.MacroArithmetic.div(l, @as(c_int, 48)) + @as(c_int, 1)) * @as(c_int, 2))) + @as(c_int, 80);
}
pub inline fn EVP_DECODE_LENGTH(l: anytype) @TypeOf((@import("std").zig.c_translation.MacroArithmetic.div(l + @as(c_int, 3), @as(c_int, 4)) * @as(c_int, 3)) + @as(c_int, 80)) {
    _ = &l;
    return (@import("std").zig.c_translation.MacroArithmetic.div(l + @as(c_int, 3), @as(c_int, 4)) * @as(c_int, 3)) + @as(c_int, 80);
}
pub inline fn EVP_SignInit_ex(a: anytype, b: anytype, c: anytype) @TypeOf(EVP_DigestInit_ex(a, b, c)) {
    _ = &a;
    _ = &b;
    _ = &c;
    return EVP_DigestInit_ex(a, b, c);
}
pub inline fn EVP_SignInit(a: anytype, b: anytype) @TypeOf(EVP_DigestInit(a, b)) {
    _ = &a;
    _ = &b;
    return EVP_DigestInit(a, b);
}
pub inline fn EVP_SignUpdate(a: anytype, b: anytype, c: anytype) @TypeOf(EVP_DigestUpdate(a, b, c)) {
    _ = &a;
    _ = &b;
    _ = &c;
    return EVP_DigestUpdate(a, b, c);
}
pub inline fn EVP_VerifyInit_ex(a: anytype, b: anytype, c: anytype) @TypeOf(EVP_DigestInit_ex(a, b, c)) {
    _ = &a;
    _ = &b;
    _ = &c;
    return EVP_DigestInit_ex(a, b, c);
}
pub inline fn EVP_VerifyInit(a: anytype, b: anytype) @TypeOf(EVP_DigestInit(a, b)) {
    _ = &a;
    _ = &b;
    return EVP_DigestInit(a, b);
}
pub inline fn EVP_VerifyUpdate(a: anytype, b: anytype, c: anytype) @TypeOf(EVP_DigestUpdate(a, b, c)) {
    _ = &a;
    _ = &b;
    _ = &c;
    return EVP_DigestUpdate(a, b, c);
}
pub inline fn EVP_OpenUpdate(a: anytype, b: anytype, c: anytype, d: anytype, e: anytype) @TypeOf(EVP_DecryptUpdate(a, b, c, d, e)) {
    _ = &a;
    _ = &b;
    _ = &c;
    _ = &d;
    _ = &e;
    return EVP_DecryptUpdate(a, b, c, d, e);
}
pub inline fn EVP_SealUpdate(a: anytype, b: anytype, c: anytype, d: anytype, e: anytype) @TypeOf(EVP_EncryptUpdate(a, b, c, d, e)) {
    _ = &a;
    _ = &b;
    _ = &c;
    _ = &d;
    _ = &e;
    return EVP_EncryptUpdate(a, b, c, d, e);
}
pub inline fn BIO_set_md(b: anytype, md: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_MD, @as(c_int, 0), @import("std").zig.c_translation.cast(?*anyopaque, md))) {
    _ = &b;
    _ = &md;
    return BIO_ctrl(b, BIO_C_SET_MD, @as(c_int, 0), @import("std").zig.c_translation.cast(?*anyopaque, md));
}
pub inline fn BIO_get_md(b: anytype, mdp: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_MD, @as(c_int, 0), mdp)) {
    _ = &b;
    _ = &mdp;
    return BIO_ctrl(b, BIO_C_GET_MD, @as(c_int, 0), mdp);
}
pub inline fn BIO_get_md_ctx(b: anytype, mdcp: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_MD_CTX, @as(c_int, 0), mdcp)) {
    _ = &b;
    _ = &mdcp;
    return BIO_ctrl(b, BIO_C_GET_MD_CTX, @as(c_int, 0), mdcp);
}
pub inline fn BIO_set_md_ctx(b: anytype, mdcp: anytype) @TypeOf(BIO_ctrl(b, BIO_C_SET_MD_CTX, @as(c_int, 0), mdcp)) {
    _ = &b;
    _ = &mdcp;
    return BIO_ctrl(b, BIO_C_SET_MD_CTX, @as(c_int, 0), mdcp);
}
pub inline fn BIO_get_cipher_status(b: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_CIPHER_STATUS, @as(c_int, 0), NULL)) {
    _ = &b;
    return BIO_ctrl(b, BIO_C_GET_CIPHER_STATUS, @as(c_int, 0), NULL);
}
pub inline fn BIO_get_cipher_ctx(b: anytype, c_pp: anytype) @TypeOf(BIO_ctrl(b, BIO_C_GET_CIPHER_CTX, @as(c_int, 0), c_pp)) {
    _ = &b;
    _ = &c_pp;
    return BIO_ctrl(b, BIO_C_GET_CIPHER_CTX, @as(c_int, 0), c_pp);
}
pub inline fn EVP_add_cipher_alias(n: anytype, alias: anytype) @TypeOf(OBJ_NAME_add(alias, OBJ_NAME_TYPE_CIPHER_METH | OBJ_NAME_ALIAS, n)) {
    _ = &n;
    _ = &alias;
    return OBJ_NAME_add(alias, OBJ_NAME_TYPE_CIPHER_METH | OBJ_NAME_ALIAS, n);
}
pub inline fn EVP_add_digest_alias(n: anytype, alias: anytype) @TypeOf(OBJ_NAME_add(alias, OBJ_NAME_TYPE_MD_METH | OBJ_NAME_ALIAS, n)) {
    _ = &n;
    _ = &alias;
    return OBJ_NAME_add(alias, OBJ_NAME_TYPE_MD_METH | OBJ_NAME_ALIAS, n);
}
pub const EVP_delete_cipher_alias = @compileError("unable to translate C expr: unexpected token ';'");
// /usr/include/openssl/evp.h:684:10
pub const EVP_delete_digest_alias = @compileError("unable to translate C expr: unexpected token ';'");
// /usr/include/openssl/evp.h:686:10
pub inline fn EVP_MD_CTX_create() @TypeOf(EVP_MD_CTX_new()) {
    return EVP_MD_CTX_new();
}
pub inline fn EVP_MD_CTX_init(ctx: anytype) @TypeOf(EVP_MD_CTX_reset(ctx)) {
    _ = &ctx;
    return EVP_MD_CTX_reset(ctx);
}
pub inline fn EVP_MD_CTX_destroy(ctx: anytype) @TypeOf(EVP_MD_CTX_free(ctx)) {
    _ = &ctx;
    return EVP_MD_CTX_free(ctx);
}
pub inline fn EVP_CIPHER_CTX_init(c: anytype) @TypeOf(EVP_CIPHER_CTX_reset(c)) {
    _ = &c;
    return EVP_CIPHER_CTX_reset(c);
}
pub inline fn EVP_CIPHER_CTX_cleanup(c: anytype) @TypeOf(EVP_CIPHER_CTX_reset(c)) {
    _ = &c;
    return EVP_CIPHER_CTX_reset(c);
}
pub const EVP_des_cfb = EVP_des_cfb64;
pub const EVP_des_ede_cfb = EVP_des_ede_cfb64;
pub const EVP_des_ede3_cfb = EVP_des_ede3_cfb64;
pub const EVP_rc2_cfb = EVP_rc2_cfb64;
pub const EVP_bf_cfb = EVP_bf_cfb64;
pub const EVP_cast5_cfb = EVP_cast5_cfb64;
pub const EVP_aes_128_cfb = EVP_aes_128_cfb128;
pub const EVP_aes_192_cfb = EVP_aes_192_cfb128;
pub const EVP_aes_256_cfb = EVP_aes_256_cfb128;
pub const EVP_aria_128_cfb = EVP_aria_128_cfb128;
pub const EVP_aria_192_cfb = EVP_aria_192_cfb128;
pub const EVP_aria_256_cfb = EVP_aria_256_cfb128;
pub const EVP_camellia_128_cfb = EVP_camellia_128_cfb128;
pub const EVP_camellia_192_cfb = EVP_camellia_192_cfb128;
pub const EVP_camellia_256_cfb = EVP_camellia_256_cfb128;
pub const EVP_seed_cfb = EVP_seed_cfb128;
pub const EVP_sm4_cfb = EVP_sm4_cfb128;
pub inline fn OPENSSL_add_all_algorithms_conf() @TypeOf(OPENSSL_init_crypto((OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS) | OPENSSL_INIT_LOAD_CONFIG, NULL)) {
    return OPENSSL_init_crypto((OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS) | OPENSSL_INIT_LOAD_CONFIG, NULL);
}
pub inline fn OPENSSL_add_all_algorithms_noconf() @TypeOf(OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS, NULL)) {
    return OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS | OPENSSL_INIT_ADD_ALL_DIGESTS, NULL);
}
pub inline fn OpenSSL_add_all_algorithms() @TypeOf(OPENSSL_add_all_algorithms_noconf()) {
    return OPENSSL_add_all_algorithms_noconf();
}
pub inline fn OpenSSL_add_all_ciphers() @TypeOf(OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS, NULL)) {
    return OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_CIPHERS, NULL);
}
pub inline fn OpenSSL_add_all_digests() @TypeOf(OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_DIGESTS, NULL)) {
    return OPENSSL_init_crypto(OPENSSL_INIT_ADD_ALL_DIGESTS, NULL);
}
pub const EVP_cleanup = @compileError("unable to translate C expr: unexpected token 'while'");
// /usr/include/openssl/evp.h:1167:11
pub const EVP_RAND_STATE_UNINITIALISED = @as(c_int, 0);
pub const EVP_RAND_STATE_READY = @as(c_int, 1);
pub const EVP_RAND_STATE_ERROR = @as(c_int, 2);
pub const EVP_PKEY_id = EVP_PKEY_get_id;
pub const EVP_PKEY_base_id = EVP_PKEY_get_base_id;
pub const EVP_PKEY_bits = EVP_PKEY_get_bits;
pub const EVP_PKEY_security_bits = EVP_PKEY_get_security_bits;
pub const EVP_PKEY_size = EVP_PKEY_get_size;
pub inline fn EVP_PKEY_set1_tls_encodedpoint(pkey: anytype, pt: anytype, ptlen: anytype) @TypeOf(EVP_PKEY_set1_encoded_public_key(pkey, pt, ptlen)) {
    _ = &pkey;
    _ = &pt;
    _ = &ptlen;
    return EVP_PKEY_set1_encoded_public_key(pkey, pt, ptlen);
}
pub inline fn EVP_PKEY_get1_tls_encodedpoint(pkey: anytype, ppt: anytype) @TypeOf(EVP_PKEY_get1_encoded_public_key(pkey, ppt)) {
    _ = &pkey;
    _ = &ppt;
    return EVP_PKEY_get1_encoded_public_key(pkey, ppt);
}
pub const EVP_PBE_TYPE_OUTER = @as(c_int, 0x0);
pub const EVP_PBE_TYPE_PRF = @as(c_int, 0x1);
pub const EVP_PBE_TYPE_KDF = @as(c_int, 0x2);
pub const ASN1_PKEY_ALIAS = @as(c_int, 0x1);
pub const ASN1_PKEY_DYNAMIC = @as(c_int, 0x2);
pub const ASN1_PKEY_SIGPARAM_NULL = @as(c_int, 0x4);
pub const ASN1_PKEY_CTRL_PKCS7_SIGN = @as(c_int, 0x1);
pub const ASN1_PKEY_CTRL_PKCS7_ENCRYPT = @as(c_int, 0x2);
pub const ASN1_PKEY_CTRL_DEFAULT_MD_NID = @as(c_int, 0x3);
pub const ASN1_PKEY_CTRL_CMS_SIGN = @as(c_int, 0x5);
pub const ASN1_PKEY_CTRL_CMS_ENVELOPE = @as(c_int, 0x7);
pub const ASN1_PKEY_CTRL_CMS_RI_TYPE = @as(c_int, 0x8);
pub const ASN1_PKEY_CTRL_SET1_TLS_ENCPT = @as(c_int, 0x9);
pub const ASN1_PKEY_CTRL_GET1_TLS_ENCPT = @as(c_int, 0xa);
pub const ASN1_PKEY_CTRL_CMS_IS_RI_TYPE_SUPPORTED = @as(c_int, 0xb);
pub const EVP_PKEY_OP_UNDEFINED = @as(c_int, 0);
pub const EVP_PKEY_OP_PARAMGEN = @as(c_int, 1) << @as(c_int, 1);
pub const EVP_PKEY_OP_KEYGEN = @as(c_int, 1) << @as(c_int, 2);
pub const EVP_PKEY_OP_FROMDATA = @as(c_int, 1) << @as(c_int, 3);
pub const EVP_PKEY_OP_SIGN = @as(c_int, 1) << @as(c_int, 4);
pub const EVP_PKEY_OP_VERIFY = @as(c_int, 1) << @as(c_int, 5);
pub const EVP_PKEY_OP_VERIFYRECOVER = @as(c_int, 1) << @as(c_int, 6);
pub const EVP_PKEY_OP_SIGNCTX = @as(c_int, 1) << @as(c_int, 7);
pub const EVP_PKEY_OP_VERIFYCTX = @as(c_int, 1) << @as(c_int, 8);
pub const EVP_PKEY_OP_ENCRYPT = @as(c_int, 1) << @as(c_int, 9);
pub const EVP_PKEY_OP_DECRYPT = @as(c_int, 1) << @as(c_int, 10);
pub const EVP_PKEY_OP_DERIVE = @as(c_int, 1) << @as(c_int, 11);
pub const EVP_PKEY_OP_ENCAPSULATE = @as(c_int, 1) << @as(c_int, 12);
pub const EVP_PKEY_OP_DECAPSULATE = @as(c_int, 1) << @as(c_int, 13);
pub const EVP_PKEY_OP_TYPE_SIG = (((EVP_PKEY_OP_SIGN | EVP_PKEY_OP_VERIFY) | EVP_PKEY_OP_VERIFYRECOVER) | EVP_PKEY_OP_SIGNCTX) | EVP_PKEY_OP_VERIFYCTX;
pub const EVP_PKEY_OP_TYPE_CRYPT = EVP_PKEY_OP_ENCRYPT | EVP_PKEY_OP_DECRYPT;
pub const EVP_PKEY_OP_TYPE_NOGEN = (EVP_PKEY_OP_TYPE_SIG | EVP_PKEY_OP_TYPE_CRYPT) | EVP_PKEY_OP_DERIVE;
pub const EVP_PKEY_OP_TYPE_GEN = EVP_PKEY_OP_PARAMGEN | EVP_PKEY_OP_KEYGEN;
pub const EVP_PKEY_CTRL_MD = @as(c_int, 1);
pub const EVP_PKEY_CTRL_PEER_KEY = @as(c_int, 2);
pub const EVP_PKEY_CTRL_SET_MAC_KEY = @as(c_int, 6);
pub const EVP_PKEY_CTRL_DIGESTINIT = @as(c_int, 7);
pub const EVP_PKEY_CTRL_SET_IV = @as(c_int, 8);
pub const EVP_PKEY_CTRL_PKCS7_ENCRYPT = @as(c_int, 3);
pub const EVP_PKEY_CTRL_PKCS7_DECRYPT = @as(c_int, 4);
pub const EVP_PKEY_CTRL_PKCS7_SIGN = @as(c_int, 5);
pub const EVP_PKEY_CTRL_CMS_ENCRYPT = @as(c_int, 9);
pub const EVP_PKEY_CTRL_CMS_DECRYPT = @as(c_int, 10);
pub const EVP_PKEY_CTRL_CMS_SIGN = @as(c_int, 11);
pub const EVP_PKEY_CTRL_CIPHER = @as(c_int, 12);
pub const EVP_PKEY_CTRL_GET_MD = @as(c_int, 13);
pub const EVP_PKEY_CTRL_SET_DIGEST_SIZE = @as(c_int, 14);
pub const EVP_PKEY_CTRL_SET1_ID = @as(c_int, 15);
pub const EVP_PKEY_CTRL_GET1_ID = @as(c_int, 16);
pub const EVP_PKEY_CTRL_GET1_ID_LEN = @as(c_int, 17);
pub const EVP_PKEY_ALG_CTRL = @as(c_int, 0x1000);
pub const EVP_PKEY_FLAG_AUTOARGLEN = @as(c_int, 2);
pub const EVP_PKEY_FLAG_SIGCTX_CUSTOM = @as(c_int, 4);
pub inline fn EVP_PKEY_get_ex_new_index(l: anytype, p: anytype, newf: anytype, dupf: anytype, freef: anytype) @TypeOf(CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_EVP_PKEY, l, p, newf, dupf, freef)) {
    _ = &l;
    _ = &p;
    _ = &newf;
    _ = &dupf;
    _ = &freef;
    return CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_EVP_PKEY, l, p, newf, dupf, freef);
}
pub const SHAstate_st = struct_SHAstate_st;
pub const SHA256state_st = struct_SHA256state_st;
pub const SHA512state_st = struct_SHA512state_st;
pub const _G_fpos_t = struct__G_fpos_t;
pub const _G_fpos64_t = struct__G_fpos64_t;
pub const _IO_marker = struct__IO_marker;
pub const _IO_codecvt = struct__IO_codecvt;
pub const _IO_wide_data = struct__IO_wide_data;
pub const _IO_FILE = struct__IO_FILE;
pub const _IO_cookie_io_functions_t = struct__IO_cookie_io_functions_t;
pub const stack_st = struct_stack_st;
pub const stack_st_OPENSSL_STRING = struct_stack_st_OPENSSL_STRING;
pub const stack_st_OPENSSL_CSTRING = struct_stack_st_OPENSSL_CSTRING;
pub const stack_st_OPENSSL_BLOCK = struct_stack_st_OPENSSL_BLOCK;
pub const ossl_provider_st = struct_ossl_provider_st;
pub const asn1_string_st = struct_asn1_string_st;
pub const asn1_object_st = struct_asn1_object_st;
pub const ASN1_VALUE_st = struct_ASN1_VALUE_st;
pub const asn1_type_st = struct_asn1_type_st;
pub const asn1_string_table_st = struct_asn1_string_table_st;
pub const ASN1_ITEM_st = struct_ASN1_ITEM_st;
pub const asn1_pctx_st = struct_asn1_pctx_st;
pub const asn1_sctx_st = struct_asn1_sctx_st;
pub const bio_st = struct_bio_st;
pub const bignum_st = struct_bignum_st;
pub const bignum_ctx = struct_bignum_ctx;
pub const bn_blinding_st = struct_bn_blinding_st;
pub const bn_mont_ctx_st = struct_bn_mont_ctx_st;
pub const bn_recp_ctx_st = struct_bn_recp_ctx_st;
pub const bn_gencb_st = struct_bn_gencb_st;
pub const buf_mem_st = struct_buf_mem_st;
pub const stack_st_BIGNUM = struct_stack_st_BIGNUM;
pub const stack_st_BIGNUM_const = struct_stack_st_BIGNUM_const;
pub const err_state_st = struct_err_state_st;
pub const evp_cipher_st = struct_evp_cipher_st;
pub const evp_cipher_ctx_st = struct_evp_cipher_ctx_st;
pub const evp_md_st = struct_evp_md_st;
pub const evp_md_ctx_st = struct_evp_md_ctx_st;
pub const evp_mac_st = struct_evp_mac_st;
pub const evp_mac_ctx_st = struct_evp_mac_ctx_st;
pub const evp_pkey_st = struct_evp_pkey_st;
pub const evp_pkey_asn1_method_st = struct_evp_pkey_asn1_method_st;
pub const evp_pkey_method_st = struct_evp_pkey_method_st;
pub const evp_pkey_ctx_st = struct_evp_pkey_ctx_st;
pub const evp_keymgmt_st = struct_evp_keymgmt_st;
pub const evp_kdf_st = struct_evp_kdf_st;
pub const evp_kdf_ctx_st = struct_evp_kdf_ctx_st;
pub const evp_rand_st = struct_evp_rand_st;
pub const evp_rand_ctx_st = struct_evp_rand_ctx_st;
pub const evp_keyexch_st = struct_evp_keyexch_st;
pub const evp_signature_st = struct_evp_signature_st;
pub const evp_asym_cipher_st = struct_evp_asym_cipher_st;
pub const evp_kem_st = struct_evp_kem_st;
pub const evp_Encode_Ctx_st = struct_evp_Encode_Ctx_st;
pub const hmac_ctx_st = struct_hmac_ctx_st;
pub const dh_st = struct_dh_st;
pub const dh_method = struct_dh_method;
pub const dsa_st = struct_dsa_st;
pub const dsa_method = struct_dsa_method;
pub const rsa_st = struct_rsa_st;
pub const rsa_meth_st = struct_rsa_meth_st;
pub const rsa_pss_params_st = struct_rsa_pss_params_st;
pub const ec_key_st = struct_ec_key_st;
pub const ec_key_method_st = struct_ec_key_method_st;
pub const rand_meth_st = struct_rand_meth_st;
pub const rand_drbg_st = struct_rand_drbg_st;
pub const ssl_dane_st = struct_ssl_dane_st;
pub const x509_st = struct_x509_st;
pub const X509_algor_st = struct_X509_algor_st;
pub const X509_crl_st = struct_X509_crl_st;
pub const x509_crl_method_st = struct_x509_crl_method_st;
pub const x509_revoked_st = struct_x509_revoked_st;
pub const X509_name_st = struct_X509_name_st;
pub const X509_pubkey_st = struct_X509_pubkey_st;
pub const x509_store_st = struct_x509_store_st;
pub const x509_store_ctx_st = struct_x509_store_ctx_st;
pub const x509_object_st = struct_x509_object_st;
pub const x509_lookup_st = struct_x509_lookup_st;
pub const x509_lookup_method_st = struct_x509_lookup_method_st;
pub const X509_VERIFY_PARAM_st = struct_X509_VERIFY_PARAM_st;
pub const x509_sig_info_st = struct_x509_sig_info_st;
pub const pkcs8_priv_key_info_st = struct_pkcs8_priv_key_info_st;
pub const v3_ext_ctx = struct_v3_ext_ctx;
pub const conf_st = struct_conf_st;
pub const ossl_init_settings_st = struct_ossl_init_settings_st;
pub const ui_st = struct_ui_st;
pub const ui_method_st = struct_ui_method_st;
pub const engine_st = struct_engine_st;
pub const ssl_st = struct_ssl_st;
pub const ssl_ctx_st = struct_ssl_ctx_st;
pub const comp_ctx_st = struct_comp_ctx_st;
pub const comp_method_st = struct_comp_method_st;
pub const X509_POLICY_NODE_st = struct_X509_POLICY_NODE_st;
pub const X509_POLICY_LEVEL_st = struct_X509_POLICY_LEVEL_st;
pub const X509_POLICY_TREE_st = struct_X509_POLICY_TREE_st;
pub const X509_POLICY_CACHE_st = struct_X509_POLICY_CACHE_st;
pub const AUTHORITY_KEYID_st = struct_AUTHORITY_KEYID_st;
pub const DIST_POINT_st = struct_DIST_POINT_st;
pub const ISSUING_DIST_POINT_st = struct_ISSUING_DIST_POINT_st;
pub const NAME_CONSTRAINTS_st = struct_NAME_CONSTRAINTS_st;
pub const ossl_lib_ctx_st = struct_ossl_lib_ctx_st;
pub const stack_st_void = struct_stack_st_void;
pub const crypto_ex_data_st = struct_crypto_ex_data_st;
pub const ossl_http_req_ctx_st = struct_ossl_http_req_ctx_st;
pub const ocsp_response_st = struct_ocsp_response_st;
pub const ocsp_responder_id_st = struct_ocsp_responder_id_st;
pub const sct_st = struct_sct_st;
pub const sct_ctx_st = struct_sct_ctx_st;
pub const ctlog_st = struct_ctlog_st;
pub const ctlog_store_st = struct_ctlog_store_st;
pub const ct_policy_eval_ctx_st = struct_ct_policy_eval_ctx_st;
pub const ossl_store_info_st = struct_ossl_store_info_st;
pub const ossl_store_search_st = struct_ossl_store_search_st;
pub const ossl_dispatch_st = struct_ossl_dispatch_st;
pub const ossl_item_st = struct_ossl_item_st;
pub const ossl_algorithm_st = struct_ossl_algorithm_st;
pub const ossl_param_st = struct_ossl_param_st;
pub const ossl_param_bld_st = struct_ossl_param_bld_st;
pub const ossl_encoder_st = struct_ossl_encoder_st;
pub const ossl_encoder_ctx_st = struct_ossl_encoder_ctx_st;
pub const ossl_decoder_st = struct_ossl_decoder_st;
pub const ossl_decoder_ctx_st = struct_ossl_decoder_ctx_st;
pub const ossl_self_test_st = struct_ossl_self_test_st;
pub const ossl_core_handle_st = struct_ossl_core_handle_st;
pub const openssl_core_ctx_st = struct_openssl_core_ctx_st;
pub const ossl_core_bio_st = struct_ossl_core_bio_st;
pub const timeval = struct_timeval;
pub const timespec = struct_timespec;
pub const __pthread_internal_list = struct___pthread_internal_list;
pub const __pthread_internal_slist = struct___pthread_internal_slist;
pub const __pthread_mutex_s = struct___pthread_mutex_s;
pub const __pthread_rwlock_arch_t = struct___pthread_rwlock_arch_t;
pub const __pthread_cond_s = struct___pthread_cond_s;
pub const random_data = struct_random_data;
pub const drand48_data = struct_drand48_data;
pub const tm = struct_tm;
pub const itimerspec = struct_itimerspec;
pub const sigevent = struct_sigevent;
pub const __locale_struct = struct___locale_struct;
pub const crypto_threadid_st = struct_crypto_threadid_st;
pub const sched_param = struct_sched_param;
pub const __jmp_buf_tag = struct___jmp_buf_tag;
pub const _pthread_cleanup_buffer = struct__pthread_cleanup_buffer;
pub const __cancel_jmp_buf_tag = struct___cancel_jmp_buf_tag;
pub const __pthread_cleanup_frame = struct___pthread_cleanup_frame;
pub const bio_addr_st = union_bio_addr_st;
pub const bio_addrinfo_st = struct_bio_addrinfo_st;
pub const bio_method_st = struct_bio_method_st;
pub const stack_st_BIO = struct_stack_st_BIO;
pub const BIO_hostserv_priorities = enum_BIO_hostserv_priorities;
pub const BIO_lookup_type = enum_BIO_lookup_type;
pub const hostent = struct_hostent;
pub const BIO_sock_info_u = union_BIO_sock_info_u;
pub const BIO_sock_info_type = enum_BIO_sock_info_type;
pub const stack_st_X509_ALGOR = struct_stack_st_X509_ALGOR;
pub const ASN1_ENCODING_st = struct_ASN1_ENCODING_st;
pub const stack_st_ASN1_STRING_TABLE = struct_stack_st_ASN1_STRING_TABLE;
pub const ASN1_TEMPLATE_st = struct_ASN1_TEMPLATE_st;
pub const ASN1_TLC_st = struct_ASN1_TLC_st;
pub const stack_st_ASN1_TYPE = struct_stack_st_ASN1_TYPE;
pub const BIT_STRING_BITNAME_st = struct_BIT_STRING_BITNAME_st;
pub const stack_st_ASN1_OBJECT = struct_stack_st_ASN1_OBJECT;
pub const stack_st_ASN1_INTEGER = struct_stack_st_ASN1_INTEGER;
pub const stack_st_ASN1_UTF8STRING = struct_stack_st_ASN1_UTF8STRING;
pub const stack_st_ASN1_GENERALSTRING = struct_stack_st_ASN1_GENERALSTRING;
pub const obj_name_st = struct_obj_name_st;
pub const evp_cipher_info_st = struct_evp_cipher_info_st;
