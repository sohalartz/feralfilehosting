
In SSH do the commands described in this FAQ. If you do not know how to SSH into your slot use this FAQ: [SSH basics - Putty](https://www.feralhosting.com/faq/view?question=12)

Your FTP / SFTP / SSH login information can be found on the Slot Details page for the relevant slot. Use this link in your Account Manager to access the relevant slot:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_link.png)

You login information for the relevant slot will be shown here:

![](https://raw.github.com/feralhosting/feralfilehosting/master/Feral%20Wiki/0%20Generic/slot_detail_ssh.png)

**Important note:** FeralHosting does not allow gameservers of any type, especially those based on Java.  Java-based applications that consume large amounts of memory and other resources will also not be tolerated; this includes BTC/LTC mining and encoding

If you need java 1.6 it's likely already installed by request of another user. If not, open a ticket and request it to be installed.

If you need a newer version of Java, such as 1.7, follow these directions. These directions can be adapted to support any version of Java.
    
Installing Java locally
---

Use this command to create the `~/bin` directory and reload your shell for this change to take effect.

~~~
mkdir -p ~/bin && bash
~~~

Files found via [http://www.java.com/en/download/manual.jsp?locale=en](http://www.java.com/en/download/manual.jsp?locale=en). You want the `.tar.gz` file, not the `.deb` or `.rpm` -- those are used when you are installing with root privileges.
     
This method will download and install/update the 64 bit Java files for Linux

### Java 1.7 U75

Download v7:

~~~
wget -O ~/java.tar.gz http://javadl.sun.com/webapps/download/AutoDL?BundleId=101460
~~~

Unpack the files:

~~~
tar xf ~/java.tar.gz --strip-components=1 -C ~/
~~~

### Java 1.8 U45

Download v8:

~~~
wget -qO ~/java.tar.gz http://javadl.sun.com/webapps/download/AutoDL?BundleId=106240
~~~

Unpack the files:

~~~
tar xf ~/java.tar.gz --strip-components=1 -C ~/
~~~

This command also removes the folders and archives we don't need after we are done with them.

Manually call `java` it like this:

~~~
~/bin/java -version
~~~

You will see this for Java 7:

~~~
java version "1.7.0_75"
Java(TM) SE Runtime Environment (build 1.7.0_75-b13)
Java HotSpot(TM) 64-Bit Server VM (build 24.75-b04, mixed mode)
~~~

or this for Java 8:

~~~
java version "1.8.0_45"
Java(TM) SE Runtime Environment (build 1.8.0_45-b14)
Java HotSpot(TM) 64-Bit Server VM (build 25.45-b02, mixed mode)
~~~

Unless you used the `-version` command before installing the update can just do this command below, otherwise log into a new SSH session for the changes to take effect and then check your version again.

~~~
java -version
~~~

You should see the same result as before.



