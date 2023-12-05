$verb = false # puts debug

lines = IO.readlines("input.txt").map(&:chomp)

# get line that contains seeds
$seeds = lines[0].sub("seeds: ", "").split(" ").map(&:to_i)

# parse the rest of the files – that means getting the $maps between these headlines
headlines = [
  "seed-to-soil map:",
  "soil-to-fertilizer map:",
  "fertilizer-to-water map:",
  "water-to-light map:",
  "light-to-temperature map:",
  "temperature-to-humidity map:",
  "humidity-to-location map:"
]

# indices of headlines
idxs = headlines.map { |key| lines.find_index { |line| line.include?(key) } }

# range = [destination_start, source_start, length]
# map = array of ranges
# get array of maps:
$maps = idxs.map.with_index do |line_num, j|
  start_line = line_num + 1
  end_line = (j < idxs.length - 1 ? idxs[j+1] : lines.length+1) - 2
  line_num = lines[start_line..end_line].map { |line| line.split(" ").map(&:to_i)}
end

# first task
def pass_through_map(current, curr_map)
  curr_map.each do |rng_mapper|
    dest_start, src_start, rng_length = rng_mapper
    if current >= src_start && current < src_start+rng_length
      return dest_start + current - src_start
    end
  end
  return current
end

def pass_through_maps(seed)
  current = seed
  $maps.each { |curr_map|
    current = pass_through_map(current, curr_map)
    puts current if $verb
  }
  return current
end

locations = $seeds.map{ | seed | pass_through_maps(seed) }
puts "1st task: min location = #{locations.min}"

# second task
# array of all seed ranges, which are an array of [start,end] (meaning a union of all start..ends)
$seed_ranges = []
(0...$seeds.length).step(2).each { |i|
  $seed_ranges << [[$seeds[i], $seeds[i] + $seeds[i + 1] - 1]]
}

# development data
# $maps = [[[20, 50, 2], [200, 50, 70], [100, 210, 10], [110, 105, 8], [300, 230, 6]]]
# $seed_ranges = [[[60, 90]]]

# union as [[range_start, range_end]]
def pass_through_map2(union, curr_map)
  newnion = [] # union of ranges that WERE processed by any maps
  curr_map.each do |rng_mapper|
    dest_start, src_start, rng_length = rng_mapper
    src_end = src_start + rng_length - 1

    do_map = lambda { |num| dest_start + num - src_start }

    union2 = []  # union left unprocessed BY THIS MAPPER
    union.each do |rng|
      rng_start, rng_end = rng

      # mapper out of range
      if src_start < rng_start && src_end < rng_start
        union2 << rng
        puts "Out of range below" if $verb
      elsif src_start > rng_end && src_end > rng_end
        union2 << rng
        puts "Out of range above" if $verb

      # mapper is over whole range
      elsif src_start <= rng_start && src_end >= rng_end
        newnion << [do_map.(rng_start), do_map.(rng_end)]
        puts "Over whole range" if $verb

      # mapper intersects at beginning
      elsif src_start <= rng_start && src_end <= rng_end
        newnion << [do_map.(rng_start), do_map.(src_end)]
        union2 << [src_end+1, rng_end]
        puts "Intersect start" if $verb

      # mapper intersects at end
      elsif src_start >= rng_start && src_end >= rng_end
        union2 << [rng_start, src_start-1]
        newnion << [do_map.(src_start), do_map.(rng_end)]
        puts "Intersect end" if $verb

      # whole mapper is within range
      elsif src_start >= rng_start && src_end <= rng_end
        union2 << [rng_start, src_start-1]
        newnion << [do_map.(src_start), do_map.(src_end)]
        union2 << [src_end+1, rng_end]
        puts "Within range" if $verb

      # absurd
      else
        raise "WTF ABSURD"
      end
    end
    union = union2
  end

  # merge the processed ranges with those that were not processed by ANY mappers
  return union+newnion
end

def pass_through_maps2(seed_range)
  puts "\n" if $verb
  union = seed_range
  $maps.each { |curr_map|
    union = pass_through_map2(union, curr_map)
  }
  return union
end

location_ranges =  $seed_ranges.map{ | seed | pass_through_maps2(seed) }
pp location_ranges if $verb
min_location = location_ranges.flatten(1).map{ |rng| rng[0] }.min
puts "2nd task: min location = #{min_location}"
