// Unreal Music (UMX) Ripper by Tom Grandgent (tgrand@canvaslink.com)

// Cheesy?  Maybe.  But it works and it's fast.

#include <stdio.h>

int main(int argc, char *argv[])
{
    int f, i, j, k;
    FILE *in, *out;
    char sig[4];
    char done, type, ch;
    char buf[128];
    char ext[6];

    setvbuf(stdout, NULL, _IONBF, NULL);

    printf("Unreal Music (UMX) Ripper by Tom Grandgent\n\n");

    // Check parameters
    if (argc < 2)
    {
        printf("Example usage:\n\n");
        printf("umxrip *.*\nor\numxrip chizra1.umx\n");
        return 1;
    }

    // Loop through all of the input files
    for (f = 1; f < argc; f++)
    {
        in = fopen(argv[f], "rb");
        if (!in)
        {
            printf("Error: Unable to open %s for reading\n", argv[f]);
            continue;
        }
        printf("%s: ", argv[f]);

        // Seek to Epic's file type identifier
        fseek(in, 0x3C, SEEK_SET);
        // Read the file type (s3m, it, or unknown) and search the file for the
        // proper S3M or IT signature (SCRM or IMPM)
        for (i = 0; i < 3; i++)
            sig[i] = fgetc(in);
        if (!strnicmp(sig, "s3m", 3))
        {
            printf("ScreamTracker 3 format..  ");
            done = 0;
            do
            {
                ch = fgetc(in);
                if (ch == 'S')
                {
                    ch = fgetc(in);
                    if (ch == 'C')
                    {
                        ch = fgetc(in);
                        if (ch == 'R')
                        {
                            ch = fgetc(in);
                            if (ch == 'M')
                            {
                                fseek(in, -48, SEEK_CUR);
                                strcpy(ext, ".s3m");
                                done = 1;
                            }
                        }
                    }
                }
                else
                    if (feof(in))
                        done = 2;
            } while (!done);
            if (done == 2)
            {
                printf("Unable to locate S3M signature (SCRM), skipping..\n");
                continue;
            }
        }
        else
        if (!strnicmp(sig, "it", 2))
        {
            printf("Impulse Tracker format..  ");
            done = 0;
            do
            {
                ch = fgetc(in);
                if (ch == 'I')
                {
                    ch = fgetc(in);
                    if (ch == 'M')
                    {
                        ch = fgetc(in);
                        if (ch == 'P')
                        {
                            ch = fgetc(in);
                            if (ch == 'M')
                            {
                                fseek(in, -4, SEEK_CUR);
                                strcpy(ext, ".it");
                                done = 1;
                            }
                        }
                    }
                }
                else
                    if (feof(in))
                        done = 2;
            } while (!done);
            if (done == 2)
            {
                printf("Unable to locate IT signature (IMPM), skipping..\n");
                continue;
            }
        }
        else
        {
            printf("Unknown format, skipping..\n");
            continue;
        }

        // Set up an output filename with the proper extension
        strcpy(buf, argv[f]);
        // Find the extension and nuke it if there is one
        for (i = strlen(buf); i--; i > 0)
            if (buf[i] == '.')
            {
                buf[i] = '\0';
                break;
            }
        // Add the new extension (.s3m or .it)
        strcat(buf, ext);

        // Open the output file
        out = fopen(buf, "wb");
        if (!out)
        {
            printf("Couldn't open %s for writing..\n", buf);
            continue;
        }

        // Write out the data (haha, ok, I know this is not nice)
        while (1)
        {
            i = fgetc(in);
            if (i == EOF)
                break;
            fputc(i, out);
        }

        fclose(in);
        fclose(out);

        printf("Wrote %s.\n", buf);
    }

    return 0;
}
