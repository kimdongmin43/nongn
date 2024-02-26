package kr.apfs.local.common.web.view;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.view.AbstractView;

import kr.apfs.local.common.util.ObjUtil;

public class JqGridViewResolver extends AbstractView {
    private Logger logger = LoggerFactory.getLogger(JqGridViewResolver.class);
    public final static String CONTENTS_TYPE = "text/json; charset=UTF-8";

    @Override
    protected void renderMergedOutputModel(Map map, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        response.setContentType(CONTENTS_TYPE);
        response.setHeader("Cache-Control", "no-cache");

        PrintWriter writer = response.getWriter();
        try {
            String rv = ObjUtil.toJsonStr(map);
            writer.print(rv);
            writer.flush();

            logger.debug("JSON: {} ",  rv.substring(0,100));
        } finally {
            if (writer != null) {
                writer.close();
            }
        }
    }

}
