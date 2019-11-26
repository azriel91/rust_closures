# 🕸️ Captures Environment

```rust,should_panic
let nine = 9;
let closure = |x| x * nine; // nine is captured

println!("{:?}", closure(1234567890))
```
