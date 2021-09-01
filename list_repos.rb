#!/usr/bin/ruby


def repo_details( dirname )

end


Dir.glob( '**/.git').sort.each do |directory|
    directory = File.dirname directory
    puts directory

end
