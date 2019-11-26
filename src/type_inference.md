# Type Inference

Rust can infer the type of each closure parameters and its return type, provided its usage is unambiguous.

```rust,ignore
fn  add_one_v1   (x: u32) -> u32 { x + 1 }
let add_one_v2 = |x: u32| -> u32 { x + 1 };
let add_one_v3 = |x|             { x + 1 };
let add_one_v4 = |x|               x + 1  ;
```

If the usage is ambiguous, you may explicitly specify the parameter types and return type that the closure must adhere to.

## Shared Syntax Does Not Compile

Since each closure is typed, the following will fail to compile, as Rust needs to choose whether `x`'s type is `u32` or `i32`:

```rust,ignore
let add_one = |x| x + 1;
add_one(1u32);
add_one(1i32);

println!("🦀 Ok!")
```

<span style="font-size: 0.7em; font-weight: bold;">Snippet from [The Rust Book - Chapter 13.1 Closures](https://doc.rust-lang.org/book/ch13-01-closures.html#closure-type-inference-and-annotation)</span>
