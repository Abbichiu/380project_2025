package hkmu.wadd.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.net.InetAddress;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.CopyOnWriteArrayList;

@Controller
public class IndexController {
    private final Map<Integer, String> products = new ConcurrentHashMap<>();
    public  IndexController(){
        this.products.put(1, "Sandpaper");
        this.products.put(2, "Nails");
        this.products.put(3, "Glue");
        this.products.put(4, "Paint");
        this.products.put(5, "Tape");
    }


    @GetMapping("/")
    public String index() {
        return "redirect:/ticket/list";
    }

    @GetMapping("/login")
    public String login() {

        return "login";
    }
    @GetMapping("/checkboxes")
    public String multiValueForm() {
        return "MultiValueForm";
    }
    @PostMapping("/checkboxes")
    public String multiValueResult() {
        return "MultiValueResult";
    }
    @GetMapping("/do/*")
    public String recordSessionActivity(HttpServletRequest request, HttpSession session) {
        if (session.getAttribute("activity") == null)
            session.setAttribute("activity", new CopyOnWriteArrayList<PageVisit>());

        @SuppressWarnings("unchecked")
        CopyOnWriteArrayList<PageVisit> visits
                = (CopyOnWriteArrayList<PageVisit>) session.getAttribute("activity");
        if (!visits.isEmpty()) {
            PageVisit last = visits.get(visits.size() - 1);
            last.setLeftTimestamp(System.currentTimeMillis());
        }

        PageVisit now = new PageVisit();
        now.setEnteredTimestamp(System.currentTimeMillis());
        if (request.getQueryString() == null)
            now.setRequest(request.getRequestURL().toString());
        else
            now.setRequest(request.getRequestURL() + "?" + request.getQueryString());
        try {
            now.setIpAddress(InetAddress.getByName(request.getRemoteAddr()));

        } catch (java.net.UnknownHostException e) {
            throw new RuntimeException(e);
        }
        visits.add(now);
        return "viewSessionActivity";
    }


    @GetMapping("/shop")
    public String shop(HttpServletRequest request, HttpSession session) {
        String action = request.getParameter("action");
        if (action == null)
            action = "browse";

        switch (action) {
            case "addToCart":
                return this.addToCart(request, session);
            case "viewCart":
                return this.viewCart(request);
            case "emptyCart":
                return this.emptyCart(session);
            case "browse":
            default:
                return this.browse(request);
        }
    }
    // Defining other methods ...
    private String viewCart(HttpServletRequest request) {
        request.setAttribute("products", this.products);
        return "viewCart";
    }

    private String browse(HttpServletRequest request) {
        request.setAttribute("products", this.products);
        return "browse";
    }
    private String addToCart(HttpServletRequest request, HttpSession session) {
        int productId;
        try {
            productId = Integer.parseInt(request.getParameter("productId"));
        } catch (Exception e) {
            return "redirect:/shop";
        }

        if (session.getAttribute("cart") == null)
            session.setAttribute("cart", new ConcurrentHashMap<>());

        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart
                = (Map<Integer, Integer>) session.getAttribute("cart");
        if (!cart.containsKey(productId))
            cart.put(productId, 0);
        cart.put(productId, cart.get(productId) + 1);

        return "redirect:/shop?action=viewCart";
    }

    private String emptyCart(HttpSession session) {
        session.removeAttribute("cart");
        return "redirect:/shop?action=viewCart";
    }
}



