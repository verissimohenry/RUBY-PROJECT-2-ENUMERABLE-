module Enumerable
  def my_each
    i = 0
    return enum unless block_given?

    while to_a.length > i
      yield(to_a[i])
      i += 1
    end
    self
  end
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }


  def my_each_with_index
    i = 0
    return enum unless block_given?

    while to_a.length > i
      yield(to_a[i], i)
      i += 1
    end
    self
  end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }

def my_select
  new_array = []
  return enum unless block_given?

  to_a.my_each { |item| new_array.push(item) if yield(item) }
  new_array
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }


def my_all?(params = nil)
  if block_given?
    to_a.my_each { |item| return false if yield(item) == false }
  elsif params.nil?
    to_a.my_each { |item| return false if item.nil? || item == false }
  elsif !params.nil? && (params.is_a? Class)
    to_a.my_each { |item| return false unless [item.class, item.class.superclass].include?(params) }
  elsif !params.nil? && params.instance_of?(Regexp)
    to_a.my_each { |item| return false unless item.match(params) }
  else
    to_a.my_each { |item| return false if item != params }
  end
  true
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }

def my_any?(params = nil)
  if block_given?
    to_a.my_each { |item| return true if yield(item) }
    return false
  elsif params.nil?
    to_a.my_each { |item| return true if item }
  elsif !params.nil? && (params.is_a? Class)
    to_a.my_each { |item| return true if [item.class, item.class.superclass].include?(params) }
  elsif !params.nil? && params.instance_of?(Regexp)
    to_a.my_each { |item| return true if item.match(params) }
  else
    to_a.my_each { |item| return true if item == params }
  end
  false
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }

def my_none?(prms = nil)
  if block_given?
    !my_any?(&Proc.new)
  else
    !my_any?(prms)
  end
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }

def my_count(params = nil)
  i = 0
  if params.nil? && !block_given?
    to_a.my_each { |_item| i += 1 }
  elsif !params.nil?
    to_a.my_each { |item| i += 1 if item == params }
  else
    to_a.my_each { |item| i += 1 if yield(item) }
  end
  i
end
["Brian", "Susan", "Mandy", "John"].my_each {|friend| puts friend }