# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) alpine-base
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/alpine-base/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/alpine-base/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/alpine-base.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/alpine-base.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/alpine-base/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/alpine-base/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)
[![dockeri.co](https://dockeri.co/image/dsuite/alpine-base)](https://hub.docker.com/r/dsuite/alpine-base)


Based on [Alpine][alpine], this image included mandatory packages and tools for [docker-suite (dsuite)][docker-suite] images.


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) What's in this image

This image is built on top of [Alpine][alpine] and is aimed to be run as root user.
Cron is enable by default.


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Packages included

<table>
  <tbody>
    <tr>
      <td><code>bash</code></td>
      <td>https://tiswww.case.edu/php/chet/bash/bashtop.html</td>
    </tr>
    <tr>
      <td><code>curl</code></td>
      <td>https://curl.haxx.se</td>
    </tr>
    <tr>
      <td><code>grep</code></td>
      <td>http://www.gnu.org/software/grep</td>
    </tr>
    <tr>
      <td><code>jq</code></td>
      <td>https://stedolan.github.io/jq</td>
    </tr>
    <tr>
      <td><code>logrotate</code></td>
      <td>https://github.com/logrotate/logrotate</td>
    </tr>
    <tr>
      <td><code>procps</code></td>
      <td>https://gitlab.com/procps-ng/procps</td>
    </tr>
    <tr>
      <td><code>sed</code></td>
      <td>http://www.gnu.org/software/sed</td>
    </tr>
    <tr>
      <td><code>shadow</code></td>
      <td></td>
    </tr>
    <tr>
      <td><code>su-exec</code></td>
      <td>https://github.com/ncopa/su-exec</td>
    </tr>
    <tr>
      <td><code>tini</code></td>
      <td>https://github.com/krallin/tini</td>
    </tr>
  </tbody>
</table>


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Utilities

<table>
 <tbody>
  <tr>
   <td><code>/usr/local/sbin/apk-cleanup</code></td>
   <td>Clear apk's cache</td>
  </tr>
  <tr>
   <td><code>/usr/local/sbin/apk-install</code></td>
   <td>Add packages</td>
  </tr>
  <tr>
   <td><code>/usr/local/sbin/apk-remove</code></td>
   <td>Remove packages</td>
  </tr>
  <tr>
   <td><code>/usr/local/sbin/apk-upgrade</code></td>
   <td>Upgrade currently installed packages</td>
  </tr>
  <tr>
   <td><code>/usr/local/sbin/gh-downloader</code></td>
   <td><a href="https://github.com/bash-suite/gh-downloader" >Simple utility to download files from GitHub Repository</a></td>
  </tr>
  <tr>
   <td><code>/usr/local/sbin/templater</code></td>
   <td><a href="https://github.com/bash-suite/templater" >Simple templating system that replaces {{VAR}} by the value of $VAR</a></td>
  </tr>
  <tr>
   <td><code>/usr/local/sbin/wait-host</code></td>
   <td><a href="https://github.com/bash-suite/wait-host" >Wait for host and TCP port availability</a></td>
  </tr>
  <tr>
   <td><code>/usr/local/sbin/mvlink</code></td>
   <td><a href="https://github.com/bash-suite/mvlink" >Move ORIGIN (file or folder) to DEST and create a symbolic ORIGIN to DEST</a></td>
  </tr>
  <tr>
   <td><code>/usr/local/lib/bash-logger.sh</code></td>
   <td><a href="https://github.com/bash-suite/bash-logger" >Bash Logger designed to incorporate PSR-3 compliance</a></td>
  </tr>
  <tr>
   <td><code>/usr/local/lib/persist-env.sh</code></td>
   <td><a href="https://github.com/bash-suite/persist-env">set or unset system wide environment variable</a></td>
  </tr>
 </tbody>
</table>


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Environment variables

Have a look at the following table to see all supported environment variables for each Docker image.

<table>
 <thead>
  <tr>
   <th>Variable</th>
   <th>Type</th>
   <th>Default</th>
   <th>Description</th>
  </tr>
 </thead>
 <tbody>
  <tr>
   <td><code>DEBUG_LEVEL</code></td>
   <td>int</td>
   <td><code>NOTICE</code></td>
   <td>Set debug level for startup.<br/>See <a href="https://github.com/bash-suite/bash-logger#logging-levels">bash-logger</a> for logging levels</td>
  </tr>
  <tr>
   <td><code>BOOT_DELAY</code></td>
   <td>int</td>
   <td></td>
   <td>Delay in second before stating up the container entrypoint
   <br/>To wait for a database or a web site to be online, prefer using <code>wait-host</code></td>
  </tr>
  <tr>
   <td><code>HTTP_PROXY</code><br/><br/><code>http_proxy</code></td>
   <td>string</td>
   <td></td>
   <td>Make sure that proxy defined in <code>HTTP_PROXY</code> or <code>http_proxy</code> is well formated</td>
  </tr>
  <tr>
   <td><code>HTTPS_PROXY</code><br/><br/><code>https_proxy</code></td>
   <td>string</td>
   <td></td>
   <td>Make sure that proxy defined in <code>HTTPS_PROXY</code> or <code>https_proxy</code> is well formated</td>
  </tr>
  <tr>
   <td><code>TIMEZONE</code><br/><br/><code>TZ</code></td>
   <td>string</td>
   <td><code>UTC</code></td>
   <td>Set docker OS timezone.<br/>(Example: <code>Europe/Paris</code>)</td>
  </tr>
  <tr>
    <td colspan="4"></td>
  </tr>
  <tr>
   <td><code>USER</code></td>
   <td>string</td>
   <td></td>
   <td>Sets the user name to use when running the main process <code>PID 1</code>
   <br/><br/><sub>(Do not use the <code>USER</code> instruction in your Dockerfile).</sub></td>
  </tr>
 </tbody>
</table>


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Volumes

<table>
 <tbody>
  <tr>
   <td><code>/startup.d</code></td>
   <td>Any scripts ending by <code>*.sh</code> found in this directory will be <strong>sourced</strong> at the very beginning.</td>
  </tr>
  <tr>
   <td><code>/startup.1.d</code></td>
   <td>Any executable scripts ending by <code>*.sh</code> found in this directory will be <strong>executed</strong> during startup.</br></br><sub>(before <code>/startup.2.d</code>)</sub></td>
  </tr>
  <tr>
   <td><code>/startup.2.d</code></td>
   <td>Any executable scripts ending by <code>*.sh</code> found in this directory will be <strong>executed</strong> during startup.</br></br><sub>(after <code>/startup.1.d</code>)</sub>
   </td>  
  </tr>
 </tbody>
</table>

[alpine]: http://alpinelinux.org/
[docker-suite]: https://github.com/docker-suite/
