# 🦝 Anonymous

A closure is a type that cannot be named.

```rust
use std::any::Any;

struct A;
fn hello() { println!("hello"); }

fn main() {
    let a_0: A = A;
    let a_1: A = A;
    let f_0: fn() = hello;
    let f_1: fn() = hello;
    let c_0 = || {};
    let c_1 = || {};

    println!("{}", std::any::type_name::<A>());
    println!("{}", std::any::type_name::<fn()>());

    println!("");

    println!("a_0: {:?}", a_0.type_id());
    println!("a_1: {:?}", a_1.type_id());
    println!("f_0: {:?}", f_0.type_id());
    println!("f_1: {:?}", f_1.type_id());
    println!("c_0: {:?}", c_0.type_id());
    println!("c_1: {:?}", c_1.type_id());
}
```
