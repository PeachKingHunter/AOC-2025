const std = @import("std");

pub fn main() !void {
    const allocator = std.heap.page_allocator;

    // Open the file
    var file = try std.fs.cwd().openFile("./input2.txt", .{});
    defer file.close();

    // Read the whole file
    const fileSize: u64 = file.getEndPos() catch unreachable;
    const buffer: []u8 = allocator.alloc(u8, fileSize) catch unreachable;
    _ = file.readAll(buffer) catch unreachable;
    defer allocator.free(buffer);

    std.debug.print("{s}\n", .{buffer});

    // Get line Size & nb lines
    var lineSize: usize = 0;
    for (buffer) |val| {
        // std.debug.print("{d} - |{c}|\n", .{lineSize, val});
        lineSize = lineSize + 1;

        if (val == '\n') {
            break;
        }
    }
    const nbLine: usize = lineSize;

    // Print for debug
    std.debug.print("lineSize: {d}\n", .{lineSize});
    std.debug.print("nbLines: {d}\n", .{nbLine});
    // std.debug.print("*{c}*\n", .{buffer[lineSize*15-3]});

    // TimeLines variable for part II
    const timeLines = allocator.alloc(u64, lineSize) catch unreachable;
    defer allocator.free(timeLines);
    for (timeLines, 0..) |_, i| {
        timeLines[i] = 0;
    }

    // Change . -> | where needed
    var nbSpit: i32 = 0;
    for (buffer, 0..) |val, i| {
        if (val == 'S') {
            // Start beam
            timeLines[i % lineSize] = 1;
            if (buffer[i + lineSize] == '.') {
                buffer[i + lineSize] = '|';
            }
        } else if (val == '|') {
            // Extend beam
            if (i + lineSize < buffer.len - 1) {
                if (buffer[i + lineSize] == '.') {
                    buffer[i + lineSize] = '|';
                } else if (buffer[i + lineSize] == '^') {
                    // Part II adding
                    timeLines[(i % lineSize)+1] += timeLines[i % lineSize];
                    timeLines[(i % lineSize)-1] += timeLines[i % lineSize];
                    timeLines[i % lineSize] = 0;

                    // Part I
                    nbSpit += 1;
                    buffer[i + lineSize + 1] = '|';
                    buffer[i + lineSize - 1] = '|';
                }
            }
        }
    }

    // Print for debug
    std.debug.print("{s}\n", .{buffer});
    std.debug.print("nb Splits: {d}\n", .{nbSpit});
    // std.debug.print("timeLine: {any}\n", .{timeLines});

    // Calcul part II result
    var sum: u64 = 0;
    for (timeLines) |val| {
        sum += val;
    }
    std.debug.print("nb timeLine: {d}\n", .{sum});
}
