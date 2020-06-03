<?php declare(strict_types=1);
/**
 * @author Marco Spengler <MaSpeng@outlook.de>
 */

namespace MaSpeng\PhpCiSandbox\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    /**
     * @Route("/", name="home")
     */
    public function index(): Response
    {
        return $this->json(
            [
                'message' => 'Welcome to your new controller!',
            ]
        );
    }
}
