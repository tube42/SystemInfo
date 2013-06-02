
#include <Qt>
#include <Math.h>

// compute sum of all members in a mandelbort set
qreal mandelbrot(qreal x0, qreal y0, qreal x1, qreal y1, int width, int height, int max_iterations)
{
    qreal xdelta = (x1 - x0) / width;
    qreal ydelta = (y1 - y0) / height;
    qreal dummy_ret = 0.0;

    for(qreal y = y0 ; y < y1; y += ydelta) {
        for(qreal x = x0 ; x < x1; x += xdelta) {

            qreal a = 0, b = 0;
            int i;
            for(i = 0; i < max_iterations && sqrt(a*a + b*b) < 2; i++) {
                qreal temp = a * a - b*b  + x;
                b = 2 * a * b + y;
                a = temp;
            }

            dummy_ret += i; // dont want out code optimized out...
        }
    }
    return dummy_ret;
}

void run_float_benchmark()
{
    mandelbrot(-2, -2, +2, +2, 200, 200, 250);
    mandelbrot(-1, -1, +1, +1, 300, 300, 250);
    mandelbrot(-0.5, -0.5, +0.5, +0.5, 400, 400, 250);
}

