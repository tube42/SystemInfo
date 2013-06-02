



// -------------------------------------------------------------

// tak is a micro benchmark for recursion
function tak(x, y, z)
{
    return y < x ? tak(  tak(x-1, y, z), tak(y-1, z, x), tak(z-1, x, y) ) : z;
}

// this is Fibonacci, but with strings
function fibstr(n)
{
    if(n < 2) return "1";
    return fibstr(n - 1 ) + fibstr(n - 2 );
}

function runJavascriptBenchmark()
{
    var start = new Date().getTime();

    var x = tak(50, 44, 68);
    var y = fibstr(32);

    var end = new Date().getTime();

    // use the returned values :)
    if(x == y) console.log("aliens are comming");


    var elapsed = end - start;
    if(elapsed < 0.1) elapsed = 0.1; // ERROR?

    console.log("Bench 3", elapsed, start, end); // DEBUG
    return 100000.0  / elapsed;

}


// keep only n decimals
function removeDecimals(x, n)
{
    console.log("X IN", x);
    var p = Math.pow(10, n);
    x = Math.round(x * p) / p;

    console.log("X OUT", x);
    return x ;
}

// -------------------------------------------------------------

WorkerScript.onMessage = function(message)
{
    var score = -1;
    try {

        // average of 3, with 1 warm up
        var tmp = 0;
        for(var i = 0; i < 4; i++) {
            var tmp2 = runJavascriptBenchmark();
            if(i != 0) tmp += tmp2;
        }
        score = tmp / 3;


    } catch(error) {
        console.log("ERROR in benchmark", error);
    }

    WorkerScript.sendMessage( { "score" : score } );
}
