class Foo < ActiveRecord::Base
  include SimpleStates

  states :created, :started, :finished

  event :start,  :from => :created, :to => :started,  :if => :startable?
  event :finish, :to => :finished, :after => :cleanup

  attr_accessor :state, :started_at, :finished_at

  def start
    "Iniciado"
  end

  def startable?
    true
  end

  def cleanup
      "Limpiado"
  end
end



