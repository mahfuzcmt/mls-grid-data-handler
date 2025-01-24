package com.bitsoft.cms

import grails.util.Holders
import org.springframework.web.multipart.MultipartFile

class FileUtil {

    public static String getRootPath(){
        return Holders.servletContext?.getRealPath("")
    }


    public static File makeDirectory(String path){
        File file = new File(path)
        if (!file.exists()){
            file.mkdirs()
        }
        return file
    }

//    request.getFile("productFile")
    public static String uploadcoachImage(Integer coachId, MultipartFile multipartFile){
        if (coachId && multipartFile){
            String coachImagePath = "${getRootPath()}coach-image/"
            makeDirectory(coachImagePath)
            multipartFile.transferTo(new File(coachImagePath, coachId + "-" + multipartFile.originalFilename))
            return multipartFile.originalFilename
        }
        return ""
    }
}
