package org.iclass.mvc.controller;

import lombok.extern.slf4j.Slf4j;
import org.iclass.mvc.dto.Community;
import org.iclass.mvc.dto.CommunityComments;
import org.iclass.mvc.service.CommunityService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDate;

@RequestMapping("/community")
@Slf4j
@Controller
public class CommunityController {
    private final CommunityService service;
    private CommunityController(CommunityService service){
        this.service=service;
    }

    @GetMapping("/list")
    public void list(@RequestParam(defaultValue = "1")
                         int page, Model model){
        model.addAttribute("list",service.pagelist(page).get("list"));
        model.addAttribute("paging",service.pagelist(page).get("paging"));
        model.addAttribute("today", LocalDate.now());

    }
    @GetMapping("/read")
    public  void read(long idx,@ModelAttribute("page") int page, Model model){
        model.addAttribute("vo",service.read(idx));
        model.addAttribute("cmtlist",service.commentsList(idx));
    }
    @GetMapping("/write")
    public  void write(){
        //글쓰기 GET 요청은 view name 만 지정하고 끝
    }
    @PostMapping("/write")
    public  String save(Community dto, RedirectAttributes reAttr){
        service.insert(dto);
        reAttr.addFlashAttribute("message","글 등록이 완료되었습니다.");

        return "redirect:/community/list";
    }
    @PostMapping("/update")
    public void update(long idx, @ModelAttribute("page") int page,Model model){
        model.addAttribute("vo", service.selectByIdx(idx));

    }
    @PostMapping("/updateAction")
    public String updateAction(int page, Community dto,
                               RedirectAttributes redirectAttributes){
        service.update(dto);
        redirectAttributes.addAttribute("idx",dto.getIdx());
        redirectAttributes.addAttribute("page",page);
        redirectAttributes.addAttribute("message","글 수정이 완료되었습니다.");
        return "redirect:/community/read";
    }
    @PostMapping("/delete")
    public String delete(@ModelAttribute("page") int page, Long idx,
                         RedirectAttributes reAttr){
        service.delete(idx);
        reAttr.addFlashAttribute("message","글 삭제가 완료되었습니다.");

        return "redirect:/community/list";
    }
    @PostMapping("/comments")
    public String comments(int page, int f, CommunityComments dto,
                           RedirectAttributes redirectAttributes){
        log.info(">>>>>>>>>>>>>> dto :{}",dto);
        service.comments(dto,f);
        redirectAttributes.addAttribute("page",page);
        redirectAttributes.addAttribute("idx",dto.getMref());
        if(f==1){
            redirectAttributes.addFlashAttribute("message","댓글 등록이 완료되었습니다.");

        }
        else if(f==2){
            redirectAttributes.addFlashAttribute("message","댓글 삭제가 완료되었습니다.");
        }
        return "redirect:/community/read";
    }
}
