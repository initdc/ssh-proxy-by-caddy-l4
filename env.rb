#!/usr/bin/ruby -w

TargetPlatform = ENV.fetch('TARGETPLATFORM')
TPArray = TargetPlatform.split('/')

# ref https://github.com/containerd/containerd/blob/v1.4.3/platforms/defaults.go
OS = TPArray[0]
Architecture = TPArray[1]
Variant = TPArray[2].to_s[1]

puts "GOOS=#{OS} GOARCH=#{Architecture} GOARM=#{Variant}"

if Variant == ''
    `GOOS=#{OS} GOARCH=#{Architecture} xcaddy build --with github.com/mholt/caddy-l4 --output /root/caddy`
else
    `GOOS=#{OS} GOARCH=#{Architecture} GOARM=#{Variant}  xcaddy build --with github.com/mholt/caddy-l4 --output /root/caddy`
end
