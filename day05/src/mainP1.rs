use std::fs::File;
use std::io::prelude::*;

fn main() -> std::io::Result<()> {
    // Open file and read inputs
    let mut file = File::open("inputInterval2.txt")?;
    let mut lines_interval: String = String::new();
    file.read_to_string(&mut lines_interval)?;

    let mut file = File::open("inputList2.txt")?;
    let mut lines_list: String = String::new();
    file.read_to_string(&mut lines_list)?;

    // Split lines
    let tab_list = lines_list.split('\n');

    let mut cpt_fresh = 0;
    for ingredient in tab_list {
        if ingredient < "0" {
            continue;
        }

        let mut in_any_interval = false;

        for interval in lines_interval.split('\n').clone() {
            let mut splited_interval = interval.split('-');
            let interval_min = splited_interval
                .next()
                .unwrap_or_default()
                .parse::<i64>()
                .unwrap_or(0);

            let interval_max= splited_interval
                .next()
                .unwrap_or_default()
                .parse::<i64>()
                .unwrap_or(0);

            let ingredient_int: i64 = ingredient.parse().unwrap_or(-1);

            // println!("{interval_min}");
            // println!("{interval_max}");
            if interval_min <= ingredient_int {
                if interval_max >= ingredient_int {
                    in_any_interval = true;
                }
            }
        }

        // println!("{ingredient}");
        if in_any_interval == true {
            println!("{ingredient}");
            cpt_fresh += 1;
        }
    }

    println!("-> {cpt_fresh}");
    Ok(())
}
