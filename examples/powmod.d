import mpdecimal;
import core.runtime;

void main()
{
    mpd_context_t ctx;
    mpd_t* a, b, c;
    mpd_t* result;
    char* rstring;
    char[MPD_MAX_FLAG_STRING] status_str;

    if (Runtime.cArgs.argc != 4) {
        fprintf(stderr, "powmod: usage: ./powmod x y z\n");
        exit(1);
    }

    mpd_init(&ctx, 38);
    ctx.traps = 0;

    result = mpd_new(&ctx);
    a = mpd_new(&ctx);
    b = mpd_new(&ctx);
    c = mpd_new(&ctx);
    mpd_set_string(a, Runtime.cArgs.argv[1], &ctx);
    mpd_set_string(b, Runtime.cArgs.argv[2], &ctx);
    mpd_set_string(c, Runtime.cArgs.argv[3], &ctx);

    mpd_powmod(result, a, b, c, &ctx);

    rstring = mpd_to_sci(result, 1);
    mpd_snprint_flags(status_str.ptr, MPD_MAX_FLAG_STRING, ctx.status);
    printf("%s  %s\n", rstring, status_str.ptr);

    mpd_del(a);
    mpd_del(b);
    mpd_del(c);
    mpd_del(result);
    mpd_free(rstring);
}


