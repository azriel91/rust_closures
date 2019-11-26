# Fn Traits

There are three traits that Rust automatically implements for closures *when possible*. In *increasing superset* order:

* [`FnOnce`]: Consumes `self`. The closure is run once, and may consume variables.
* [`FnMut`]: Uses `&mut self`.The closure may be executed multiple times, and may borrow variables mutably.
* [`Fn`]: Uses `&self`. The closure may be executed multiple times, and only borrow variables immutably.

```rust
struct A { value: i32 }

fn call_fn_once<F>(f: F)      where F: FnOnce() { f(); }
fn call_fn_mut <F>(f: &mut F) where F: FnMut()  { f(); }
fn call_fn     <F>(f: &F)     where F: Fn()     { f(); }

fn main() {
    let a = A { value: 0 };
    let closure_fn_once = || {
        println!("closure_fn_once");
        drop(a);
    };
//  closure_fn_once();
//  --------------- value moved here
//  closure_fn_once();
//  ^^^^^^^^^^^^^^^ value used here after move

    let mut a = A { value: 0 };
    let mut closure_fn_mut = || {
        println!("closure_fn_mut. a.value: `{}`", a.value);
        a.value += 1;
    };
    // closure_fn_mut();
    // closure_fn_mut();
    // closure_fn_mut();

    let a = A { value: 0 };
    let mut closure_fn = || {
        println!("closure_fn. a.value: `{}`", a.value);
    };
    // closure_fn();
    // closure_fn();
    // closure_fn();

    call_fn(&closure_fn);

    call_fn_mut(&mut closure_fn_mut);
    call_fn_mut(&mut closure_fn);

    call_fn_once(closure_fn_once);
    call_fn_once(closure_fn_mut);
    call_fn_once(closure_fn);
}
```

[`FnOnce`]: https://doc.rust-lang.org/std/ops/trait.FnOnce.html
[`FnMut`]: https://doc.rust-lang.org/std/ops/trait.FnMut.html
[`Fn`]: https://doc.rust-lang.org/std/ops/trait.Fn.html
