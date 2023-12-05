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

def pass_through_map(current, curr_map)
  curr_map.each do |rng|
    dest_start, src_start, rng_length = rng
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
    # puts current
  }
  return current
end

locations = $seeds.map{ | seed | pass_through_maps(seed) }
puts "First task: min location = #{locations.min}"
