use std::fs::File;
use std::io::prelude::*;

fn main() -> std::io::Result<()> {
    // Open file and read inputs
    let mut file = File::open("inputInterval2.txt")?;
    let mut lines_interval: String = String::new();
    file.read_to_string(&mut lines_interval)?;

    // Create an array for the interval
    let mut parsed_intervals: Vec<(i64, i64)> = Vec::new();
    for line in lines_interval.lines() {
        // Skip empty lines
        if line < "0" {
            break;
        }

        // Get int borders
        let mut splited_interval = line.split('-');
        let mut start = splited_interval
            .next()
            .unwrap_or_default()
            .parse::<i64>()
            .unwrap_or(0);

        let mut end = splited_interval
            .next()
            .unwrap_or_default()
            .parse::<i64>()
            .unwrap_or(0);

        // Add intervals in the new array for interval parsed 
        parsed_intervals.push((start, end));
    }

    // Sort intervals
    parsed_intervals.sort_by_key(|&(start, _)| start);

    // Merge intervals
    let mut cpt: i64 = 0;
    let (x, y) = parsed_intervals[0];
    let mut tmp_x = x;
    let mut tmp_y = y;

    for &(start, end) in parsed_intervals.iter() {
        if start <= tmp_y + 1 {
            // Is Overlaping the last
            tmp_y = tmp_y.max(end);
        } else {
            // Is not touching the last
            cpt += tmp_y - tmp_x + 1;

            // Next Interval
            tmp_x = start;
            tmp_y = end;
        }
    }

    // Add last interval
    cpt += tmp_y - tmp_x + 1;

    println!("{cpt}");
    Ok(())
}
