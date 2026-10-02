#!/usr/bin/env bash

set -ex

# common output directory
EXEC_OUTPUT="out/"

patch() {
    javac -XDignore.symbol.file -d $EXEC_OUTPUT --patch-module java.desktop=src/java.desktop \
        src/java.desktop/sun/print/UnixPrintJob.java \
        src/java.desktop/sun/print/PSPrinterJob.java
    java --patch-module java.desktop=out -cp $EXEC_OUTPUT $1
}

test() {
    javac src/Tester.java src/PassFailJFrame.java src/WindowLayouts.java -d $EXEC_OUTPUT
    patch Tester
}

start() {
    javac src/Application.java -d out/
    patch Application
}

buggy() {
    javac src/Application.java -d $EXEC_OUTPUT
    java -cp $EXEC_OUTPUT Application
}

# ensure using the correct argument
if [ -z "$1" ]; then
    echo "Usage: $0 {test|start|buggy}"; exit 1
fi

# extract the first command now
EXEC_COMMAND="$1"; shift

# route based on the incoming command now
case "$EXEC_COMMAND" in
    test)
        test
        ;;
    start)
        start
        ;;
    buggy)
        buggy
        ;;
    *)
        echo "Erro: Unknown subcommand '$EXEC_COMMAND'"; exit 1
        ;;
esac
