namespace :db do
  desc "test adding method to hydroserver"
  task :cuahsi_test_method => :environment do |task, args|

  	data = Instrument.create_cuahsi_method(2)
    puts data

    uri = URI.parse("http://hydroportal.cuahsi.org/CHORDS/index.php/default/services/api/methods")

    request = Net::HTTP::Post.new uri.path
    request.body = data.to_json
    request['Content-Type'] = 'application/json'

    response = Net::HTTP.start(uri.host, uri.port, :use_ssl => false) do |http|
      response = http.request request
    end
    puts response.inspect

    puts "done"
  end
end
