# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) alpine-base
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg)](https://opensource.org/licenses/MIT)

Based on [Alpine][alpine], this image included mandatory packages and tools for [docker-suite (dsuite)][docker-suite] images.


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
   <td><a href="https://github.com/bash-suite/bash-logger" >Bash Logger designed to incorperate PSR-3 compliance</a></td>
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
   <th>Env Variable</th>
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
   <td>Delay in second before stating up the container entrypoint</td>
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
   <td><code>NEW_UID</code></td>
   <td>int</td>
   <td><code>1000</code></td>
   <td>Define a user with a new <code>uid</code> in order to syncronize file system permissions with your host computer and the Docker container. You should use a value that matches your host systems local user.<br/><br/><sub>(Type <code>id -u</code> for your uid).</sub></td>
  </tr>
  <tr>
   <td><code>NEW_GID</code></td>
   <td>int</td>
   <td><code>1000</code></td>
   <td>Define a group with a new <code>gid</code> in order to syncronize file system permissions with your host computer and the Docker container. You should use a value that matches your host systems local group.<br/><br/><sub>(Type <code>id -g</code> for your gid).</sub></td>
  </tr>
 </tbody>
</table>


[alpine]: http://alpinelinux.org/
[docker-suite]: https://github.com/docker-suite/
