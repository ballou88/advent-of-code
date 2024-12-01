def read_seeds(line):
    seeds = line.split(": ")[1]
    seeds = list(map(lambda x: int(x), seeds.split()))

    return seeds


def process_map(section):
    out = {}
    for line in section.split("\n")[1:]:
        if len(line.split()) != 3:
            continue
        source_start, dest_start, length = line.split()
        out[range(int(dest_start), int(dest_start) + int(length))] = int(source_start)
    return out


def create_almanac(sections):
    seed_to_soil = process_map(sections[0])
    soil_to_fertilizer = process_map(sections[1])
    fertilizer_to_water = process_map(sections[2])
    water_to_light = process_map(sections[3])
    light_to_temp = process_map(sections[4])
    temp_to_hum = process_map(sections[5])
    hum_to_loc = process_map(sections[6])
    return {
        "s_to_s": seed_to_soil,
        "s_to_f": soil_to_fertilizer,
        "f_to_w": fertilizer_to_water,
        "w_to_l": water_to_light,
        "l_to_t": light_to_temp,
        "t_to_h": temp_to_hum,
        "h_to_l": hum_to_loc,
    }


def calc_loc(seed, almanac):
    for con_map in [
        "s_to_s",
        "s_to_f",
        "f_to_w",
        "w_to_l",
        "l_to_t",
        "t_to_h",
        "h_to_l",
    ]:
        for r in almanac[con_map].keys():
            if seed in r:
                seed = seed - r[1] + almanac[con_map][r] + 1
                break
    return seed


def run(input):
    sections = input.split("\n\n")
    seeds = read_seeds(sections[0])
    print(seeds)
    # almanac = create_almanac(sections[1:])
    # min_loc = float("inf")
    # for seed in seeds:
    #     min_loc = min(calc_loc(int(seed), almanac), min_loc)
    # print(min_loc)


with open("input.txt") as file:
    input = file.read()
run(input)
