
function isDevToolsOpen() {
      const threshold = 160;
      const widthThreshold = window.outerWidth - window.innerWidth > threshold;
      const heightThreshold = window.outerHeight - window.innerHeight > threshold;
      return widthThreshold || heightThreshold;
    }

function getDeviceInfo() {
      try {
        var userAgent = navigator.userAgent;
        var browserName;
        if (userAgent.match("/chrome|chromium|crios/i")) {
          browserName = "chrome";
        } else if (userAgent.match("/firefox|fxios/i")) {
          browserName = "firefox";
        } else if (userAgent.match("/safari/i")) {
          browserName = "safari";
        } else if (userAgent.match("/opr/i")) {
          browserName = "opera";
        } else if (userAgent.match("/edg/i")) {
          browserName = "edge";
        } else {
          browserName = null;
        }
        var device = getOsName();
        return browserName + ":" + device;
      } catch (error) {
        console.log('GetDeviceInfo Failed: ', error);
      }
    }

function getOsName() {
      'use strict';
      var module = {
        options: [],
        header: [navigator.platform, navigator.userAgent, navigator.appVersion, navigator.vendor, window.opera],
        dataos: [
          { name: 'Windows Phone', value: 'Windows Phone', version: 'OS' },
          { name: 'Windows', value: 'Win', version: 'NT' },
          { name: 'iPhone', value: 'iPhone', version: 'OS' },
          { name: 'iPad', value: 'iPad', version: 'OS' },
          { name: 'Kindle', value: 'Silk', version: 'Silk' },
          { name: 'Android', value: 'Android', version: 'Android' },
          { name: 'PlayBook', value: 'PlayBook', version: 'OS' },
          { name: 'BlackBerry', value: 'BlackBerry', version: '/' },
          { name: 'Macintosh', value: 'Mac', version: 'OS X' },
          { name: 'Linux', value: 'Linux', version: 'rv' },
          { name: 'Palm', value: 'Palm', version: 'PalmOS' }
        ],
        databrowser: [
          { name: 'Chrome', value: 'Chrome', version: 'Chrome' },
          { name: 'Firefox', value: 'Firefox', version: 'Firefox' },
          { name: 'Safari', value: 'Safari', version: 'Version' },
          { name: 'Internet Explorer', value: 'MSIE', version: 'MSIE' },
          { name: 'Opera', value: 'Opera', version: 'Opera' },
          { name: 'BlackBerry', value: 'CLDC', version: 'CLDC' },
          { name: 'Mozilla', value: 'Mozilla', version: 'Mozilla' }
        ],
        init: function () {
          var agent = this.header.join(' '),
            os = this.matchItem(agent, this.dataos),
            browser = this.matchItem(agent, this.databrowser);

          return { os: os, browser: browser };
        },
        matchItem: function (string, data) {
          var i = 0,
            j = 0,
            html = '',
            regex,
            regexv,
            match,
            matches,
            version;
          for (i = 0; i < data.length; i += 1) {
            regex = new RegExp(data[i].value, 'i');
            match = regex.test(string);
            if (match) {
              regexv = new RegExp(data[i].version + '[- /:;]([\\d._]+)', 'i');
              matches = string.match(regexv);
              version = '';
              if (matches) { if (matches[1]) { matches = matches[1]; } }
              if (matches) {
                matches = matches.split(/[._]+/);
                for (j = 0; j < matches.length; j += 1) {
                  if (j === 0) {
                    version += matches[j] + '.';
                  } else {
                    version += matches[j];
                  }
                }
              } else {
                version = '0';
              }
              return {
                name: data[i].name,
                version: parseFloat(version)
              };
            }
          }
          return { name: 'unknown', version: 0 };
        }
      };
      var e = module.init();
      return e.os.name + "-" + e.os.version;
    }

async function readOtp() {
    if (!('OTPCredential' in window)) {return null;}
    try {
                const content = await navigator.credentials.get({
                  otp: { transport: ['sms'] },
                  signal: new AbortController().signal
                });

                return content.code;
              } catch (err) {
                console.error('OTP read error', err);
                return null;
              }
}

window.transcode = transcode;
let ffmpegInstance = null;

async function loadFFmpeg() {
     if(ffmpegInstance){
        console.log('ffmpeg.loaded last instance');
        return ffmpegInstance;
     }
     const { FFmpeg } = FFmpegWASM;
     const baseURL = `${window.location.origin}/ffmpeg`;
     const ffmpeg = new FFmpeg({log:false});
     await ffmpeg.load({
         coreURL: `${baseURL}/ffmpeg-core.js`,
         wasmURL: `${baseURL}/ffmpeg-core.wasm`,
     });
     console.log('ffmpeg.loaded');
     ffmpegInstance = ffmpeg;
     return ffmpegInstance;
    }

async function transcode(inputArrayBuffer,rotate = 0) {
     let vf = null;
     switch(rotate){
        case 90: vf = 'transpose=1'; break;
        case 180: vf = 'rotate=PI'; break;
        case 270:vf = 'transpose=2'; break;
     }

     async function deleteFFmpegFile(ffmpeg, path) {
          try {
               if (typeof ffmpeg.deleteFile === 'function') {
                    await ffmpeg.deleteFile(path);
                    return;
               }
               if (typeof ffmpeg.FS === 'function') {
                    ffmpeg.FS('unlink', path);
                    return;
               }
               if (typeof ffmpeg.unlink === 'function') {
                    await ffmpeg.unlink(path);
                    return;
               }
               console.log('No supported FFmpeg delete API for', path);
          } catch (e) {
               console.log("Failed to delete FFmpeg file:", path, e);
          }
     }

     console.log('ffmpeg.init');
     const ffmpeg = await loadFFmpeg();
     console.log('ffmpeg.start');



     await ffmpeg.writeFile('input.webm', new Uint8Array(inputArrayBuffer));

     const args = ['-i', 'input.webm',];
     if(vf != null) args.push('-vf',vf);
     args.push('-c:v','libx264','-preset', 'ultrafast','-crf','28','-c:a','aac','-movflags', '+faststart','output.mp4');

     await ffmpeg.exec(args);
     const data = await ffmpeg.readFile('output.mp4');
     console.log('ffmpeg.done');

     await deleteFFmpegFile(ffmpeg, 'input.webm');
     await deleteFFmpegFile(ffmpeg, 'output.mp4');
     // Return an ArrayBuffer so Dart can read it as a ByteBuffer/Uint8List
     // without relying on JSArray -> List conversions.
     return data.buffer.slice(data.byteOffset, data.byteOffset + data.byteLength);
    }

async function checkFFmpegVersion() {
  const ffmpeg = await loadFFmpeg();
  const versionOutput = await ffmpeg.exec(['-version']);
  console.log('FFmpeg version:', versionOutput);
}

window.checkFFmpegVersion = checkFFmpegVersion;


