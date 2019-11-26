# 🕒 Lazy evaluation

Instead of applying an operation to every item in a collection, using a closure allows one to:

1. Store the logic.
2. Apply the logic when the value is requested.

```rust
# use std::{
#     thread,
#     time::{Duration, Instant},
# };
#
let start = Instant::now();

let numbers = vec![1, 2, 3];
let mut numbers_double_iter = numbers.iter().map(|n| {
    // Expensive calculation.
    thread::sleep(Duration::from_millis(500));

    *n << 1
});

// Retrieve one value from the iterator
let n = numbers_double_iter.next().unwrap();
println!("n: {}", n);

let duration = start.elapsed().as_secs_f32();

println!("Duration: {:.2} ms", duration);
```
