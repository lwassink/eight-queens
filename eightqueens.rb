#!/usr/bin/ruby
#
# Copyright (C) 2016 Luke Wassink <lwassink@gmail.com>
#
# Distributed under terms of the MIT license.
#


class Solver
  attr_reader :configurations

  def initialize
    @configurations = []
  end

  def generate_solutions!
    generate_configurations!
    prune_configurations!
  end

  def generate_configurations!
    @configurations = (0..7).to_a.permutation.to_a
  end

  def prune_configurations!
    @configurations.select! { |config| valid_configuration?(config) }
  end

  def valid_configuration?(config)
    config[0..-2].each_with_index do |col1, row1|
      config[row1+1..-1].each_with_index do |col2, row2|
        row2 += row1 + 1
        return false if (row1 - row2).abs == (col1 - col2).abs
      end
    end
    true
  end

  def print
    @configurations.each do |config|
      print_configuration(config)
      puts
    end
  end

  def print_configuration(config)
    8.times do |row|
      print_row(config[row])
    end
  end

  def print_row(num)
    row_str = '_' * 8
    row_str[num] = 'Q'
    puts row_str.chars.join(' ')
  end
end

if __FILE__ == $PROGRAM_NAME
  c = Solver.new
  c.generate_solutions!
  puts c.configurations.length
  c.print
end
