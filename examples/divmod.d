import mpdecimal;
import core.runtime;

void main()
{
    mpd_context_t ctx;
    mpd_t* a, b;
    mpd_t* q, r;
    char* qs, rs;
    char[MPD_MAX_FLAG_STRING] status_str;

    if (Runtime.cArgs.argc != 3) {
        fprintf(stderr, "divmod: usage: ./divmod x y\n");
        exit(1);
    }

    mpd_init(&ctx, 38);
    ctx.traps = 0;

    q = mpd_new(&ctx);
    r = mpd_new(&ctx);
    a = mpd_new(&ctx);
    b = mpd_new(&ctx);
    mpd_set_string(a, Runtime.cArgs.argv[1], &ctx);
    mpd_set_string(b, Runtime.cArgs.argv[2], &ctx);

    mpd_divmod(q, r, a, b, &ctx);

    qs = mpd_to_sci(q, 1);
    rs = mpd_to_sci(r, 1);

    mpd_snprint_flags(status_str.ptr, MPD_MAX_FLAG_STRING, ctx.status);
    printf("%s  %s  %s\n", qs, rs, status_str.ptr);

    mpd_del(q);
    mpd_del(r);
    mpd_del(a);
    mpd_del(b);
    mpd_free(qs);
    mpd_free(rs);
}
