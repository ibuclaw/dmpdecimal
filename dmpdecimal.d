/*
 * Copyright (c) 2024 Iain Buclaw.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
 * OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
 * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
 * SUCH DAMAGE.
 */

module dmpdecimal;

// mpdecimal includes a number of system headers, so must selectively import
// what we want to expose to the D module proper.
public import mpdecimal :
    mpd_version, mpd_uint_t, mpd_size_t, mpd_ssize_t, MPD_ROUND_UP,
    MPD_ROUND_DOWN, MPD_ROUND_CEILING, MPD_ROUND_FLOOR, MPD_ROUND_HALF_UP,
    MPD_ROUND_HALF_DOWN, MPD_ROUND_HALF_EVEN, MPD_ROUND_05UP, MPD_ROUND_TRUNC,
    MPD_ROUND_GUARD, MPD_CLAMP_DEFAULT, MPD_CLAMP_IEEE_754, MPD_CLAMP_GUARD,
    mpd_round_string, mpd_clamp_string, mpd_context_t, MPD_MINALLOC,
    mpd_traphandler, mpd_dflt_traphandler, mpd_setminalloc, mpd_init,
    mpd_maxcontext, mpd_defaultcontext, mpd_basiccontext, mpd_ieee_context,
    mpd_getprec, mpd_getemax, mpd_getemin, mpd_getround, mpd_gettraps,
    mpd_getstatus, mpd_getclamp, mpd_getcr, mpd_qsetprec, mpd_qsetemax,
    mpd_qsetemin, mpd_qsetround, mpd_qsettraps, mpd_qsetstatus, mpd_qsetclamp,
    mpd_qsetcr, mpd_addstatus_raise, mpd_t, mpd_triple_class,
    MPD_TRIPLE_NORMAL, MPD_TRIPLE_INF, MPD_TRIPLE_QNAN, MPD_TRIPLE_SNAN,
    MPD_TRIPLE_ERROR, mpd_uint128_triple_t, mpd_from_uint128_triple,
    mpd_as_uint128_triple, mpd_spec_t, mpd_to_sci, mpd_to_eng, mpd_to_sci_size,
    mpd_to_eng_size, mpd_validate_lconv, mpd_parse_fmt_str, mpd_qformat_spec,
    mpd_qformat, mpd_snprint_flags, mpd_lsnprint_flags, mpd_lsnprint_signals,
    mpd_fprint, mpd_print, mpd_qset_string, mpd_qset_string_exact,
    mpd_seterror, mpd_setspecial, mpd_zerocoeff, mpd_qmaxcoeff, mpd_qset_ssize,
    mpd_qset_i32, mpd_qset_uint, mpd_qset_u32, mpd_qset_i64, mpd_qset_u64,
    mpd_qset_i64_exact, mpd_qset_u64_exact, mpd_qsset_ssize, mpd_qsset_i32,
    mpd_qsset_uint, mpd_qsset_u32, mpd_qget_ssize, mpd_qget_uint,
    mpd_qabs_uint, mpd_qget_i32, mpd_qget_u32, mpd_qget_i64, mpd_qget_u64,
    mpd_qcheck_nan, mpd_qcheck_nans, mpd_qfinalize, mpd_class, mpd_qcopy,
    mpd_qcopy_cxx, mpd_qncopy, mpd_qcopy_abs, mpd_qcopy_negate, mpd_qcopy_sign,
    mpd_qand, mpd_qinvert, mpd_qlogb, mpd_qor, mpd_qscaleb, mpd_qxor,
    mpd_same_quantum, mpd_qrotate, mpd_qshiftl, mpd_qshiftr,
    mpd_qshiftr_inplace, mpd_qshift, mpd_qshiftn, mpd_qcmp, mpd_qcompare,
    mpd_qcompare_signal, mpd_cmp_total, mpd_cmp_total_mag, mpd_compare_total,
    mpd_compare_total_mag, mpd_qround_to_intx, mpd_qround_to_int, mpd_qtrunc,
    mpd_qfloor, mpd_qceil, mpd_qabs, mpd_qmax, mpd_qmax_mag, mpd_qmin,
    mpd_qmin_mag, mpd_qminus, mpd_qplus, mpd_qnext_minus, mpd_qnext_plus,
    mpd_qnext_toward, mpd_qquantize, mpd_qrescale, mpd_qrescale_fmt,
    mpd_qreduce, mpd_qadd, mpd_qadd_ssize, mpd_qadd_i32, mpd_qadd_uint,
    mpd_qadd_u32, mpd_qsub, mpd_qsub_ssize, mpd_qsub_i32, mpd_qsub_uint,
    mpd_qsub_u32, mpd_qmul, mpd_qmul_ssize, mpd_qmul_i32, mpd_qmul_uint,
    mpd_qmul_u32, mpd_qfma, mpd_qdiv, mpd_qdiv_ssize, mpd_qdiv_i32,
    mpd_qdiv_uint, mpd_qdiv_u32, mpd_qdivint, mpd_qrem, mpd_qrem_near,
    mpd_qdivmod, mpd_qpow, mpd_qpowmod, mpd_qexp, mpd_qln10, mpd_qln,
    mpd_qlog10, mpd_qsqrt, mpd_qinvroot, mpd_qadd_i64, mpd_qadd_u64,
    mpd_qsub_i64, mpd_qsub_u64, mpd_qmul_i64, mpd_qmul_u64, mpd_qdiv_i64,
    mpd_qdiv_u64, mpd_sizeinbase, mpd_qimport_u16, mpd_qimport_u32,
    mpd_qexport_u16, mpd_qexport_u32, mpd_format, mpd_import_u16,
    mpd_import_u32, mpd_export_u16, mpd_export_u32, mpd_finalize,
    mpd_check_nan, mpd_check_nans, mpd_set_string, mpd_maxcoeff,
    mpd_sset_ssize, mpd_sset_i32, mpd_sset_uint, mpd_sset_u32, mpd_set_ssize,
    mpd_set_i32, mpd_set_uint, mpd_set_u32, mpd_set_i64, mpd_set_u64,
    mpd_get_ssize, mpd_get_uint, mpd_abs_uint, mpd_get_i32, mpd_get_u32,
    mpd_get_i64, mpd_get_u64, mpd_and, mpd_copy, mpd_canonical, mpd_copy_abs,
    mpd_copy_negate, mpd_copy_sign, mpd_invert, mpd_logb, mpd_or, mpd_rotate,
    mpd_scaleb, mpd_shiftl, mpd_shiftr, mpd_shiftn, mpd_shift, mpd_xor,
    mpd_abs, mpd_cmp, mpd_compare, mpd_compare_signal, mpd_add, mpd_add_ssize,
    mpd_add_i32, mpd_add_uint, mpd_add_u32, mpd_sub, mpd_sub_ssize,
    mpd_sub_i32, mpd_sub_uint, mpd_sub_u32, mpd_div, mpd_div_ssize,
    mpd_div_i32, mpd_div_uint, mpd_div_u32, mpd_divmod, mpd_divint, mpd_exp,
    mpd_fma, mpd_ln, mpd_log10, mpd_max, mpd_max_mag, mpd_min, mpd_min_mag,
    mpd_minus, mpd_mul, mpd_mul_ssize, mpd_mul_i32, mpd_mul_uint, mpd_mul_u32,
    mpd_next_minus, mpd_next_plus, mpd_next_toward, mpd_plus, mpd_pow,
    mpd_powmod, mpd_quantize, mpd_rescale, mpd_reduce, mpd_rem, mpd_rem_near,
    mpd_round_to_intx, mpd_round_to_int, mpd_trunc, mpd_floor, mpd_ceil,
    mpd_sqrt, mpd_invroot, mpd_add_i64, mpd_add_u64, mpd_sub_i64, mpd_sub_u64,
    mpd_div_i64, mpd_div_u64, mpd_mul_i64, mpd_mul_u64, mpd_adjexp, mpd_etiny,
    mpd_etop, mpd_msword, mpd_word_digits, mpd_msd, mpd_lsd,
    mpd_digits_to_size, mpd_exp_digits, mpd_iscanonical, mpd_isfinite,
    mpd_isinfinite, mpd_isinteger, mpd_isnan, mpd_isnegative, mpd_ispositive,
    mpd_isqnan, mpd_issigned, mpd_issnan, mpd_isspecial, mpd_iszero,
    mpd_iszerocoeff, mpd_isnormal, mpd_issubnormal, mpd_isoddword,
    mpd_isoddcoeff, mpd_isodd, mpd_iseven, mpd_sign, mpd_arith_sign, mpd_radix,
    mpd_isdynamic, mpd_isstatic, mpd_isdynamic_data, mpd_isstatic_data,
    mpd_isshared_data, mpd_isconst_data, mpd_trail_zeros, mpd_setdigits,
    mpd_set_sign, mpd_signcpy, mpd_set_infinity, mpd_set_qnan, mpd_set_snan,
    mpd_set_negative, mpd_set_positive, mpd_set_dynamic, mpd_set_static,
    mpd_set_dynamic_data, mpd_set_static_data, mpd_set_shared_data,
    mpd_set_const_data, mpd_clear_flags, mpd_set_flags, mpd_copy_flags,
    mpd_mallocfunc, mpd_callocfunc, mpd_reallocfunc, mpd_free,
    mpd_callocfunc_em, mpd_alloc, mpd_calloc, mpd_realloc, mpd_sh_alloc,
    mpd_qnew, mpd_new, mpd_qnew_size, mpd_del, mpd_uint_zero, mpd_qresize,
    mpd_qresize_zero, mpd_minalloc, mpd_resize, mpd_resize_zero,
    MPD_MAJOR_VERSION, MPD_MINOR_VERSION, MPD_MICRO_VERSION, MPD_VERSION,
    MPD_VERSION_HEX, MPD_BITS_PER_UINT, MPD_RADIX, MPD_RDIGITS, MPD_MAX_POW10,
    MPD_EXPDIGITS, MPD_MAXTRANSFORM_2N, MPD_MAX_PREC, MPD_MAX_PREC_LOG2,
    MPD_ELIMIT, MPD_MAX_EMAX, MPD_MIN_EMIN, MPD_MIN_ETINY, MPD_EXP_INF,
    MPD_EXP_CLAMP, MPD_MAXIMPORT, MPD_IEEE_CONTEXT_MAX_BITS, MPD_Clamped,
    MPD_Conversion_syntax, MPD_Division_by_zero, MPD_Division_impossible,
    MPD_Division_undefined, MPD_Fpu_error, MPD_Inexact, MPD_Invalid_context,
    MPD_Invalid_operation, MPD_Malloc_error, MPD_Not_implemented, MPD_Overflow,
    MPD_Rounded, MPD_Subnormal, MPD_Underflow, MPD_Max_status,
    MPD_IEEE_Invalid_operation, MPD_Errors, MPD_Traps, MPD_DECIMAL32,
    MPD_DECIMAL64, MPD_DECIMAL128, MPD_MINALLOC_MIN, MPD_MINALLOC_MAX,
    MPD_NUM_FLAGS, MPD_MAX_FLAG_STRING, MPD_MAX_FLAG_LIST, MPD_MAX_SIGNAL_LIST;

