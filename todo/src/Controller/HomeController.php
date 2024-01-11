<?php

namespace App\Controller;

use App\Entity\Tasks;
use App\Entity\Categories;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\HttpFoundation\Request;


class HomeController extends AbstractController
{
    #[Route('{_locale<en|fr>}/', name: 'app_home')]
    public function index(EntityManagerInterface $entityManager, Request $request): Response
    {

        $local= $request -> getlocale();
        $tasks = $entityManager->getRepository(Tasks::class)->findBy(['user_id' => $this->getUser()]);
        return $this->render('home/index.html.twig', [
            'controller_name' => 'HomeController',
            'tasks' => $tasks,
            'local' => $local,
        ]);
    }

    #[Route('{_locale<en|fr>}/categories', name: 'app_categories')]
    public function categories(EntityManagerInterface $entityManager,Request $request): Response
    {
        
        $local= $request -> getlocale();
        $tasks = $entityManager->getRepository(Tasks::class)->findBy(['user_id' => $this->getUser()]);
        return $this->render('categories/index.html.twig', [
            'local' => $local,
            'tasks' => $tasks,
        ]);
    }

    #[Route('{_locale<en|fr>}/add', name: 'app_add_tasks')]
    public function add(EntityManagerInterface $entityManager, Request $request): Response
    {
        $local= $request -> getlocale();
        $task = new Tasks();
        $task->setDueDate(new \DateTimeImmutable('tomorrow'));

        $form = $this->createFormBuilder($task)
            ->add('name', TextType::class, [
                'label' => 'Nom de la tâche : ',
                "attr"=>["class"=>"w-100 mb-3", "placeholder"=> "Task name"],
                ])
            ->add('duedate', DateType::class, [
                'label' => 'Date : ',
                "attr"=>["class"=>"w-100 mb-3"],
                ])
            ->add('description', TextareaType::class, [
                'label' => 'Description : ',
                "attr"=>["class"=>"w-100 mb-3", "placeholder"=>"Description"],
                ])
            ->add('priority', ChoiceType::class, [
                'label' => 'Priorité : ',
                "attr"=>["class"=>"w-100 mb-3"],
                'choices' => [
                    'Urgent' => 'Urgente',
                    'Medium' => 'Moyenne',
                    'Low' => 'Basse'
                ]
            ])
            ->add('category', EntityType::class, [
                'class' => Categories::class,
                "attr"=>["class"=>"w-100 mb-3"],
                'placeholder' => 'Select a category',
                'choice_label' => 'name'

            ])
            ->add('save', SubmitType::class, [
                'label' => 'Create task',
                'attr' => ['class' => 'btn btn-secondary w-100']
                


            ])
            ->getForm();



        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {
            // $form->getData() holds the submitted values
            // but, the original `$task` variable has also been updated
            $task = $form->getData();
            $task->setUserId($this->getUser());
            // tell Doctrine you want to (eventually) save the task (no queries yet)
            $entityManager->persist($task);

            // actually executes the queries (i.e. the INSERT query)
            $entityManager->flush();
            // ... perform some action, such as saving the task to the database
            $this->addFlash(
                'success',
                'La tâche a bien été ajoutée !'
            );


            return $this->redirectToRoute('app_home');
        }

        return $this->render('home/add.html.twig', [
            'form' => $form,
            'local' => $local,
        ]);
    }

    // Route pour éditer les tâches
    #[Route('{_locale<en|fr>}/edit/{id}', name: 'app_edit_tasks')]
    public function edit(EntityManagerInterface $entityManager, int $id, Request $request): Response
    {
        $local= $request -> getlocale();
        $task = $entityManager->getRepository(Tasks::class)->find($id);

        $form = $this->createFormBuilder($task)
            ->add('name', TextType::class, ['label' => 'Nom de la tâche : ',
            "attr"=>["class"=>"w-100 mb-3"],])
            ->add('duedate', DateType::class, ['label' => 'Date : ',
            "attr"=>["class"=>"w-100 mb-3"],])
            ->add('description', TextareaType::class, [
                'label' => 'Description : ',
                "attr"=>["class"=>"w-100 mb-3"]])
            ->add('priority', ChoiceType::class, [
                'label' => 'Priorité : ',
                "attr"=>["class"=>"w-100 mb-3"],
                'choices' => [
                    'Urgent' => 'Urgente',
                    'Medium' => 'Moyenne',
                    'Low' => 'Basse'
                ]
            ])
            ->add('category', EntityType::class, [
                'class' => Categories::class,
                'placeholder' => 'Select a category',
                "attr"=>["class"=>"w-100 mb-3"],
                'choice_label' => 'name'

            ])
            ->add('save', SubmitType::class, [
                'label' => 'Edit task',
                'attr' => ['class' => 'btn btn-secondary w-100']


            ])
            ->getForm();

        $form->handleRequest($request);
        if ($form->isSubmitted() && $form->isValid()) {

            if (!$task) {
                throw $this->createNotFoundException(
                    "Aucun produit trouvé l'id " . $id
                );
            }
            $task = $form->getData();


            // ... perform some action, such as saving the task to the database
            // tell Doctrine you want to (eventually) save the Product (no queries yet)
            $entityManager->persist($task);

            // actually executes the queries (i.e. the INSERT query)
            $entityManager->flush();

            $this->addFlash(
                'success',
                'The task has been modified'
            );

            return $this->redirectToRoute('app_home');
        }

        return $this->render('home/add.html.twig', [
            'form' => $form,
            'local' => $local,
        ]);
    }
    // Route pour supprimer les tâches
    #[Route('/delete/{id}', name: 'app_delete_tasks')]
    public function delete(EntityManagerInterface $entityManager, int $id)
    {
        $task = $entityManager->getRepository(Tasks::class)->find($id);
        $entityManager->remove($task);
        $entityManager->flush();

        $this->addFlash(
            'success',
            'La tâche a bien été supprimée !'
        );

        return $this->redirectToRoute('app_home');
    }


}
