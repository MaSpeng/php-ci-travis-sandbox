<?php declare(strict_types=1);
/**
 * This file is part of the gitlab-php-ci-sandbox project.
 *
 * @author Marco Spengler <MaSpeng@outlook.de>
 */

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * Home controller class
 *
 * @package App\Controller
 */
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
