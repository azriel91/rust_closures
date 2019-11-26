# Closure Environment

## Borrow or Move

Rust determines whether a variable is borrowed or moved from the closure environment when capturing the variables.

* Inferred borrow:

    ```rust
    #[derive(Clone, Debug)]
    struct A {
        value: i32,
    }

    fn borrow(_a: &A) { println!("borrow"); }
    fn consume(_a: A) { println!("consume"); }

    fn main() {
        let a = A { value: 0 };
        let closure = || {
            // `a` still refers to `A` instead of `&A`.
            // So we have to add `&` in front of it.

        //  borrow(a);
        //         ^
        //         |
        //         expected &A, found struct `A`
        //         help: consider borrowing here: `&a`

            borrow(&a);
        };
        closure();

        let closure_move = || consume(a);
        closure_move();
    }
    ```

* Inferred `move`:

    ```rust
    #[derive(Clone, Debug)]
    struct A {
        value: i32,
    }

    fn borrow(_a: &A) { println!("borrow"); }
    fn consume(_a: A) { println!("consume"); }

    fn main() {
        let a = A { value: 0 };
        let closure = || {
        //            -- value moved into closure here
            borrow(&a);
            consume(a);
        };
        closure();

        // let closure_move = || consume(a);
        //                    ^^         - use occurs due to use in closure
        //                    |
        //                    value used here after move
        // closure_move();
    }
    ```

* Explicit `move`:

    You can use the `move` keyword to indicate the variable must be moved instead of borrowed.

    ```rust
    #![allow(dead_code)]

    #[derive(Clone, Debug)]
    struct A {
        value: i32,
    }

    fn borrow(_a: &A) {}
    fn consume(_a: A) {}

    fn main() {
        let a = A { value: 0 };

        let closure_move = move || borrow(&a);
        //                 -------         - variable moved due to use in closure
        //                 |
        //                 value moved into closure here
        closure_move();

        // let closure_move = move || consume(a);
        //                    ^^^^^^^         - use occurs due to use in closure
        //                    |
        //                    value used here after move
        // closure_move();
    }
    ```

## Borrow Lifetime

The usual borrowing rules apply -- note that the borrow lasts for the lifetime of the closure:

```rust
#[derive(Debug)]
struct A {
    value: i32,
}

fn main() {
    let mut a = A { value: 0 };
    let mut closure = || a.value = 123;
    //                -- - borrow occurs due to use in closure
    //                |
    //                borrow of `a.value` occurs here

    // a.value = 456; // error[E0506]: cannot assign to `a.value` because it is borrowed

    closure();
//  ------- borrow later used here
}
```
