class TestJob
  include SuckerPunch::Job

  def perform
    sleep 1
    puts "starting job..."
    sleep 5
    puts "job ready!"
    TestJob.perform_in(10.seconds)
  end
end