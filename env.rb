#!/usr/bin/ruby -w

TargetPlatform = ENV.fetch('TARGETPLATFORM')
TPArray = TargetPlatform.split('/')

# ref https://github.com/containerd/containerd/blob/v1.4.3/platforms/defaults.go
OS = TPArray[0]
Architecture = TPArray[1]
Variant = TPArray[2].to_s[1]

puts "GOOS=#{OS} GOARCH=#{Architecture} GOARM=#{Variant}"

if Architecture == 'arm' && Variant != ''
    `wget "https://caddyserver.com/api/download?os=#{OS}&arch=arm&arm=#{Variant}&p=github.com%2Fmholt%2Fcaddy-l4" -O /root/caddy && chmod +x /root/caddy`
else
    `wget "https://caddyserver.com/api/download?os=#{OS}&arch=#{Architecture}&p=github.com%2Fmholt%2Fcaddy-l4" -O /root/caddy && chmod +x /root/caddy`
end
