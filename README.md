# Feature: `UnixPrintJob` Collation

This example adds the "collate" option to the OpenJDK `UnixPrintJob` internal class.

> **Note:** This repository currently only targets Ubuntu for testing/development.

## Background Details

Currently the OpenJDK `UnixPrintJob` does not support collation (see: [JDK-8345685](https://bugs.openjdk.org/browse/JDK-8345685)) even though [CUPS has this available](https://www.cups.org/doc/options.html#COPIES) as a hidden feature. This repository showcases a simple patch to `UnixPrintJob.java` to enable applying the collation option for Unix systems.

## Prerequisites

The following tools are required to test the "collate" option:

- [Ubuntu Workshop](https://ubuntu.com/workshop/docs/) - see the [installation guide](https://ubuntu.com/workshop/docs/tutorial/part-1-get-started/#tut-install) for more information.

## Getting Started

Firstly the underlying workshop needs to be launched and prepared with the following:

```shell
workshop launch dev
workshop run dev -- prepare
```

### Feature Action

From here the `feature` action can be used for showcasing the patch to `UnixPrintJob`:

```shell
workshop run dev -- feature
```

This will showcase the `lpr` command being executed with `-o collate=true` enabled.

### Unapplied Action

For a reference to the current behaviour in OpenJDK, invoke the `unapplied` action:

```shell
workshop run dev -- unapplied
```

This will showcase the current behaviour where collation is ignored (missing `-o collate=true` output).
