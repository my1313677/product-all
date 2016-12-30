package com.ofweek.live.web.wap.action;

import com.ofweek.live.core.common.web.BaseController;
import com.ofweek.live.core.modules.sys.security.SystemAuthorizingRealm;
import com.ofweek.live.core.modules.sys.utils.UserUtils;
import com.ofweek.live.web.sys.action.LoginController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by tangqian on 2016/9/28.
 */
@Controller
public class WapLoginController extends BaseController {

    /**
     * 管理登录
     */
    @RequestMapping(value = "wap/login", method = RequestMethod.GET)
    public String login(@RequestParam(required = false) String callback, HttpServletRequest request, HttpServletResponse response, Model model) {
        SystemAuthorizingRealm.Principal principal = UserUtils.getPrincipal();
        // 如果已经登录，则跳转到首页
        if (principal != null) {
            LoginController.isValidateCodeLogin(principal.getAccount(), principal.getType(), false, true);
            return "redirect:/wap";
        }
        model.addAttribute("callback", callback);
        return "modules/wap/wapLogin";
    }
}
