
import QtQuick 1.1
import com.nokia.meego 1.0

import "Benchmark.js" as Benchmark

BasicPage {
    id: page
    title: "Benchmark"

    property bool finished: false
    property real score1: 0
    property real score2: 0
    property real score3: 0
    property bool working: false

    hasBack: !working

    Item {
        anchors.fill: parent.canvas

        Text {
            id: info
            text: "Please close all active apps before running the benchmark! Note also that this function is still UNDER DEVELOPMENT..."
            font.family: theme.subtitleFontFamily
            font.pixelSize: theme.subtitleFontSize
            color: theme.subtitleFontColor

            width: parent.width
            anchors.bottom: parent.bottom
            maximumLineCount: 3
            wrapMode: Text.Wrap

        }

        Column {
            anchors.fill:  parent
            spacing: theme.defaultMargin

            Button {
                id: button
                text: "Run benchmark"
                anchors.horizontalCenter: parent.horizontalCenter
                onClicked: startBenchmark();
                enabled: !working
            }

            BenchmarkItem { id: item1; text:  "Native int"; value: score1 }
            BenchmarkItem { id: item2; text:  "Native FP"; value: score2 }
            BenchmarkItem { id: item3; text:  "Scripted JS"; value: score3 }


            Item { width: parent.width; height: 16} // space

            BusyIndicator {
                id: indicator
                anchors.horizontalCenter: parent.horizontalCenter
                platformStyle: BusyIndicatorStyle { size: "large" }
                running: working
                visible: working
            }
        }
    }

    Connections {
        target: platform
        onBenchmarkResult: updateBenchmark(which, score);
    }

    WorkerScript {
        id: worker
        source: "Benchmark.js"
        onMessage: endBenchmark(messageObject.score);
    }

    // --------------------------------------
    function startBenchmark() {
        working = true
        platform.runBenchmark(0);
    }

    function updateBenchmark(which, score) {
        console.log("which", which);
        console.log("score", score);

        if(which == 0) {
            score1 =  score.toFixed(2);
            platform.runBenchmark(1);
        } else {
            score2 = score.toFixed(2);
            worker.sendMessage( {  } );
        }
    }
    function endBenchmark(score) {
        score3 = score.toFixed(2);
        working = false;
    }

}

