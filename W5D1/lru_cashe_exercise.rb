class LRUCache
    def initialize(n)
         @cache = Array.new(n)
    end

    def count
      # returns number of elements currently in cache
      @cache.count
    end

    def add(el)
      # adds element to cache according to LRU principle
        if @cache.include?(el)
            @cache.delete(el) 
            @cache << nil
        end
            
        (0...@cache.count).each do |i|
            if @cache[i] == nil
                @cache[i] = el
                return nil  
            end
        end

        @cache.shift
        @cache << el
    end

    def show
      # shows the items in the cache, with the LRU item first
        p @cache
    end

    private
    # helper methods go here!
    attr_reader :cache
  end

  johnny_cache = LRUCache.new(4)

  johnny_cache.add("I walk the line")
  johnny_cache.add(5)

  johnny_cache.count # => returns 2

  johnny_cache.add([1,2,3])
  johnny_cache.add(5)
  johnny_cache.add(-5)
  johnny_cache.add({a: 1, b: 2, c: 3})
  johnny_cache.add([1,2,3,4])
  johnny_cache.add("I walk the line")
  johnny_cache.add(:ring_of_fire)
  johnny_cache.add("I walk the line")
  johnny_cache.add({a: 1, b: 2, c: 3})


  johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]