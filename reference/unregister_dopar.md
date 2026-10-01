# Reset the foreach backend to sequential

Registers the sequential `foreach` backend after a parallel cluster has
been stopped, so later parallel `foreach` calls do not try to use the
closed cluster.

## Usage

``` r
unregister_dopar()
```

## Value

Called for its side effect; the return value is not used.
