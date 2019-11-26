# 💺 Development Ergonomics

> *"Tell me what I need to know, and nothing else."*

```rust
let mut numbers = vec![0, 1, 2, 3, 4];
numbers.iter_mut().for_each(|n| *n <<= 1);

println!("{:?}", numbers);
```

Closure:

```rust,ignore
|n| *n <<= 1
```

If we did not have closures:

```rust
trait Mutation {
    type Item;
    fn mutate(&self, i: &mut Self::Item);
}

struct Doubler;
impl Mutation for Doubler {
    type Item = i32;
    fn mutate(&self, i: &mut Self::Item) {
        *i <<= 1;
    }
}

fn do_work(numbers: &mut [i32], mutation: &dyn Mutation<Item = i32>) {
    for n in numbers {
        mutation.mutate(n);
    }
}

fn main() {
    let mut numbers = vec![0, 1, 2, 3, 4];
    let doubler = Doubler;

    do_work(&mut numbers, &doubler);

    println!("{:?}", numbers);
}
```
