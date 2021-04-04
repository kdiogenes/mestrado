require "active_support/all"
require "bigdecimal/util"
require "json"

results = JSON.parse(File.open("outputs/experiment_generated_data.txt").read)

means = {
  seq: [],
  seq_opt: [],
  jump: [],
  bs: []
}

dps = {
  seq: [],
  seq_opt: [],
  jump: [],
  bs: []
}

first_10 = {
  means: {
    seq: [],
    seq_opt: [],
    jump: [],
    bs: []
  },
  dps: {
    seq: [],
    seq_opt: [],
    jump: [],
    bs: []
  }
}

last_10 = {
  means: {
    seq: [],
    seq_opt: [],
    jump: [],
    bs: []
  },
  dps: {
    seq: [],
    seq_opt: [],
    jump: [],
    bs: []
  }
}

not_found = {
  means: {
    seq: [],
    seq_opt: [],
    jump: [],
    bs: []
  },
  dps: {
    seq: [],
    seq_opt: [],
    jump: [],
    bs: []
  }
}

(10..27).each do |exp|
  means[:seq] << results["sequential"][exp.to_s].sum { |result| result["elapsed_time"] } / 100
  means[:seq_opt] << results["sequential_optimized"][exp.to_s].sum { |result| result["elapsed_time"] } / 100
  means[:jump] << results["jump_search"][exp.to_s].sum { |result| result["elapsed_time"] } / 100
  means[:bs] << results["binary_search"][exp.to_s].sum { |result| result["elapsed_time"] } / 100

  dps[:seq] << Math.sqrt(results["sequential"][exp.to_s].sum { |result| (result["elapsed_time"] - means[:seq][-1])**2 } / 100)
  dps[:seq_opt] << Math.sqrt(results["sequential_optimized"][exp.to_s].sum { |result| (result["elapsed_time"] - means[:seq_opt][-1])**2 } / 100)
  dps[:jump] << Math.sqrt(results["jump_search"][exp.to_s].sum { |result| (result["elapsed_time"] - means[:jump][-1])**2 } / 100)
  dps[:bs] << Math.sqrt(results["binary_search"][exp.to_s].sum { |result| (result["elapsed_time"] - means[:bs][-1])**2 } / 100)

  [["sequential", :seq], ["sequential_optimized", :seq_opt], ["jump_search", :jump], ["binary_search", :bs]].each do |search_type|
    firsts = results[search_type[0]][exp.to_s].select { |result| result["position"] < ((2**exp) * 10 / 100) && result["position"] != -1 }
    lasts = results[search_type[0]][exp.to_s].select { |result| result["position"] >= (2**exp - ((2**exp) * 10 / 100)) && result["position"] != -1 }
    not_founds = results[search_type[0]][exp.to_s].select { |result| result["position"] == -1 }

    first_10[:means][search_type[1]] << (firsts.sum { |result| result["elapsed_time"] } / firsts.length rescue "X")
    last_10[:means][search_type[1]] << (lasts.sum { |result| result["elapsed_time"] } / lasts.length rescue "X")
    not_found[:means][search_type[1]] << (not_founds.sum { |result| result["elapsed_time"] } / not_founds.length rescue "X")

    first_10[:dps][search_type[1]] << (Math.sqrt(firsts.sum { |result| (result["elapsed_time"] - first_10[:means][search_type[1]][-1])**2 } / firsts.length) rescue "X")
    last_10[:dps][search_type[1]] << (Math.sqrt(lasts.sum { |result| (result["elapsed_time"] - last_10[:means][search_type[1]][-1])**2 } / lasts.length) rescue "X")
    not_found[:dps][search_type[1]] << (Math.sqrt(not_founds.sum { |result| (result["elapsed_time"] - not_found[:means][search_type[1]][-1])**2 } / not_founds.length) rescue "X")
  end
end

p means.deep_transform_values { |value| value.is_a?(Numeric) ? value.to_d.to_s('F') : value }
p dps.deep_transform_values { |value| value.is_a?(Numeric) ? value.to_d.to_s('F') : value }
p first_10.deep_transform_values { |value| value.is_a?(Numeric) ? value.to_d.to_s('F') : value }
p last_10.deep_transform_values { |value| value.is_a?(Numeric) ? value.to_d.to_s('F') : value }
p not_found.deep_transform_values { |value| value.is_a?(Numeric) ? value.to_d.to_s('F') : value }