// These symbols are only defined in 64-bit configurations.
static if (__traits(compiles, { import mpdecimal : MPD_CONFIG_64; }))
{
    public import mpdecimal :
        mpd_qsset_i64, mpd_qsset_u64, mpd_sset_i64, mpd_sset_u64;
}

// Some public macros are not exposed due to how they're written in the header.
extern (C)
{
    // Properties of types for modular and base arithmetic.
    enum MPD_UINT_MAX = mpd_uint_t.max;
    enum MPD_SIZE_MAX = mpd_size_t.max;
    // Properties of type for exp, digits, len, prec.
    enum MPD_SSIZE_MAX = mpd_ssize_t.max;
    enum MPD_SSIZE_MIN = mpd_ssize_t.min;
    // Official name for status flag.
    enum MPD_Insufficient_storage = MPD_Malloc_error;

    // mpd_t flags
    enum MPD_POS         = ubyte(0);
    enum MPD_NEG         = ubyte(1);
    enum MPD_INF         = ubyte(2);
    enum MPD_NAN         = ubyte(4);
    enum MPD_SNAN        = ubyte(8);
    enum MPD_SPECIAL     = ubyte(MPD_INF|MPD_NAN|MPD_SNAN);
    enum MPD_STATIC      = ubyte(16);
    enum MPD_STATIC_DATA = ubyte(32);
    enum MPD_SHARED_DATA = ubyte(64);
    enum MPD_CONST_DATA  = ubyte(128);
    enum MPD_DATAFLAGS   = ubyte(MPD_STATIC_DATA|MPD_SHARED_DATA|MPD_CONST_DATA);

    // Error macros
    //#define mpd_err_fatal(...) \
    //    do {fprintf(stderr, "%s:%d: error: ", __FILE__, __LINE__); \
    //        fprintf(stderr, __VA_ARGS__);  fputc('\n', stderr);    \
    //        abort();                                               \
    //    } while (0)
    //#define mpd_err_warn(...) \
    //    do {fprintf(stderr, "%s:%d: warning: ", __FILE__, __LINE__); \
    //        fprintf(stderr, __VA_ARGS__); fputc('\n', stderr);       \
    //    } while (0)
}
