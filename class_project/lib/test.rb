def add(*args)
  args.length == 1 ? 5 + args[0] : args[0] + args[1]
end

p add(4)
p add(2, 3)
