class JobsController < ApplicationController

    before_action :find_job, only: [:show, :edit, :update, :destroy]

    def index
        if params[:category].blank?
          @jobs = Job.all.order("created_at DESC")
        else
          #這邊會接收到剛剛params category 的變數 ，並去尋找name的資料有哪，並指找出ＩＤ後
          @category_id = Category.find_by(name: params[:category]).id
          #只顯示找到name的ＩＤ工作
          @jobs = Job.where(category_id: @category_id).order("created_at DESC")
        end
    end
    
    def show
    end
    
    def new
      @job = Job.new
    end
    
    def create
      @job = Job.new(job_params)
     if @job.save
        redirect_to @job, notice: "Job was successfully created"
      else
        render 'new'
      end
    end
    
    def edit
      end
    
    def update
      if @job.update(job_params)
        redirect_to @job, notice: "Job was successfully updated"
      else
        render 'edit'
      end
    end
    def destroy
    @job.destroy
    redirect_to root_path
    end
    
    
    
    private
    
    def job_params
      params.require(:job).permit(:title, :description, :company , :url,:category_id)
    end
    
    def find_job
      @job = Job.find(params[:id])
    end





end
