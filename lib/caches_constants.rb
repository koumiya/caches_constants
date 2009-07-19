# CachesConstants
ActiveRecord::Base.class_eval do
  def self.caches_constants(additional = {})
    options = {:name => :name, :order => :sort_order}.merge(additional)
    all = all(:order => options[:order]).each do |m|
      const_set(m.send(options[:name]).upcase, m)
    end
    const_set(:ALL, all)
  end
end