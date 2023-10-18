![Repo1](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/Repo-SS/Title.png)

#### Prepared by: Hüseyin UZUNYAYLA / OgnitorenKs
- ► Discord: https://discord.gg/7hbzSGTYeZ
- ► Mail: ognitorenks@gmail.com
- ► Site: [https://ognitorenks.blospot.com](https://ognitorenks.blospot.com)
- Supported languages = English │ Turkish
- Türkçe açıklama: [https://github.com/OgnitorenKs/EasyDism/blob/main/README-TR.md](README-TR.md)

All rights of the work belong to Hüseyin UZUNYAYLA. It is forbidden to develop, copy, change the content of the work. If you want to share the application on different platforms, you need to get permission from me.

# EASYDISM

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/0.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/6.4.png)

- EasyDism works on x64 architectures of Windows 10 - 11 versions.
- Windows screen scaling setting may break Toolbox's window setting.

<details>
<B><summary> 1 - WIM │ ESD Reader</B></summary>

In this section you can view the contents of 'install.wim', 'instal.esd' and 'boot.wim'.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/1.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/1.2.png)

</details>

<details>
<B><summary> 2 - WIM ► Convert ESD</B></summary>

- You can convert install.wim to install.esd. 
- Esd conversion will compress install.wim considerably and reduce its size.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/2.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/2.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/2.3.png)

</details>

<details>
<B><summary> 3 - ESD ► Convert WIM</B></summary>

- You can convert install.esd to install.wim.
- To reprocess install.esd files, they must first be converted to install.wim.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/3.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/3.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/3.3.png)

</details>

<details>
<B><summary> 4 - Extract index</B></summary>

You can also use this section as an index eraser. Because the index deletion does not clean the junk files in install.wim, the size will not decrease. However, the 'index extractor' will not include junk files in the newly created install file, so if you have edited it before, the size will decrease.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/4.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/4.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/4.3.png)

If you have already extracted in this section and you forgot to get your files from the EasyDism folder, it offers an option for new operations. In other words, if there is an install.wim/esd file in the Output folder, it will warn you according to your extraction process.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/4.4.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/4.5.png)

</details>

<details>
<B><summary> 5 - Prepare All-in-one Windows [AIO]</B></summary>

It allows you to combine different versions of Windows into a single ISO. In other words, it allows you to create a single install.wim file with Windows 10 and Windows 11 versions together.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/5.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/5.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/5.3.png)

</details>

<details>
<B><summary> 6 - Mount Image [Mount]</B></summary>

Allows you to extract the image file to the directory. You cannot extract more than one image. Once the image is defined, it writes information about its contents to the main menu.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/6.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/6.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/6.3.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/6.4.png)

</details>

<details>
<B><summary> 7 - Install driver</B></summary>

Allows you to install drivers to indexed images. You can add the drivers you want to add in the 'Driver' folder in the installed directory of EasyDism. You can perform the installation process by clicking and running this section.

</details>

<details>
<B><summary> 8 - Load regedit</B></summary>

It allows you to integrate regedit records into the image. Put the '.reg' files you want to install into the 'Regedit' folder in the installed directory of EasyDism. You can then run this section and start the integration process. You will not find such advanced regedit registry integration in any other application.

</details>

<details>
<B><summary> 9 - Install update</B></summary>

It allows you to install updates into the mounted image. Put the update files you want to install into the 'Update' folder in the installed directory of EasyDism. You can then run this partition and perform the installation process. This section will also clean up the update trash files at the end of the process.

</details>

<details>
<B><summary> 10 - Format sonrası ilk açılışa batch script ekle</B></summary>

A script file is added to the mounted image that will run on the first boot of the system. In this script file you can add the script files you want to run on first boot.
- You can add .bat .cmd .cmd .vbs .vbs .ps1 script files to this section. Open the directory where EasyDism is installed and put the files in the ".Script-AfterSetup" folder.
- You can add an unattended program and install it on first boot. Open the directory where EasyDism is installed and put the files in the ".Script-AfterSetup" folder. Add only unattended programs.
- You can add .reg files that need to be applied on first boot. Open the directory where EasyDism is installed and put the files in the ".Script-AfterSetup" folder.
- You can add files to the desktop. Open the directory where EasyDism is installed and put the files in the ".Desktop-AfterSetup" folder. It will not add empty folders. It will add to the desktop as "EasyDism_OgnitorenKs" folder.

</details>


<details>
<B><summary> 11 - Mount Image [UnMount]</B></summary>

It collects the mounted system and turns it into install.wim. After you make edits to the mounted image, the size of install.wim may increase instead of decreasing. This is because the components we removed remain as garbage files. When this section collects the mounted image, it first extracts the indexes to a separate directory and then rebuilds them. This will reduce the size as the junk files are deleted.

- After the collection process, the image information in the main menu will be removed.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/10.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/10.2.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/10.3.png)

</details>

<details>
<B><summary> 12 - Prepare ISO</B></summary>

It allows you to prepare a suitable ISO for UEFI and Legacy BIOS installation. After the ISO is prepared, the folder where it was created will open. If there is an ISO with the same name that you have forgotten in your previous operations, it will warn you beforehand.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/11.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/11.2.png)

</details>

<details>
<B><summary> 13 - Define mount path</B></summary>

In this section, if you have an image that you have previously mounted, you can select and define it and then you can operate on EasyDism. After the definition, the main menu will display information about the image.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/10.1.png)
![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/6.4.png)


</details>

<details>
<B><summary> 14 - EasyDism change language</B></summary>

At startup, the default system language is automatically selected. You can use this section if you want to change it.

![Tool0](https://raw.githubusercontent.com/OgnitorenKs/EasyDism/main/.github/EN-SS/13.png)

</details>