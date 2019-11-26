# What Are Closures

**<span style="font-size: 0.7em;">(azriel's)</span> Definition:** A stored anonymous function, that captures its scoped environment.

```rust
let closure_0 = || println!("hello");
let closure_1 = || println!("world");

closure_0();
```
