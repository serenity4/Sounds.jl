struct EMA
  f
  n::Int
end

function (ema::EMA)(ys)
  res = similar(ys)
  for i in eachindex(ys)
      v = 0.
      range = i:-1:max(1, i-ema.n)
      for j in range
      v += ys[j] * exp(j/i)
      end
      res[i] = v / sum(exp.(range ./ i))
  end
  res
end

function evaluate(ema::EMA, xs::AbstractVector)
  ys = evaluate(ema.f, xs)
  ema(ys)
end
