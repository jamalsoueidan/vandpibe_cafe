# -*- encoding : utf-8 -*-
class QuestionsController < ApplicationController
  before_filter :authorize, :only => [:new, :edit, :create]
  after_filter :set_login_return_path, :only => [:index, :new, :hot, :unanswered, :recent, :show]
  
  def index
    @questions = Question.where(:visible => true).order('created_at DESC').paginate(:page => params[:page])
    @title = "Vandpibe Hvordan?"
    @description = "Hvis du ikke ved <strong>hvordan man laver en Vandpibe</strong>, <strong>hvor du køber en billig Vandpibe</strong>, eller <strong>hvordan du gør?</strong> Kan du oprette et spørgsmål her også vil der være andre bruger der vil svar dig."
  end
  
  def new
    @question = User.first.questions.new
  end
  
  def hot
    @questions = Question.joins(:comments).select('questions.*, count(comments.id) as total_comments').where(:visible => true).group('questions.id').having('total_comments > 0').order('total_comments DESC').paginate(:page => params[:page])
    @title = "Mest diskuterede spørgsmål"
    @description = "Listen over de mest diskuterede spørgsmål"
    render 'index'
  end
  
  def unanswered
    @questions = Question.joins('LEFT JOIN `comments` ON `comments`.`commentable_id` = `questions`.`id`').where('comments.id is NULL AND questions.visible=1').paginate(:page => params[:page])
    @title = "Ubesvaret spørgsmål"
    @description = "Listen over de ubesvarede spørgsmål"
    render 'index'
  end
  
  def recent
    @questions = Question.joins(:comments).group('questions.id').where(:visible => true).select('questions.*, MAX(comments.id) AS latest').order('latest DESC').paginate(:page => params[:page])
    @title = "Active spørgsmål"
    @description = "Listen over de active spørgsmål"
    render 'index'
  end
  
  def show
    @question = Question.find(params[:id])
    if @question.nil?
      redirect_to questions_path
    end
  end
  
  def destroy
    @question = Question.find(params[:id])
    if is_owner?(@question)
      @question.update_attribute(:visible, false)
    end
    
    redirect_to questions_path
  end
  
  def edit
    @question = Question.find(params[:id])
    redirect_to root_path unless is_owner?(@question)
  end
  
  def update
    @question = Question.find(params[:id])
    if is_owner?(@question)
      @question.update_attributes(params[:question])
      redirect_to question_path(@question.id, @question.title.parameterize), :notice => 'Spørgsmålet er nu opdateret'
    else
      redirect_to root_path 
    end
  end
  
  def create
    @question = current_user.questions.new(params[:question])
    @question.category_id = Question::CATEGORIES.index(params[:question][:category])
    if @question.save
      redirect_to question_path(@question.id, @question.title.parameterize)
    else
      render 'new.html.erb'
    end
  end

  def write_answer
    if request.post?
      @commentable = params[:comment][:table].classify.constantize.find(params[:comment][:table_id])
      @comment = @commentable.comments.build(params[:comment])
      @partial = @comment.commentable_type.pluralize.downcase!
      @html_tag = params[:comment][:table]
      @comment.user_id = current_user.id
      @comment.save
    end
  end
end