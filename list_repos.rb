#!/usr/bin/ruby


def repo_details( dirname )

end


Dir.glob( '**/.git') do |directory|
    directory = File.dirname directory
    puts directory

end
